<div class="nav-facets">
	{if $data.navigation|count}
	<div class="row">
	  {foreach $data.navigation as $name => $items}
		<div class="facet-list">
      <h2>{$name|wash()}</h2>
		  {*<div class="list-group">*}
      <ul class="nav-sub">
        {foreach $items as $item}
          {*<a class="{if $item.active}active {/if}list-group-item" href="{$item.url|ezurl( 'no' )}" data-key={$name} data-value="{$item.name}">*}
          <li>
            <a class="{if $item.active}active{/if}" href="{$item.url|ezurl( 'no' )}" data-key={$name} data-value="{$item.name}">
              {$item.name|wash()}
              <span class="badge">{$item.count}</span>
            </a>
          </li>
			  {/foreach}
		  </ul>
		</div>
		{/foreach}
	</div>
	{/if}	
</div>