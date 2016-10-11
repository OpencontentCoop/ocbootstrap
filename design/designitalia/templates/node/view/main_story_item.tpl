<div class="mainstory {$block_view}">
  {if $node|has_attribute( 'image' )}
  {attribute_view_gui attribute=$node|has_attribute( 'image' ) image_class='imagefull_cutwide' href=$node.url_alias|ezurl(no) css_class="mainstory-image"}
  {/if}

  {*if $node.data_map.tags.has_content}
    <span class="mainstory-tags tags">
      {attribute_view_gui attribute=$node.data_map.tags}
    </span>
  {/if*}

  {*
  <span class="mainstory-meta meta">
    {$node.object.published|l10n('shortdate')}
  </span>
  *}
  {if $hide_title|not()}
    <h3 class="mainstory-title"><a href={$node.url_alias|ezurl()}>{$node.object.name|wash()}</a></h3>
  {/if}

  {if $node|has_abstract}
    <div class="mainstory-abstract abstract">
      {$node|abstract}
    </div>
  {/if}

  {if eq($block_view,'jumbotron')}
    <p><a class="btn btn-primary btn-lg" role="button" href={$node.url_alias|ezurl()}>{'Read more'|i18n('ocbootstrap')}</a></p>
  {else}
    <p class="goto"><a href={$node.url_alias|ezurl()}>{'Read more'|i18n('ocbootstrap')}</a></p>
  {/if}
</div>