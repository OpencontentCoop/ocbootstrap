<?php

class OcbToolsFunctionCollection
{
    public static function fetchChildrenClasses( $parentNodeId )
    {
        return array( 'result' => self::getChildrenClasses( $parentNodeId ) );
    }
    
    protected static function getNode( $parentNodeId )
    {
        $parentNode = $parentNodeId;                        
        if ( !$parentNode instanceof eZContentObjectTreeNode )
        {
            $parentNode = eZContentObjectTreeNode::fetch( $parentNodeId );
        }
        return $parentNode instanceof eZContentObjectTreeNode ? $parentNode : null;
    }
    
    protected static function getChildrenClasses( $parentNodeId )
    {
        $childrenClassTypes = array();
        if ( $parentNode = self::getNode( $parentNodeId ) )
        {
            // ricavo gli identifiers delle classi e le classi
            $childrenClassTypes = array();
            $childrenClassesParamers = array(
                'SearchSubTreeArray'=> array( $parentNode->attribute( 'node_id' ) ),
                'SearchLimit' => 1,
                'Filter' => array( '-meta_id_si:' . $parentNode->attribute( 'contentobject_id' ) ),
                'AsObjects' => false,
                'Facet' => array(
                    array( 'field' => 'meta_class_identifier_ms', 'name' => 'class_identifier', 'limit' => 200 )
                )
            );
            $solr = new eZSolr();
            $search = $solr->search( '', $childrenClassesParamers );
            if ( $search['SearchCount'] > 0 )
            {
                $facets = $search['SearchExtras']->attribute( 'facet_fields' );
                $childrenClassTypes = $facets[0]['nameList'];
            }
            if ( !empty( $childrenClassTypes ) )
            {
                $childrenClassTypes = (array) eZContentClass::fetchList( 0, true, false, null, null, $childrenClassTypes );
            }
        }
        return $childrenClassTypes;
    }
    
    public static function fetchMapMarkers( $parentNodeId )
    {
        $sortBy = array( 'name' => 'asc' );
        
        $result = array();
        
        if ( $parentNode = self::getNode( $parentNodeId ) )
        {
            $childrenCount = $parentNode->attribute( 'children_count' );
            if ( $childrenCount > 0 )
            {
                $childrenClassTypes = self::getChildrenClasses( $parentNodeId );
                
                // ricavo gli attributi delle classi
                $geoAttributes = array();
                foreach ( $childrenClassTypes as $classType )
                {
                    if ( $classType instanceof eZContentClass )
                    {
                        $geoAttributes = $geoAttributes + eZContentClassAttribute::fetchFilteredList( array( 'contentclass_id' => $classType->attribute( 'id' ),
                                                                                                             'version' => $classType->attribute( 'version' ),
                                                                                                             'data_type_string' => 'ezgmaplocation' ) );   
                    }                
                }
                
                if ( count( $geoAttributes ) )
                {
                    // imposto i filtri di ricerca
                    $geoFields = $geoFieldsNames = array();
                    foreach( $geoAttributes as $geoAttribute )
                    {
                        if ( $geoAttribute instanceof eZContentClassAttribute )
                        {
                            $geoFields[$geoAttribute->attribute( 'identifier' )] = $geoAttribute->attribute( 'name' );
                            $geoFieldsNames[] = "subattr_{$geoAttribute->attribute( 'identifier' )}___coordinates____gpt";
                        }
                    }
                    $childrenParameters = array(
                        'SearchSubTreeArray'=> array( $parentNode->attribute( 'node_id' ) ),                
                        'Filter' => array( '-meta_id_si:' . $parentNode->attribute( 'contentobject_id' ) ),
                        'SearchLimit' => $childrenCount > 1000 ? 1000 : $childrenCount,
                        'AsObjects' => false,
                        'SortBy' => $sortBy,
                        'FieldsToReturn' => $geoFieldsNames
                    );
                    
                    // cerco i figli
                    $solr = new eZSolr();
                    $children = $solr->search( '', $childrenParameters );
                    if ( $children['SearchCount'] > 0 )
                    {                    
                        foreach( $children['SearchResult'] as $item )
                        {                        
                            foreach( $geoFieldsNames as $geoFieldsName )
                            {                            
                                list( $longitude, $latitude ) = explode( ',', $item['fields'][$geoFieldsName][0] );
                                if ( intval( $latitude ) > 0 && intval( $longitude ) > 0 )
                                {
                                    $href = $item['main_url_alias'];
                                    eZURI::transformURI( $href, false, 'full' );
                                    
                                    $popup = $item['name'];
                                    
                                    $result[] = array(
                                        'lat' => floatval( $latitude ),
                                        'lon' => floatval( $longitude ),
                                        'popupMsg' => $popup,
                                        'urlAlias' => $href
                                    );
                                }
                            }
                        }
                    }
                }
            }
        }
        
        return array( 'result' => $result );
    }
}
