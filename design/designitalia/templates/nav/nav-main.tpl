{def $root_node = fetch( 'content', 'node', hash( 'node_id', $pagedata.root_node ) )}

<div class="container" style="margin-bottom: 10px;">
  <div class="row">
    <div class="col-lg-12">
      <div class="navbar-default collapse navbar-collapse" id="main-navbar">
       {def $top_menu_class_filter = appini( 'MenuContentSettings', 'TopIdentifierList', array() )
            $top_menu_items = fetch( 'content', 'list', hash( 'parent_node_id', $root_node.node_id,
                                      'sort_by', $root_node.sort_array,
                                      'class_filter_type', 'include',
                                      'class_filter_array', $top_menu_class_filter ) )
            $top_menu_items_count = $top_menu_items|count()}
  
        {if $top_menu_items_count}
        <ul class="nav navbar-nav">
          {foreach $top_menu_items as $key => $item}
            {node_view_gui content_node=$item
                  view='nav-main_item'
                  key=$key
                  current_node_id=$current_node_id
                  ui_context=$ui_context
                  pagedata=$pagedata
                  top_menu_items_count=$top_menu_items_count}
          {/foreach}
        </ul>
        {/if}
      </div>
    </div>
  </div>
</div>