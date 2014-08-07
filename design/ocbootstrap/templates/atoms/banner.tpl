{set_defaults( hash(
'item', false(),
'caption', false()
))}

{if $item}
<div class="banner">  
  {def $target_url = $item.data_map.url.content}

  {if gt($item.data_map.internal_link.content.relation_list)}
    {*$item.data_map.internal_link.content.relation_list|attribute(show)*}
    {def $obj = fetch('content','object',hash('object_id',$item.data_map.internal_link.content.relation_list[0].contentobject_id))}
    {set $target_url = $obj.main_node.url_alias|ezurl(no)}
    {*set $target_url = fetch('content','object',hash('object_id',$item.data_map.internal_link.content.id)).main_node.url_alias|ezurl(no)*}
  {/if}

  {if gt($target_url|count(),0)}
    <a class="figcontainer" href="{$target_url}" title="{$item.name|wash()}">
      <img src={$item.data_map.image.content['original'].url|ezroot} class="img-responsive">
      {if $caption}<div class="caption" >{$item.name|oc_shorten(28,'...')}</div>{/if}
      {*if $item.data_map.caption.has_content}
        <div class="legend" >{$item.data_map.caption.content|oc_shorten(28,'...')}</div>
      {/if*}
    </a>
  {else}
  <span class="figcontainer">
    <img src={$item.data_map.image.content['original'].url|ezroot} >
    {if $caption}<div class="caption" >{$item.name|oc_shorten(28,'...')}</div>{/if}
    {*if $item.data_map.caption.has_content}
      <div class="legend" >{$item.data_map.caption.content|oc_shorten(28,'...')}</div>
    {/if*}
  </span>
  {/if}

  {undef $target_url}
</div>
{/if}