{def $valid_nodes = $block.valid_nodes}

<div class="block-type-content-grid block-view-{$block.view} box grid">

  {if ne( $block.name, '' )}
    <h2 class="box-title">{$block.name|wash()}</h2>
  {/if}

  <div class="row">
    {foreach $valid_nodes as $valid_node max 6}
        <div class="col-md-4">
          {node_view_gui view='grid_item' content_node=$valid_node}
        </div>
    {delimiter modulo=3}
      </div>
      <div class="row">
    {/delimiter}
    {/foreach}
  </div>

</div>

{undef $valid_nodes}
