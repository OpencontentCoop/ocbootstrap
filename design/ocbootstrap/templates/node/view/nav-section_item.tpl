{def $node_name = $node.name|wash()}
{if $node.data_map.short_name.has_content}
  {set $node_name = $node.data_map.short_name.content|wash()}
{/if}

{if eq( $node.class_identifier, 'link')}
<li><a href={$node.data_map.location.content|ezurl}{if and( is_set( $node.data_map.open_in_new_window ), $node.data_map.open_in_new_window.data_int )} target="_blank"{/if} title="{$node.data_map.location.data_text|wash}" class="menu-item-link" rel={$node.url_alias|ezurl}>{if $node.data_map.location.data_text}{$node.data_map.location.data_text|wash()}{else}{$node_name}{/if}</a>
  {else}
<li><a href="{$node.url_alias|ezurl('no')}">{$node_name}</a>
  {/if}
  {if $current_node_in_path|eq($node.node_id)}
    {def $sub_menu_items = fetch( 'content', 'list', hash(  'parent_node_id', $node.node_id,
    'sort_by', $node.sort_array,
    'load_data_map', false(),
    'class_filter_type', 'include',
    'class_filter_array', appini( 'MenuContentSettings', 'LeftIdentifierList', array() ) ) )
    $sub_menu_items_count = $sub_menu_items|count}
    {if $sub_menu_items_count}
      <ul class="nav-sub">
        {foreach $sub_menu_items as $subkey => $subitem}
          {def $subitem_name = $subitem.name|wash()}

          {if $subitem.data_map.short_name.has_content}
            {set $subitem_name = $subitem.data_map.short_name.content|wash()}
          {/if}

          {if eq( $subitem.class_identifier, 'link')}
            <li><a href={$subitem.data_map.location.content|ezurl}{if and( is_set( $subitem.data_map.open_in_new_window ), $subitem.data_map.open_in_new_window.data_int )} target="_blank"{/if} title="{$subitem.data_map.location.data_text|wash}" class="menu-item-link" rel={$subitem.url_alias|ezurl}>{if $subitem.data_map.location.data_text}{$subitem.data_map.location.data_text|wash()}{else}{$subitem_name}{/if}</a></li>
          {else}
            <li><a href="{$subitem.url_alias|ezurl( 'no' )}">{$subitem_name}</a></li>
          {/if}

        {/foreach}
      </ul>
    {/if}
    {undef $sub_menu_items $sub_menu_items_count $node_name $subitem_name}
  {/if}
</li>