{set_defaults( hash(
  'show_date', false()
))}

<li class="media">
  {if $node|has_attribute( 'image' )}
  <a class="pull-left" href="{if is_set( $node.url_alias )}{$node.url_alias|ezurl('no')}{else}#{/if}">    
	{attribute_view_gui attribute=$node|attribute( 'image' ) href=false() image_class='squaremini' css_class="media-object"}
  </a>
  {/if}
  <div class="media-body">
  
	<h4>
	  <a href={$node.url_alias|ezurl()}>{$node.name|wash()}</a>
	  {if $show_date}
		<small>{$node.object.published|l10n('shortdate')}</small>
	  {/if}
	</h4>

    {if $node|has_abstract()}
      <p>{$node|abstract()|oc_shorten( 150 )}</p>
    {/if}
	
  </div>
</li>

{undef}