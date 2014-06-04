<div class="content-view-line class-{$node.class_identifier} media">  
  {if $node|has_attribute( 'image' )}
  <a class="pull-left" href="{if is_set( $node.url_alias )}{$node.url_alias|ezurl('no')}{else}#{/if}">    
	{attribute_view_gui attribute=$node|attribute( 'image' ) href=false() image_class='squarethumb' css_class="media-object"}
  </a>
  {/if}
  <div class="media-body">
	<h4>
	  {$node.name|wash}
	  <div class="pull-right">
		{include uri='design:parts/toolbar/node_toolbar.tpl' current_node=$node}
	  </div>
	</h4>
	{if $node.data_map.description.content.is_empty|not}
	 {attribute_view_gui attribute=$node.data_map.description}
	{/if}
	 {if $node.data_map.location.has_content}
        <div class="attribute-link">
            <p><a href="{$node.data_map.location.content}" target="_blank">
			<strong>{if $node.data_map.location.data_text|count|gt( 0 )}{$node.data_map.location.data_text|wash}{else}{$node.data_map.location.content|wash}{/if}</strong>
			</a></p>
        </div>
    {/if}
  </div>
</div>