<div class="nav-facets">
	{if $data.navigation|count}
	<div class="row">
	  
	  {foreach $data.navigation as $name => $items}
		<ul class="list-unstyled">
		  {foreach $items as $item}
			{if $item.active}			  
			  <li>
				<a class="active btn btn-primary btn-xs" href="{$item.url|ezurl( 'no' )}" data-key={$name} data-value="{$item.name}">
				  <strong>{$name|wash()}:</strong>
				  {$item.name|wash()}				  
				</a>
			  </li>
			  {/if}
		  {/foreach}
		</ul>	  
	  {/foreach}

	  {foreach $data.navigation as $name => $items}	  
	  <div class="facet-list">
		<h2>{$name|wash()}</h2>		  
		<ul class="nav-sub">
		  {foreach $items as $item}
			{if $item.active|not()}			  
			  <li>
				<a href="{$item.url|ezurl( 'no' )}" data-key={$name} data-value="{$item.name}">
				  {$item.name|wash()}
				  <span class="badge">{$item.count}</span>
				</a>
			  </li>
			  {/if}
		  {/foreach}
		</ul>
	  </div>	  
	  {/foreach}
	  
	</div>
	{/if}	
</div>