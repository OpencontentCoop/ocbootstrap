<div class="nav-facets">		
	{if $data.navigation|count}
	<ul class="nav">
	  {foreach $data.navigation as $name => $items}
		<li class="disabled"><a href="]">{$name|wash()}</a>
		  <div class="list-group">
			  {foreach $items as $item}
				  <a class="{if $item.active}active {/if}list-group-item" href="{$item.url|ezurl( 'no' )}" data-key={$name} data-value="{$item.name}">
					<span class="badge">{$item.count}</span>
					{$item.name|wash()} 
				  </a>
			  {/foreach}
		  </div>
		</li>
		{/foreach}
	</ul>
	{/if}	
</div>