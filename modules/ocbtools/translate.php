<?php

/** @var eZModule $Module */
$Module = $Params['Module'];
$objectId = $Params['ObjectID'];
$http = eZHTTPTool::instance();

$object = eZContentObject::fetch( $objectId );
if ( !$object instanceof eZContentObject )
{
    return $Module->handleError( eZError::KERNEL_NOT_FOUND, 'kernel' );
}

if ( $http->hasGetVariable( 'force' ) )
{
    unLock( $object );
}

$fromLanguageCode = $http->variable( 'FromContentObjectLanguageCode', false );
$fromLanguage = eZContentLanguage::fetchByLocale( $fromLanguageCode );

$toLanguageCode = $http->variable( 'ToContentObjectLanguageCode', false );
$toLanguage = eZContentLanguage::fetchByLocale( $toLanguageCode );

if ( !$fromLanguage instanceof eZContentLanguage || !$toLanguage instanceof eZContentLanguage )
{
    return $Module->redirectTo( $object->attribute( 'main_node' )->attribute( 'url_alias' ) );
}

$versionlimit = eZContentClass::versionHistoryLimit( $object->attribute( 'contentclass_id' ) );
$versionCount = $object->getVersionCount();

if ( !$object->canEdit( false, false, false, $toLanguageCode ) )
{
    return $Module->handleError( eZError::KERNEL_ACCESS_DENIED, 'kernel',
        array( 'AccessList' => $object->accessList( 'edit' ) ) );
}
lock( $object );

if ( $versionCount < $versionlimit )
{
    $db = eZDB::instance();
    $db->begin();
    $version = $object->createNewVersionIn( $toLanguageCode, $fromLanguageCode, false, true, eZContentObjectVersion::STATUS_DRAFT );
    $db->commit();
    unLock( $object );
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
        $version = $object->createNewVersionIn( $toLanguageCode, $fromLanguageCode, false, true, eZContentObjectVersion::STATUS_DRAFT );
        $db->commit();
        unLock( $object );
        return $Module->redirect( 'content', 'edit', array( $objectId, $version->attribute( 'version' ), $toLanguageCode, $fromLanguageCode ) );
    }
    else
    {
        $http->setSessionVariable( 'ExcessVersionHistoryLimit', true );
        $currentVersion = $object->attribute( 'current_version' );
        unLock( $object );
        return $Module->redirect( 'content', 'history', array( $objectId, $currentVersion, $toLanguageCode ) );
    }
}

function lock( eZContentObject $object )
{
    while ( true )
    {
        if ( isLocked( $object ) )
            sleep( 1 );
        else
            break;
    }
    $rowPending = array(
        'action' => 'creating_translation',
        'param' => $object->attribute( 'id' )
    );
    $pendingItem = new eZPendingActions( $rowPending );
    $pendingItem->store();
}

function isLocked( eZContentObject $object )
{
    $filterConds = array(
        'action' => 'creating_translation',
        'param' => $object->attribute( 'id' )
    );
    return count( eZPersistentObject::fetchObjectList( eZPendingActions::definition(), null, $filterConds ) ) > 0;
}

function unLock( eZContentObject $object )
{
    $filterConds = array(
        'action' => 'creating_translation',
        'param' => $object->attribute( 'id' )
    );
    $rows = eZPersistentObject::fetchObjectList( eZPendingActions::definition(), null, $filterConds );
    foreach( $rows as $row )
    {
        $row->remove();
    }
}