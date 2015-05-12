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

$ViewList['translate'] = array(
    'functions' => array('editor_tools'),
    'script' => 'translate.php',
    'single_post_actions' => array('TranslateButton' => 'Translate'),
    'params' => array('ObjectID'));

$FunctionList['editor_tools'] = array();


?>