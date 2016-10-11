{def $nav_tools_root_node = fetch( 'content', 'node', hash( 'node_id', $pagedata.root_node ) )
     $nav_tools_class_filter = appini( 'MenuContentSettings', 'TopIdentifierList', array() )
     $nav_tools_items = fetch( 'content', 'list', hash( 'parent_node_id', $nav_tools_root_node.node_id,
                    'sort_by', $nav_tools_root_node.sort_array,
                    'class_filter_type', 'include',
                    'attribute_filter', array('and',
                                        array('priority','<','4000'),
                                        array('priority','>','2000')
                                        ),
                    'class_filter_array', $nav_tools_class_filter ) )
     $nav_tools_items_count = $nav_tools_items|count()}

{if $nav_tools_items}

<nav class="nav-tools">
  <ul class="nav nav-pills pull-right">
    {foreach $nav_tools_items as $item}
      <li>
        <a href={if eq( $ui_context, 'browse' )}{concat("content/browse/", $item.node_id)|ezurl}{else}{$item.url_alias|ezurl}{/if}{if $pagedata.is_edit} onclick="return false;"{/if}>{$item.name|wash()}</a>
      </li>
    {/foreach}
  </ul>
</nav>
{/if}