<div class='page-header page-header-with-buttons'>
    <h1>{'Dashboard'|i18n( 'design/admin/content/dashboard' )}</h1>
</div>

{def $i = 0}
{foreach $blocks as $block}  
  {if $i|eq(0)}
	<div class="row">
  {/if}
  <div class="col-sm-6">
	<div class="panel panel-default" style="height: 250px; overflow-y: auto">
	<div class="panel-body">
	  {if $block.template}
		  {include uri=concat( 'design:', $block.template )}
	  {else}
		  {include uri=concat( 'design:dashboard/', $block.identifier, '.tpl' )}
	  {/if}
	</div>
	</div>
  </div>
  {if eq(sum($i,1)|mod(2),0)}
	</div>
	<div class="row">
  {/if}
  {if $i|eq(count($blocks)|sub(1))}
	</div>
  {/if}
{set $i = $i|sum(1)}
{/foreach}