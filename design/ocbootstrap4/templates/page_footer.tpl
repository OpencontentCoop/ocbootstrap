{def $root_node = fetch( 'content', 'node', hash( 'node_id', $pagedata.root_node ) )}
<footer class="footer text-white bg-dark mt-5">
  <div class="container-fluid p-3 p-md-5">
        {def $top_menu_class_filter = appini( 'MenuContentSettings', 'TopIdentifierList', array() )
             $top_menu_items = fetch( 'content', 'list', hash( 'parent_node_id', $root_node.node_id,
                                      'sort_by', $root_node.sort_array,
                                      'limit', 10,
                                      'class_filter_type', 'include',
                                      'class_filter_array', $top_menu_class_filter ) )
             $top_menu_items_count = $top_menu_items|count()}

      {if $top_menu_items_count}
          <ul class="footer-links">
              {foreach $top_menu_items as $key => $item}
                  <li>{node_view_gui content_node=$item view='text_linked'}</li>
              {/foreach}
          </ul>
      {/if}
      <p>Powered by OpenContent</p>
  </div>
</footer>