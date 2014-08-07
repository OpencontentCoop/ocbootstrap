
<div class="content-view-listitem row">
  <a href={$node.url_alias|ezurl()}>
  {if $node.data_map.image.has_content}
    <div class="listitem-image">
      {attribute_view_gui attribute=$node.data_map.image image_class=widethumb}
    </div>
  {/if}
  <div class="listitem-content {if $node.data_map.image.has_content}has-image{/if}">
    <span class="listitem-meta meta">{$node.object.published|l10n('shortdate')}</span>
    <h3 class="listitem-title">{$node.name|wash()}</h3>
    <div class="listitem-abstract abstract">
      {$node|abstract()|oc_shorten(110)}
    </div>
  </div>
  </a>
</div>