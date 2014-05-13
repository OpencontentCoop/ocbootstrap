<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<!--[if lt IE 9 ]><html class="unsupported-ie ie" lang="{$site.http_equiv.Content-language|wash}"><![endif]-->
<!--[if IE 9 ]><html class="ie ie9" lang="{$site.http_equiv.Content-language|wash}"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--><html lang="{$site.http_equiv.Content-language|wash}"><!--<![endif]-->
<head>
{def $basket_is_empty   = cond( $current_user.is_logged_in, fetch( shop, basket ).is_empty, 1 )
     $user_hash         = concat( $current_user.role_id_list|implode( ',' ), ',', $current_user.limited_assignment_value_list|implode( ',' ) )}


{if is_set( $extra_cache_key )|not}
    {def $extra_cache_key = ''}
{/if}

{def $pagedata        = ezpagedata()}
{*$inner_column_size = $pagedata.inner_column_size
$outer_column_size = $pagedata.outer_column_size*}

{cache-block keys=array( $module_result.uri, $basket_is_empty, $current_user.contentobject_id, $extra_cache_key )}
{def $pagestyle        = $pagedata.css_classes
     $locales          = fetch( 'content', 'translation_list' )
     $current_node_id  = $pagedata.node_id}

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

{include uri='design:page_head.tpl'}
{include uri='design:page_head_style.tpl'}
{include uri='design:page_head_script.tpl'}

</head>
<body>
<!-- Complete page area: START -->

<div id="page">

    <!-- Header area: START -->
    {include uri='design:page_header.tpl'}
    <!-- Header area: END -->

    {cache-block keys=array( $module_result.uri, $user_hash, $extra_cache_key )}

     <!-- nav-main: START -->
    {include uri='design:nav/nav-main.tpl'}
    <!-- nav-main: END -->

    <!-- Toolbar area: START -->
    {if and( $pagedata.website_toolbar, $pagedata.is_edit|not)}
        {include uri='design:page_toolbar.tpl'}
    {/if}
    <!-- Toolbar area: END -->

    <div class="container">
    {/cache-block}
    {/cache-block}
      {*include uri='design:page_mainarea.tpl'*}
      {$module_result.content}

{cache-block keys=array( $module_result.uri, $user_hash, $access_type.name, $extra_cache_key )}

    </div>

    <!-- Footer area: START -->
    {include uri='design:page_footer.tpl'}
    <!-- Footer area: END -->

</div>
<!-- Complete page area: END -->

<!-- Footer script area: START -->
{include uri='design:page_footer_script.tpl'}
<!-- Footer script area: END -->

{* Codice extra usato da plugin javascript *}
{include uri='design:page_extra.tpl'}

{/cache-block}

{* This comment will be replaced with actual debug report (if debug is on). *}
<!--DEBUG_REPORT-->
</body>
</html>
