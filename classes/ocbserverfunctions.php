<?php

class ocbServerFunctions
{
    public static function attribute_edit()
    {
        $http = eZHTTPTool::instance();
        $objectId = $http->postVariable( 'objectId', 0 );
        $attributeId = $http->postVariable( 'attributeId', 0 );
        $version = $http->postVariable( 'version', 0 );
        $content = $http->postVariable( 'content', '' );
        
        $object = eZContentObject::fetch( $objectId );
        if ( $object instanceof eZContentObject && $object->attribute( 'can_edit' ) )
        {
            $attribute = eZContentObjectAttribute::fetch( $attributeId, $version );
            if ( $attribute instanceof eZContentObjectAttribute && $attribute->attribute( 'contentobject_id' ) == $objectId )
            {
                if ($attribute->attribute('data_type_string') == eZSelectionType::DATA_TYPE_STRING){
                    $classContent = $attribute->contentClassAttribute()->content();
                    $convertedContent = array();
                    $optionArray = $classContent['options'];
                    if (!is_array($content)){
                        $content = array($content);
                    }
                    foreach ( $content as $id )
                    {
                        foreach ( $optionArray as $option )
                        {
                            $optionId = $option['id'];
                            if ( $optionId == $id )
                                $convertedContent[] = $option['name'];
                        }
                    }
                    $content = implode('|', $convertedContent);
                }

                $params['attributes'] = array( $attribute->attribute( 'contentclass_attribute_identifier' ) => $content );
                eZContentFunctions::updateAndPublishObject( $object, $params );
                $object = eZContentObject::fetch( $objectId );
                return $object->attribute( 'name' );
            }            
        }
        
        throw new Exception( "Error" );
    }
}
