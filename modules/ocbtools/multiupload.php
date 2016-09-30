<?php

$module = $Params['Module'];
$parentNodeID = (int)$Params['ParentNodeID'];
$http = eZHTTPTool::instance();

$canUpload = true;

if ($parentNodeID > 0){
    $parentNode = eZContentObjectTreeNode::fetch($parentNodeID);
    $canUpload = $parentNode instanceof eZContentObjectTreeNode && $parentNode->canCreate();
}

$response = array();

if ( $canUpload )
{

    $siteaccess = eZSiteAccess::current();
    $options['upload_dir'] = eZSys::cacheDirectory() . '/fileupload/';
    $options['download_via_php'] = true;
    $options['param_name'] = "files";
    $options['image_versions'] = array();
    $options['max_file_size'] = $http->variable( "upload_max_file_size", null );

    $uploadHandler = new UploadHandler( $options, false );
    $data = $uploadHandler->post( false );
    foreach( $data[$options['param_name']] as $file )
    {
        $filePath = $options['upload_dir'] . $file->name;

        $behaviour = new ezpContentPublishingBehaviour();
        $behaviour->isTemporary = true;
        $behaviour->disableAsynchronousPublishing = false;
        ezpContentPublishingBehaviour::setBehaviour( $behaviour );

        $upload = new eZContentUpload();
        $upload->handleLocalFile( $response, $filePath, $parentNodeID, false );
    }

    $file = eZClusterFileHandler::instance( $filePath );
    if ( $file->exists() ) $file->delete();

}
else
{
    $response = array( 'errors' => array( 'Not Allowed' ) );
}
header('Content-Type: application/json');
echo json_encode( $response );
eZExecution::cleanExit();
