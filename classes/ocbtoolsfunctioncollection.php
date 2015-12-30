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
    
    public static function fetchMapMarkers( $parentNodeId, $childrenClassIdentifiers )
    {
        foreach( $childrenClassIdentifiers as $key => $value )
        {
            if ( empty( $value ) ) unset( $childrenClassIdentifiers[$key] );
        }
        $sortBy = array( 'name' => 'asc' );
        
        $result = array();
        
        if ( $parentNode = self::getNode( $parentNodeId ) )
        {
            if ( !empty( $childrenClassIdentifiers ) )
            {
                $childrenClassTypes = (array) eZContentClass::fetchList( 0, true, false, null, null, $childrenClassIdentifiers );
            }
            else
            {
                $childrenClassTypes = self::getChildrenClasses( $parentNodeId );
            }
            
            // ricavo gli attributi delle classi
            $geoAttributes = array();
            foreach ( $childrenClassTypes as $classType )
            {
                if ( $classType instanceof eZContentClass )
                {
                    $geoAttributes = array_merge( $geoAttributes,
                                                 eZContentClassAttribute::fetchFilteredList( array( 'contentclass_id' => $classType->attribute( 'id' ),
                                                                                                    'version' => $classType->attribute( 'version' ),
                                                                                                    'data_type_string' => 'ezgmaplocation' ) )
                                                );   
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
                    'SearchLimit' => 1000,
                    'AsObjects' => false,
                    'SortBy' => $sortBy,
                    'FieldsToReturn' => $geoFieldsNames
                );
                
                // cerco i figli
                $solr = new OCSolr();
                $children = $solr->search( '', $childrenParameters );
                if ( $children['SearchCount'] > 0 )
                {

                    foreach( $children['SearchResult'] as $item )
                    {                                                                        
                        foreach( $geoFieldsNames as $geoFieldsName )
                        {                            
                            @list( $longitude, $latitude ) = explode( ',', $item['fields'][$geoFieldsName][0] );
                            if ( intval( $latitude ) > 0 && intval( $longitude ) > 0 )
                            {
                                $href = isset( $item['main_url_alias'] ) ? $item['main_url_alias'] : $item['main_url_alias_ms'];
                                eZURI::transformURI( $href, false, 'full' );                                
                                $popup = isset( $item['name'] ) ? $item['name'] : $item['name_t'];                                
                                $id = isset( $item['id_si'] ) ? $item['id_si'] : $item['id'];
                                $result[] = array(
                                    'id' => $id,
                                    'type' => null, //@todo
                                    'lat' => floatval( $latitude ),
                                    'lon' => floatval( $longitude ),
                                    'lng' => floatval( $longitude ),
                                    'popupMsg' => $popup,
                                    'title' => $popup,
                                    'description' => "<h3><a href='{$href}'>{$popup}</a></h3>", //@todo
                                    'urlAlias' => $href,
                                    'objectID' => $id
                                );
                            }
                        }
                    }
                }
            }
        }        
        return array( 'result' => $result );
    }
}