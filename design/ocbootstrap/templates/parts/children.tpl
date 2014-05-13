{set_defaults( hash(
  'page_limit', 10,
	'view', 'line',
  'delimiter', '',
  'exclude_classes', appini( 'ContentViewChildren', 'ExcludeClasses', array( 'image', 'video' ) )
))}

{def $children_count = fetch_alias( 'children_count', hash( 'parent_node_id', $node.node_id,
															'class_filter_type', 'exclude',
															'class_filter_array', $exclude_classes ) )}
{if $children_count}
  <div class="content-view-children">  
	{foreach fetch_alias( 'children', hash( 'parent_node_id', $node.node_id,
											'offset', $view_parameters.offset,
											'sort_by', $node.sort_array,
											'class_filter_type', 'exclude',
											'class_filter_array', $exclude_classes,
											'limit', $page_limit ) ) as $child }
	  {node_view_gui view=$view content_node=$child}
	  {delimiter}{$delimiter}{/delimiter}
	{/foreach}
  </div>

  {include name=navigator
		   uri='design:navigator/google.tpl'
		   page_uri=$node.url_alias
		   item_count=$children_count
		   view_parameters=$view_parameters
		   item_limit=$page_limit}

{/if}