<div class="mainstory">
  {attribute_view_gui attribute=$node.data_map.image image_class='imagefull_cutwide' href=$node.url_alias|ezurl(no) css_class="mainstory-image"}

  {if $node.data_map.tags.has_content}
    <span class="mainstory-tags tags">
      {attribute_view_gui attribute=$node.data_map.tags}
    </span>
  {/if}

  {*
  <span class="mainstory-meta meta">
    {$node.object.published|l10n('shortdate')}
  </span>
  *}
  <h3 class="mainstory-title"><a href={$node.url_alias|ezurl()}>{$node.object.name|wash()}</a></h3>

  {if $node|has_abstract}
    <div class="mainstory-abstract abstract">
      {$node|abstract}
    </div>
  {/if}
</div>