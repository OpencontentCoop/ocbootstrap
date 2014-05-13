{* Event Calendar - Full view *}
{set-block scope=root variable=cache_ttl}400{/set-block}
<div class="content-view-full class-{$node.class_identifier} row">
  
  {include uri='design:nav/nav-section.tpl'}
    
  <div class="content-main">
    {include uri=concat("design:full/event_", $node.data_map.view.class_content.options[$node.data_map.view.value[0]].name|downcase(), ".tpl") }
  </div>
  
</div>
