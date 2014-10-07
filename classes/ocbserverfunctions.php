<?php

class ocbServerFunctions
{
    public static function attribute_edit()
    {
        $http = eZHTTPTool::instance();
        $objectId = $http->postVariable( 'objectId', 0 );
        $attributeId = $http->postVariable( 'attributeId', 0 );
        $version = $http->postVariable( 'version', 0 );
        $content = $http->postVariable( 'content', 0 );
        
        $object = eZContentObject::fetch( $objectId );
        if ( $object instanceof eZContentObject && $object->attribute( 'can_edit' ) )
        {
            $attribute = eZContentObjectAttribute::fetch( $attributeId, $version );
            if ( $attribute instanceof eZContentObjectAttribute && $attribute->attribute( 'contentobject_id' ) == $objectId )
            {
                $params['attributes'] = array( $attribute->attribute( 'contentclass_attribute_identifier' ) => $content );
                eZContentFunctions::updateAndPublishObject( $object, $params );
                $object = eZContentObject::fetch( $objectId );
                return $object->attribute( 'name' );
            }            
        }
        
        throw new Exception( "Error" );
    }
}