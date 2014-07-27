{if $object.main_node}
    {include name = editor_tools
    node = $object.main_node
    uri = 'design:parts/editor_tools.tpl'}
{/if}

{foreach $object.data_map as $attribute}
  {if $attribute.data_type_string|eq('ezimage')}
  <div class="well well-sm">
	<p class="text-center">{attribute_view_gui attribute=$attribute image_class=large alignment=center}</p>
	{def $keys = array('width','height','mime_type','filename','alternative_text','url','filesize')}
	<dl class="dl-horizontal">
		{foreach $attribute.content.original as $name => $value}
			{if $keys|contains($name)}
				<dt>{$name}</dt>
				<dd>
				  {if $name|eq('url')}
					  <a target="_blank" href={$value|ezroot()}>{$value|wash()}</a>
				  {elseif $name|eq('filesize')}
					  {$value|si(byte)}
				  {else}
					  {$value|wash()}
				  {/if}
				</dd>
			{/if}
		{/foreach}
	</dl>
  </div>
  {/if}
{/foreach}

<dl class="dl-horizontal">
  {foreach $object.data_map as $attribute}
	  
	{if $attribute.data_type_string|ne('ezimage')}		
	  {*if $attribute.contentclass_attribute_identifier|eq('name')}
		  <dt>{$attribute.contentclass_attribute_name}</dt>
		  <dd>
			  <div class="input-group">
				  <input type="text" class="form-control" name="ChangeObjectName[{$attribute.object.id}][{$attribute.contentclass_attribute_identifier}]" value="{$attribute.content|wash()}" />
				  <span class="input-group-btn">
				  <button class="btn btn-info searchbutton">
					  <span class="glyphicon glyphicon-floppy-save"></span>
				  </button>
				  </span>
			  </div>
		  </dd>
	  {else*}
		  <dt>{$attribute.contentclass_attribute_name}</dt>
		  <dd>{attribute_view_gui attribute=$attribute image_class=large}</dd>
	  {*/if*}
	{/if}
  {/foreach}
</dl>