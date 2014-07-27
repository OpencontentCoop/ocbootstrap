{def $object = false()
     $attribute_base='ContentObjectAttribute'
	 $attribute_id = 0
	 $priority = 100}
{if is_set( $arguments[0] )}
    {set $object = fetch( content, object, hash( object_id, $arguments[0] ))}
{/if}
{if is_set( $arguments[1] )}
    {set $attribute_id = $arguments[1]}
{/if}
{if is_set( $arguments[2] )}
    {set $priority = $arguments[2]}
{/if}
{if and( $object.can_read, fetch( 'user', 'has_access_to', hash( 'module', 'openpa', 'function', 'editor_tools' ) ) )}
<tr>
  {* Remove. *}
  <td><input type="checkbox" name="{$attribute_base}_selection[{$attribute_id}][]" value="{$object.id}" />
  <input type="hidden" name="{$attribute_base}_data_object_relation_list_{$attribute_id}[]" value="{$object.id}" /></td>

  {* Name *}
  <td><small>{$object.name|wash()}</small></td>

  {* Type *}
  <td><small>{$object.class_name|wash()}</small></td>
			 
  {* Section *}
  <td><small>{fetch( section, object, hash( section_id, $object.section_id ) ).name|wash()}</small></td>
				
  <td><small>{if $object.main_node_id}
		  {'Yes'|i18n( 'design/standard/content/datatype' )}
	  {else}
		  {'No'|i18n( 'design/standard/content/datatype' )}
	  {/if}</small>
  </td>
			  
  {* Order. *}
  <td><input size="2" type="text" name="{$attribute_base}_priority[{$attribute_id}][]" value="{$priority}" /></td>

</tr>
{/if}