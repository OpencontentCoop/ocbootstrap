<nav aria-label="breadcrumb">
    <ol class="breadcrumb">
        {foreach $pagedata.path_array as $path}
            {if $path.url}
                <li class="breadcrumb-item">
                    <a href={cond( is_set( $path.url_alias ), $path.url_alias, $path.url )|ezurl}>{$path.text|wash}</a>
                </li>
            {else}
                <li class="breadcrumb-item active" aria-current="page">
                    {$path.text|wash}
                </li>
            {/if}
        {/foreach}
    </ol>
</nav>
