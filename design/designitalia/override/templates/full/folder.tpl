<div class="content-view-full class-folder row">
  
  {if and( $node.parent_node_id|ne(1), $node.node_id|ne( ezini( 'NodeSettings', 'RootNode', 'content.ini' ) ) )}
  {include uri='design:nav/nav-section.tpl'}
  {/if}
    
  <div class="content-main{if or( $node.parent_node_id|eq(1), $node.node_id|eq( ezini( 'NodeSettings', 'RootNode', 'content.ini' ) ) )} wide{/if}">
    
    {if $node.node_id|ne( ezini( 'NodeSettings', 'RootNode', 'content.ini' ) )}
    <h1>{$node.name|wash()}</h1>
    {/if}

    {if $node|has_attribute( 'short_description' )}
      <div class="abstract">
      {attribute_view_gui attribute=$node|attribute( 'short_description' )}
      </div>
    {/if}
	
	{if $node|has_attribute( 'tags' )}
    <div class="tags">
      {foreach $node.data_map.tags.content.keywords as $keyword}	  
		<span class="label label-primary">{$keyword}</span>	 
	  {/foreach}
    </div>
    {/if}
    
    {if $node|has_attribute( 'description' )}
      <div class="description">
        {attribute_view_gui attribute=$node|attribute( 'description' )}
      </div>
    {/if}	  
	
    {if $node|has_attribute( 'children_view' )}
	  {include uri=concat('design:parts/children/', $node.data_map.children_view.class_content.options[$node.data_map.children_view.value[0]].name|downcase(), '.tpl')}
	{else}
	  {include uri='design:parts/children.tpl' view='line'}
	{/if}

  </div>
  
  {* Per visualizzare l'extrainfo: aggiungi la classe "full-stack" al primo div e scommenta la seguenta inclusione *}
  {*include uri='design:parts/content-related.tpl'*}

</div>
