{if $object.main_node}
{include name = editor_tools
         node = $object.main_node
         uri = 'design:parts/editor_tools.tpl'}
{/if}
{def $not_show = array( 'ezxmltext', 'ezgmaplocation', 'eztext' )}
<dl class="dl-horizontal">
  {foreach $object.data_map as $attribute}
	{if and( $not_show|contains( $attribute.data_type_string )|not(), $attribute.has_content )}
	  <dt>{$attribute.contentclass_attribute_name}</dt>
	  <dd>{attribute_view_gui attribute=$attribute image_class=small shorten=200}</dd>
	{/if}
  {/foreach}
</dl>