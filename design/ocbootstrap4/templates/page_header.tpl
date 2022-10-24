{def $root_node = fetch( 'content', 'node', hash( 'node_id', $pagedata.root_node ) )}

<nav class="navbar navbar-expand-md navbar-dark bg-dark">
    <a class="navbar-brand" href="{'/'|ezurl(no)}" title="{ezini('SiteSettings','SiteName')|wash}">{ezini('SiteSettings','SiteName')|wash}</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarDefault" aria-controls="navbarDefault" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarDefault">
        <ul class="navbar-nav mr-auto">

            {def $top_menu_class_filter = appini( 'MenuContentSettings', 'TopIdentifierList', array() )
                 $top_menu_items = fetch( 'content', 'list', hash( 'parent_node_id', $root_node.node_id,
                                          'sort_by', $root_node.sort_array,
                                          'limit', 10,
                                          'class_filter_type', 'include',
                                          'class_filter_array', $top_menu_class_filter ) )
                 $top_menu_items_count = $top_menu_items|count()}

            {if $top_menu_items_count}
                {foreach $top_menu_items as $key => $item}
                    {node_view_gui content_node=$item
                                   view='nav-main_item'
                                   key=$key
                                   current_node_id=$current_node_id
                                   ui_context=$ui_context
                                   pagedata=$pagedata
                                   top_menu_items_count=$top_menu_items_count}
                {/foreach}
            {/if}
        </ul>

        {* search form *}
        <form class="form-inline my-2 my-lg-0 mr-2 me-2" action="{'/content/search'|ezurl( 'no' )}" method="get">
            <div class="input-group">
                <input id="site-wide-search-field" class="form-control" name="SearchText" type="text" placeholder="{'Search'|i18n('design/ocbootstrap/pagelayout')}" aria-label="{'Search'|i18n('design/ocbootstrap/pagelayout')}">
                <div class="input-group-append">
                    <button class="btn btn-info" type="submit" {if $pagedata.is_edit}disabled="disabled"{/if} title="{'Search'|i18n('design/ocbootstrap/pagelayout')}">
                        <i class="fa fa-search"></i>
                    </button>
                </div>
                {if eq( $ui_context, 'browse' )}
                    <input name="Mode" type="hidden" value="browse" />
                {/if}
            </div>
        </form>

        {* languages *}
        {def $lang_selector = array()
             $avail_translation = array()}
        {if and( is_set( $DesignKeys:used.url_alias ), $DesignKeys:used.url_alias|count|ge( 1 ) )}
            {set $avail_translation = language_switcher( $DesignKeys:used.url_alias )}
        {else}
            {set $avail_translation = language_switcher( $site.uri.original_uri )}
        {/if}


        {if $avail_translation|count|gt( 1 )}
            {foreach $avail_translation as $siteaccess => $lang}
            {if is_set($lang.locale)}
                {append-block variable=$lang_selector}
                {if $siteaccess|eq( $access_type.name )}
                    <a class="dropdown-item" href="#" style="background:url({$lang.locale|flag_icon()}) no-repeat 5px center">{$lang.text|wash}</a>
                {else}
                    <a class="dropdown-item" href={$lang.url|ezurl}>{$lang.text|wash}</a>
                {/if}
                {/append-block}
                {if $siteaccess|eq( $access_type.name )}
                    <a href="#lang-selector" class="dropdown-item current-lang">{$lang.text|wash()}&nbsp;</a>
                {/if}
            {/if}
            {/foreach}

            <ul class="navbar-nav mr-2 me-2">
                <li class="nav-item active">
                    <a class="nav-link" id="dropdown-language" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <i class="fa fa-globe"></i> <span class="d-inline d-md-none">{'Languages'|i18n('design/ocbootstrap/pagelayout')}</span>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdown-language">
                        {$lang_selector|implode( '' )}
                    </div>
                </li>
            </ul>
        {/if}
        {undef $lang_selector}

        {* login logout *}
        <ul class="navbar-nav">
            <li class="nav-item active">
                {if $current_user.is_logged_in}
                    <a class="nav-link" id="dropdown-user" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <i class="fa fa-user"></i> <span class="d-inline d-md-none">{$current_user.contentobject.name|wash}</span>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdown-user">
                        <a class="dropdown-item" href="{'/user/edit/'|ezurl(no)}" title="{'My profile'|i18n('design/ocbootstrap/pagelayout')}">{'My profile'|i18n('design/ocbootstrap/pagelayout')}</a>
                        {if fetch( 'user', 'has_access_to', hash( 'module', 'content', 'function', 'dashboard' ))}
                            <a class="dropdown-item" href={"/content/dashboard/"|ezurl} title="{'Dashboard'|i18n('design/admin/content/dashboard')}">{'Dashboard'|i18n('design/admin/content/dashboard')}</a>
                        {/if}
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href={"/user/logout"|ezurl} title="{'Logout'|i18n('design/ocbootstrap/pagelayout')}">{'Logout'|i18n('design/ocbootstrap/pagelayout')} ({$current_user.contentobject.name|wash})</a>
                    </div>
                {else}
                    <a class="nav-link" id="dropdown-login" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <i class="fa fa-lock"></i> <span class="d-inline d-md-none">{'Login'|i18n('design/ocbootstrap/pagelayout')}</span>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdown-login">
                        <form class="px-4 py-3" action="{'/user/login'|ezurl( 'no' )}" method="post">
                            <div class="form-group">
                                <label class="sr-only" for="loginDropdownFormEmail1">{'Username'|i18n('design/ocbootstrap/pagelayout')}</label>
                                <input type="text" class="form-control" id="loginDropdownFormEmail1" placeholder="{'Username'|i18n('design/ocbootstrap/pagelayout')}" name="Login">
                            </div>
                            <div class="form-group">
                                <label class="sr-only" for="loginDropdownFormPassword1">{'Password'|i18n('design/ocbootstrap/pagelayout')}</label>
                                <input type="password" class="form-control" id="loginDropdownFormPassword1" placeholder="Password" name="Password">
                            </div>
                            <div class="clearfix">
                                <input type="submit" class="btn btn-primary float-right" value="{'Login'|i18n('design/ocbootstrap/pagelayout')}" />
                            </div>
                            <input type="hidden" name="RedirectURI" value="" />
                        </form>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href={if ezmodule( 'userpaex' )}{'/userpaex/forgotpassword'|ezurl}{else}{"/user/forgotpassword"|ezurl}{/if}>{'Forgot your password?'|i18n('design/ocbootstrap/pagelayout')}</a>
                        {if ezmodule( 'user/register' )}
                            <a class="dropdown-item" href="{'/user/register'|ezurl(no)}">{'Register'|i18n('design/ocbootstrap/pagelayout')}</a>
                        {/if}
                    </div>
                {/if}
            </li>
        </ul>

    </div>
</nav>
{undef $root_node $top_menu_class_filter $top_menu_items $top_menu_items_count}