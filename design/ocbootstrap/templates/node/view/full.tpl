<div class="content-view-full class-{$node.class_identifier} row">
  
  {* Per il menu di sinistra scommenta e togli "wide" dal content-main *}
  {*include uri='design:nav/nav-section.tpl'*}
    
  <div class="content-main wide">
    
    <h1>{$node.name|wash()}</h1>
    
    <div class="info text-right">
      {include uri='design:parts/date.tpl'}    
      {include uri='design:parts/author.tpl'}
    </div>
    
	
	{foreach $node.object.contentobject_attributes as $attribute}
	  {if $node|has_attribute( $attribute.contentclass_attribute_identifier )}
	  <dl class="dl-horizontal attribute-{$attribute.contentclass_attribute_identifier}">
		<dt>{$attribute.contentclass_attribute_name}</dt>
		<dd>
		  {attribute_view_gui attribute=$attribute}
		</dd>
	  </dl>
	  {/if}
	{/foreach}
    
    {include uri='design:parts/children.tpl' view='line'}
	
	{include uri=concat('design:parts/relations.tpl') node=$node}   
	
  </div>
  
  {* Per visualizzare l'extrainfo: aggiungi la classe "full-stack" al primo div e scommenta la seguenta inclusione *}
  {*include uri='design:parts/content-related.tpl'*}
  
</div>
