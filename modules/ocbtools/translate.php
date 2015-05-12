<?php

$Module = $Params['Module'];
$objectId = $Params['ObjectID'];
$http = eZHTTPTool::instance();

$object = eZContentObject::fetch( $objectId );

$fromLanguageCode = $http->variable( 'FromContentObjectLanguageCode', false );
$fromLanguage = eZContentLanguage::fetchByLocale( $fromLanguageCode );

$toLanguageCode = $http->variable( 'ToContentObjectLanguageCode', false );
$toLanguage = eZContentLanguage::fetchByLocale( $toLanguageCode );

$versionlimit = eZContentClass::versionHistoryLimit( $object->attribute( 'contentclass_id' ) );
$versionCount = $object->getVersionCount();
if ( $versionCount < $versionlimit )
{
    $version = $object->createNewVersionIn( $toLanguageCode, $fromLanguageCode, false, true, eZContentObjectVersion::STATUS_INTERNAL_DRAFT );
    return $Module->redirect( 'content', 'edit', array( $objectId, $version->attribute( 'version' ), $toLanguageCode, $fromLanguageCode ) );
}
else
{
    $params = array( 'conditions'=> array( 'status' => eZContentObjectVersion::STATUS_ARCHIVED ) );
    $versions = $object->versions( true, $params );
    if ( count( $versions ) > 0 )
    {
        $modified = $versions[0]->attribute( 'modified' );
        $removeVersion = $versions[0];
        foreach ( $versions as $version )
        {
            $currentModified = $version->attribute( 'modified' );
            if ( $currentModified < $modified )
            {
                $modified = $currentModified;
                $removeVersion = $version;
            }
        }

        $db = eZDB::instance();
        $db->begin();
        $removeVersion->removeThis();
        $version = $object->createNewVersionIn( $toLanguageCode, $fromLanguageCode, false, true, eZContentObjectVersion::STATUS_INTERNAL_DRAFT );
        $db->commit();

        return $Module->redirect( 'content', 'edit', array( $objectId, $version->attribute( 'version' ), $toLanguageCode, $fromLanguageCode ) );

        return eZModule::HOOK_STATUS_CANCEL_RUN;
    }
    else
    {
        $http->setSessionVariable( 'ExcessVersionHistoryLimit', true );
        $currentVersion = $object->attribute( 'current_version' );
        return $Module->redirect( 'content', 'history', array( $objectId, $currentVersion, $toLanguageCode ) );
        return eZModule::HOOK_STATUS_CANCEL_RUN;
    }
}
