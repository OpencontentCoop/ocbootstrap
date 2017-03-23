<?php

$module = $Params['Module'];
$id = $Params['ContentObjectAttributeID'];
$version = $Params['ContentObjectVersion'];
$parentNodeID = $Params['ParentNodeID'];
$http = eZHTTPTool::instance();

$attribute = eZContentObjectAttribute::fetch( $id, $version );
$response = array();

if ( $attribute instanceof eZContentObjectAttribute && $attribute->attribute( 'object' )->attribute( 'can_edit' ) )
{

    $siteaccess = eZSiteAccess::current();
    $options['upload_dir'] = eZSys::cacheDirectory() . '/fileupload/';
    $options['download_via_php'] = true;
    $options['param_name'] = "files";
    $options['image_versions'] = array();
    $options['max_file_size'] = $http->variable( "upload_max_file_size_$id", null );

    $uploadHandler = new UploadHandler( $options, false );
    $data = $uploadHandler->post( false );
    foreach( $data[$options['param_name']] as $file )
    {
        $filePath = $options['upload_dir'] . $file->name;
        $upload = new eZContentUpload();
        $upload->handleLocalFile( $response, $filePath, $parentNodeID, false );
    }
    if (isset($response['contentobject'])){
        unset($response['contentobject']);
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
