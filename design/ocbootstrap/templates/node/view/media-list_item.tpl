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

	  {if $show_date}
      <span class="date">{$node.object.published|l10n('shortdate')}</span>
    {/if}
	  
		<a href={$node.url_alias|ezurl()}>{$node.name|wash()}</a>

    {if $node|has_abstract()}
      <p>{$node|abstract()|oc_shorten( 150 )}</p>
    {/if}
	
  </div>
</li>

{undef}