{def $object = false()}
{if is_set( $arguments[0] )}
    {set $object = fetch( content, object, hash( object_id, $arguments[0] ))}
{/if}
{if and( $object.can_read, fetch( 'user', 'has_access_to', hash( 'module', 'openpa', 'function', 'editor_tools' ) ) )}
    {content_view_gui content_object=$object view=cond( is_set( $arguments[1] ), $arguments[1], "preview" )}
{/if}