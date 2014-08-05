<div class="griditem">
{attribute_view_gui attribute=$node.data_map.image image_class='portrait' href=$node.url_alias|ezurl(no) css_class="grid-image"}

  {if $node.data_map.tags.has_content}
    <span class="griditem-tags tags">
      {attribute_view_gui attribute=$node.data_map.tags}
    </span>
  {/if}

  <span class="griditem-meta meta">
    {$node.object.published|l10n('shortdate')}
  </span>

  <h3 class="griditem-title"><a href={$node.url_alias|ezurl()}>{$node.object.name|wash()}</a></h3>

  {if $node|has_abstract}
    <div class="griditem-abstract abstract">
      {attribute_view_gui attribute=$node|abstract}
    </div>
  {/if}


</div>