{foreach $object.data_map as $attribute}
  {if $attribute.data_type_string|eq('ezimage')}
  <div class="bg-light p-3 mb-2">
	<p class="text-center">{attribute_view_gui attribute=$attribute image_class=large alignment=center}</p>
	{def $keys = array('width','height','mime_type','filename','alternative_text','url','filesize')}
      <dl class="row">
		{foreach $attribute.content.original as $name => $value}
			{if $keys|contains($name)}
                <dt class="col-sm-4">{$name}</dt>
                <dd class="col-sm-8">
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

<dl class="row">
  {foreach $object.data_map as $attribute}
	{if $attribute.data_type_string|ne('ezimage')}
        {if array( 'ezstring', 'ezinteger', 'ezkeyword', 'eztext', 'ezobjectrelationlist' )|contains( $attribute.data_type_string )}
            <dt class="col-sm-4">{$attribute.contentclass_attribute_name}</dt>
            <dd class="col-sm-8">

              {def $inputTag = 'input'}
              {if array( 'eztext' )|contains( $attribute.data_type_string )}
                {set $inputTag = 'textarea'}
              {elseif array( 'ezobjectrelationlist' )|contains( $attribute.data_type_string )}
                {if $attribute.class_content.selection_type|eq(1)}
                  {set $inputTag = 'option:selected'}
                {elseif $attribute.class_content.selection_type|eq(2)}
                  {set $inputTag = 'input:checked'}
                {elseif $attribute.class_content.selection_type|eq(3)}
                  {set $inputTag = 'input:checked'}
                {else}
                  {set $inputTag = 'nullTag'}
                {/if}
              {/if}

              <span>
                <button class="inline-edit btn btn-sm btn-info"
                        data-input="{$inputTag}"
                        data-objectid="{$attribute.object.id}"
                        data-attributeid="{$attribute.id}"
                        data-version="{$attribute.version}">
                    <i class="fa fa-pencil"></i>
                </button>
                {attribute_view_gui attribute=$attribute image_class=large}
              </span>
              <span class="inline-form" style="display: none">
                {attribute_edit_gui attribute=$attribute html_class='form-control'}
                <button class="btn btn-danger btn-sm pull-right">Salva</button>
              </span>

              {undef $inputTag}
          </dd>
        {/if}
	{/if}
  {/foreach}
</dl>