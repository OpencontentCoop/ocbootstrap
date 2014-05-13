<div class="content-view-line class-{$node.class_identifier} row">    
	{if $node|has_attribute( 'image' )}
	
	  <div class="col-xs-2">
		{attribute_view_gui attribute=$node|attribute( 'image' ) image_class='small'}
	  </div>

	  <div class="col-xs-10">
	{else}
	  <div class="col-xs-12">
	{/if}
	  
	  {if is_set( $node.url_alias )}
		<h2><a href="{$node.url_alias|ezurl('no')}" title="{$node.name|wash()}">{$node.name|wash()}</a></h2>
	  {else}
		<h2>{$node.name|wash()}</h2>
	  {/if}
    
	  </div>
</div>