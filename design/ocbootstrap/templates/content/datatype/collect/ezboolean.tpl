{default attribute_base='ContentObjectAttribute'}
{let data_int=cond( is_set( $#collection_attributes[$attribute.id]), $#collection_attributes[$attribute.id].data_int, $attribute.data_int )}
{if is_set($label)}<label for="{$attribute_base}_data_boolean_{$attribute.id}">{$label}</label>{/if}
  <input type="checkbox" name="{$attribute_base}_data_boolean_{$attribute.id}" {$data_int|choose( '', 'checked="checked"' )} />
{/let}
{/default}