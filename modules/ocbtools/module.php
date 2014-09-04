<?php


$Module = array('name' => 'OCBootstrap Modules', 'variable_params' => true);

$ViewList = array();

$ViewList['multiupload'] = array(
    'functions' => array('editor_tools'),
    'script' => 'multiupload.php',
    'single_post_actions' => array('UploadButton' => 'Upload'),
    'params' => array('ParentNodeID'));

$ViewList['upload'] = array(
    'functions' => array('editor_tools'),
    'script' => 'upload.php',
    'params' => array('ContentObjectAttributeID', 'ContentObjectVersion', 'ParentNodeID'));

$FunctionList['editor_tools'] = array();


?>