<div class='page-header page-header-with-buttons'>
    <h1>{'Dashboard'|i18n( 'design/admin/content/dashboard' )}</h1>
</div>

{foreach $blocks as $block}
	<div class="card mb-3">
		<div class="card-body">
			{if $block.template}
				{include uri=concat( 'design:', $block.template )}
			{else}
				{include uri=concat( 'design:dashboard/', $block.identifier, '.tpl' )}
			{/if}
		</div>
	</div>
{/foreach}