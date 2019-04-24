{def $current_user = fetch( 'user', 'current_user' )
     $content_object = $current_node.object
     $can_edit_languages = $content_object.can_edit_languages
     $can_manage_location = fetch( 'content', 'access', hash( 'access', 'manage_locations', 'contentobject', $current_node ) )
     $can_create_languages = $content_object.can_create_languages
     $is_container = $content_object.content_class.is_container
     $odf_display_classes = ezini( 'WebsiteToolbarSettings', 'ODFDisplayClasses', 'websitetoolbar.ini' )
     $odf_hide_container_classes = ezini( 'WebsiteToolbarSettings', 'HideODFContainerClasses', 'websitetoolbar.ini' )
     $website_toolbar_access = fetch( 'user', 'has_access_to', hash( 'module', 'websitetoolbar', 'function', 'use' ) )
     $odf_import_access = fetch( 'user', 'has_access_to', hash( 'module', 'ezodf', 'function', 'import' ) )
     $odf_export_access = fetch( 'user', 'has_access_to', hash( 'module', 'ezodf', 'function', 'export' ) )
     $content_object_language_code = ''
     $policies = fetch( 'user', 'user_role', hash( 'user_id', $current_user.contentobject_id ) )
     $available_for_current_class = false()
     $custom_templates = ezini( 'CustomTemplateSettings', 'CustomTemplateList', 'websitetoolbar.ini' )
     $include_in_view = ezini( 'CustomTemplateSettings', 'IncludeInView', 'websitetoolbar.ini' )
     $node_hint = ': '|append( $current_node.name|wash(), ' [', $content_object.content_class.name|wash(), ']' ) }

     {foreach $policies as $policy}
        {if and( eq( $policy.moduleName, 'websitetoolbar' ),
                    eq( $policy.functionName, 'use' ),
                        is_array( $policy.limitation ) )}
            {if $policy.limitation[0].values_as_array|contains( $content_object.content_class.id )}
                {set $available_for_current_class = true()}
            {/if}
        {elseif or( and( eq( $policy.moduleName, '*' ),
                             eq( $policy.functionName, '*' ),
                                 eq( $policy.limitation, '*' ) ),
                    and( eq( $policy.moduleName, 'websitetoolbar' ),
                             eq( $policy.functionName, '*' ),
                                 eq( $policy.limitation, '*' ) ),
                    and( eq( $policy.moduleName, 'websitetoolbar' ),
                             eq( $policy.functionName, 'use' ),
                                 eq( $policy.limitation, '*' ) ) )}
            {set $available_for_current_class = true()}
        {/if}
     {/foreach}

{if and( $website_toolbar_access, $available_for_current_class )}


<form method="post" action={"content/action"|ezurl} style="display: inline;">

{if $content_object.can_remove}
    <button class="btn btn-link btn-xs px-0" type="submit" name="ActionRemove"><span class="fa-stack text-danger"><i class="fa fa-square fa-stack-2x"></i><i class="fa fa-trash-o fa-stack-1x fa-inverse"></i></span></button>
{/if}

<input type="hidden" name="ContentObjectID" value="{$content_object.id}" />
<input type="hidden" name="NodeID" value="{$current_node.node_id}" />
<input type="hidden" name="ContentNodeID" value="{$current_node.node_id}" />

{if is_set( $redirect_if_cancel )}
<input type="hidden" name="RedirectIfCancel" value="{$redirect_if_cancel}" />		
{/if}
{if is_set( $redirect_after_remove )}
<input type="hidden" name="RedirectURIAfterRemove" value="{$redirect_after_remove}" />
{/if}

</form>

{/if}