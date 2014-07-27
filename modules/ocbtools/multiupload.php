<?php


$http = eZHTTPTool::instance();
$tpl = eZTemplate::factory();
$module = $Params['Module'];
$parentNodeID = $Params['ParentNodeID'];

$message = json_encode( "error" );

if( $module->isCurrentAction( 'Upload' ) )
{
    $result = array( 'errors' => array() );

    // Exec multiupload handlers preUpload method
    eZMultiuploadHandler::exec( 'preUpload', $result );

    // Handle file upload only if there was no errors
    if( empty( $result['errors'] ) )
    {
        // Handle file upload. All checkes are performed by eZContentUpload::handleUpload()
        // and available in $result array
        $upload = new eZContentUpload();
        $upload->handleUpload( $result, 'Filedata', $parentNodeID, false );
    }

    // Exec multiupload handlers postUpload method
    eZMultiuploadHandler::exec( 'postUpload', $result );

    unset( $result['contentobject_main_node'] );
    unset( $result['contentobject'] );
    
    $id = md5( (string) mt_rand() . (string) microtime() );
    $response = array( 'id' => $id, 'result' => $result );
    
    $message = json_encode( $response );
}

header('Content-Type: application/json');
echo $message;
eZExecution::cleanExit();
?>
