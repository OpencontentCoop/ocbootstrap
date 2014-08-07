<div class="griditem">
  <h3 class="griditem-title"><a href={$node.url_alias|ezurl()}>{$node.object.name|wash()}</a></h3>

  {attribute_view_gui attribute=$node.data_map.image image_class='imagefull_cutwide' href=$node.url_alias|ezurl(no) css_class="griditem-image"}

  {*if $node.data_map.tags.has_content}
    <span class="griditem-tags tags">
      {attribute_view_gui attribute=$node.data_map.tags}
    </span>
  {/if*}

  {*
  <span class="griditem-meta meta">
    {$node.object.published|l10n('shortdate')}
  </span>
  *}

  {if $node|has_abstract}
    <div class="griditem-abstract abstract">
      {$node|abstract}
    </div>
  {/if}


</div>