{def $not_show = array( 'ezxmltext', 'ezgmaplocation', 'eztext', 'ezpage', 'ezsurvey', 'ezmatrix' )}
<dl class="row">
  {foreach $object.data_map as $attribute}
	{if and( $not_show|contains( $attribute.data_type_string )|not(), $attribute.has_content )}
        <dt class="col-sm-4">{$attribute.contentclass_attribute_name}</dt>
        <dd class="col-sm-8">{attribute_view_gui attribute=$attribute image_class=small shorten=200}</dd>
	{/if}
  {/foreach}
</dl>