{def $basket_is_empty = cond( $current_user.is_logged_in, fetch( shop, basket ).is_empty, 1 )
     $user_hash = concat( $current_user.role_id_list|implode( ',' ), ',', $current_user.limited_assignment_value_list|implode( ',' ) )
     $pagedata = ezpagedata()
     $current_node_id = $pagedata.node_id
     $has_container = cond(is_set($module_result.content_info.persistent_variable.has_container), true(), false())
     $show_breadcrumb = cond(and( $pagedata.node_id|ne( ezini( 'NodeSettings', 'RootNode', 'content.ini' ) ), $pagedata.show_path, array( 'edit', 'browse' )|contains( $ui_context )|not() ), true(), false())}

{if is_set( $extra_cache_key )|not}
    {def $extra_cache_key = ''}
{/if}


<!doctype html>
<html lang="{$site.http_equiv.Content-language|wash}">

<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    {no_index_if_needed()}
    {include uri='design:page_head.tpl'}
    {include uri='design:page_head_style.tpl'}
    {include uri='design:page_head_script.tpl'}
</head>

<body>

{cache-block keys=array( $module_result.uri, $user_hash, $extra_cache_key )}
    {if is_set($pagedata)|not()}
        {def $pagedata = ezpagedata()
             $current_node_id = $pagedata.node_id}
    {/if}


    {include uri='design:page_header.tpl'}

    {if and( $pagedata.website_toolbar, $pagedata.is_edit|not)}
        {include uri='design:page_toolbar.tpl'}
    {/if}

    {if $show_breadcrumb}
        {include uri='design:breadcrumb.tpl'}
    {/if}

{/cache-block}

    <main role="main"{if $has_container|not()}class="container{if $show_breadcrumb|not()} mt-3{/if}"{/if}>
        {$module_result.content}
    </main>

{cache-block keys=array( $module_result.uri, $user_hash, $access_type.name, $extra_cache_key )}
    {if is_set($pagedata)|not()}
        {def $pagedata = ezpagedata()
             $current_node_id = $pagedata.node_id}
    {/if}

    {include uri='design:page_footer.tpl'}

    {include uri='design:page_footer_script.tpl'}

    {include uri='design:page_extra.tpl'}

{/cache-block}

{* This comment will be replaced with actual debug report (if debug is on). *}
<!--DEBUG_REPORT-->
</body>
</html>
