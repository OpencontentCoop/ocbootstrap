{def $valid_node = $block.valid_nodes[0]}

<div class="content-view-block block-type-mainstory box">
  {if ne( $block.name, '' )}
    <h2 class="box-title">{$block.name|wash()}</h2>
  {/if}
  <div class="box-content">

    {node_view_gui view='main_story_item'
                   content_node=$valid_node
                   block_view=$block.view
                   hide_title=$block.custom_attributes.hide_title}

  </div>
</div>
{undef $valid_node}