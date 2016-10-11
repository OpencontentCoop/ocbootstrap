<div class="u-layout-wide u-layoutCenter u-layout-withGutter u-padding-r-bottom u-padding-top-s">
    <nav aria-label="sei qui:" role="navigation">
        <ul class="Breadcrumb">
            {foreach $pagedata.path_array as $path}
                {if $path.url}
                    <li class="Breadcrumb-item">
                        <a class="Breadcrumb-link u-color-50"
                           href={cond( is_set( $path.url_alias ), $path.url_alias, $path.url )|ezurl}>{$path.text|wash}</a>
                    </li>
                {/if}
            {/foreach}
        </ul>
    </nav>
</div>
