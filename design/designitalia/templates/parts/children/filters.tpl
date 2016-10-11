{set_defaults(hash(
  'page_limit', 10
))}
{def $data = class_search_result(  hash( 'subtree_array', array( $node.node_id ),
										 'sort_by', hash( 'name', 'asc' ),
										 'limit', $page_limit ),
								   $view_parameters )}

<div class="row">
  <div class="col-md-9">
	{if $data.is_search_request}	  	  
	 {include name=class_search_form_result
			  uri='design:parts/class_search_form_result.tpl'
			  data=$data
			  page_url=$node.url_alias
			  view_parameters=$view_parameters
			  page_limit=$page_limit}  
	{else}
	
	 {include uri='design:parts/children.tpl' view='line'}
	
	{/if}
  </div>
  <div class="col-md-3">

	{def $currentClass = false()		 
		 $classes = fetch( 'ocbtools', 'children_classes', hash( 'parent_node_id', $node.node_id ) )}	
	{if $data.is_search_request}	
	  {set $currentClass = cond( is_set( $data.fetch_parameters.class_id ), $data.fetch_parameters.class_id, $classes[0].id )}  
	{elseif count( $classes )|le(1)}
	  {set $currentClass = $classes[0].id}  	
	{/if}
	
	{if count( $classes )|gt(1)}
	<ul class="nav nav-tabs" role="tablist">	  
		{foreach $classes as $class}
		<li{if $currentClass|eq( $class.id )} class="active"{/if}><a href="#{$class.identifier}" role="tab" data-toggle="tab">{$class.name|wash()}</a></li>
		{/foreach}	  
	</ul>
	{/if}
	<div class="tab-content">
	  {foreach $classes as $class}
	  <div class="tab-pane{if $currentClass|eq( $class.id )} active{/if}" id="{$class.identifier}">
		{class_search_form( $class.identifier, hash( 'RedirectNodeID', $node.node_id ) )}
	  </div>
	  {/foreach}
	</div>
	
  </div>
</div>