<?php

$FunctionList = array();
$FunctionList['map_markers'] = array(
    'name' => 'map_markers',
    'operation_types' => array( 'read' ),
    'call_method' => array(
        'include_file' => 'extension/ocbootstrap/classes/ocbtoolsfunctioncollection.php',
        'class' => 'OcbToolsFunctionCollection',
        'method' => 'fetchMapMarkers' ),
    'parameter_type' => 'standard',
    'parameters' => array(
        array(
            'name' => 'parent_node_id',
            'type' =>'mixed',
            'required' => true,
            'default' => false
        ),
        array(
            'name' => 'class_identifiers',
            'type' =>'array',
            'required' => false,
            'default' => array()
        )
    )
);

$FunctionList['children_classes'] = array(
    'name' => 'children_classes',
    'operation_types' => array( 'read' ),
    'call_method' => array(
        'include_file' => 'extension/ocbootstrap/classes/ocbtoolsfunctioncollection.php',
        'class' => 'OcbToolsFunctionCollection',
        'method' => 'fetchChildrenClasses' ),
    'parameter_type' => 'standard',
    'parameters' => array(
        array(
            'name' => 'parent_node_id',
            'type' =>'mixed',
            'required' => true,
            'default' => false
        )
    )
);