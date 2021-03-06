{def $object = false()}
{if is_set( $arguments[0] )}
    {set $object = fetch( content, object, hash( object_id, $arguments[0] ))}
{/if}
{if $object.can_read}
<tr>
    <td>
        <input {if and( is_set( $arguments[3] ), $arguments[3]|eq(1))}checked="checked" {/if}type="{$arguments[1]}" name="{$arguments[2]}[]" value="{$object.id}" />
    </td>
    <td>
        {if and( is_set($object.data_map.image), $object.data_map.image.has_content )}
            <img data-object="{$object.id}" class="load-preview img-thumbnail" src={$object.data_map.image.content['small'].url|ezroot} />
        {/if}
    </td>
    <td>
        {$object.name|wash}
    </td>
    <td>
        {$object.content_class.name|wash}
    </td>
    <td>
        <span data-object="{$object.id}" class="load-preview">
            <i class="fa fa-search-plus"></i>
        </span>
    </td>
</tr>
{/if}