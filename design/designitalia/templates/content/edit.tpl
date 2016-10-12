{ezscript_require(array('ezjsc::jquery', 'plugins/chosen.jquery.js', 'plugins/edit.js'))}
{def $_redirect = false()}
{if ezhttp_hasvariable( 'RedirectURIAfterPublish', 'session' )}
    {set $_redirect = ezhttp( 'RedirectURIAfterPublish', 'session' )}
{elseif ezhttp_hasvariable( 'LastAccessesURI', 'session' )}
    {set $_redirect = ezhttp( 'LastAccessesURI', 'session' )}
{elseif $object.main_node_id}
    {set $_redirect = concat( 'content/view/full/', $object.main_node_id )}
{elseif ezhttp( 'url', 'get', true() )}
    {set $_redirect = ezhttp( 'url', 'get' )}
{/if}

{def $tab = ''}
{if and( ezhttp_hasvariable( 'tab', 'get' ), is_set( $view_parameters.tab )|not() )}
    {set $tab = ezhttp( 'tab', 'get' )}
    {set $_redirect = concat( $_redirect, '/(tab)/', $tab )}
{/if}

{*{include uri='design:parts/website_toolbar_edit.tpl'}*}

<form class="Form Form--spaced u-padding-all-xl {*u-layout-prose*} u-text-r-xs" enctype="multipart/form-data" method="post" action={concat("/content/edit/",$object.id,"/",$edit_version,"/",$edit_language|not|choose(concat($edit_language,"/"),''))|ezurl}>

    <div class="Grid Grid--withGutter">
        <div class="Grid-cell u-md-size3of4 u-lg-size3of4">
            <h2 class="u-text-h2">
                <i class='icon-edit'></i>
                <span>Modifica {$object.name|wash}</span>
                <small>{$class.name|wash}</small>
            </h2>
        </div>

        <div class="Grid-cell u-md-size1of4 u-lg-size1of4">
            <p class="{*u-layout-prose*} u-color-grey-90 u-text-p u-padding-r-bottom u-padding-r-top">
                {def $language_index = 0 $from_language_index = 0 $translation_list = $content_version.translation_list}
                {foreach $translation_list as $index => $translation} {if eq( $edit_language, $translation.language_code )} {set $language_index = $index} {/if}{/foreach}

                {if $is_translating_content}
                    {def $from_language_object = $object.languages[$from_language]}

                    {'Translating content from %from_lang to %to_lang'|i18n( 'design/ezwebin/content/edit',, hash(
                '%from_lang', concat( $from_language_object.name, '&nbsp;<img src="', $from_language_object.locale|flag_icon, '" style="vertical-align: middle;" alt="', $from_language_object.locale, '" />' ),
                '%to_lang', concat( $translation_list[$language_index].locale.intl_language_name, '&nbsp;<img src="', $translation_list[$language_index].language_code|flag_icon, '" style="vertical-align: middle;" alt="', $translation_list[$language_index].language_code, '" />' )
                ) )}
                {else}
                    {'Content in %language'|i18n( 'design/ezwebin/content/edit',, hash( '%language', $translation_list[$language_index].locale.intl_language_name ))}&nbsp;<img src="{$translation_list[$language_index].language_code|flag_icon}" style="vertical-align: middle;" alt="{$translation_list[$language_index].language_code}" />
                {/if}
            </p>
        </div>
    </div>

    {include uri="design:content/edit_validation.tpl"}

    {if ezini_hasvariable( 'EditSettings', 'AdditionalTemplates', 'content.ini' )}
        {foreach ezini( 'EditSettings', 'AdditionalTemplates', 'content.ini' ) as $additional_tpl}
            {include uri=concat( 'design:', $additional_tpl )}
        {/foreach}
    {/if}

    {include uri="design:content/edit_attribute.tpl"}

    <div class="Grid Grid--withGutter u-padding-top-xxl">
        <div class="Grid-cell u-size1of2">
            <input class="Button Button--danger" type="submit" name="DiscardButton" value="{'Discard'|i18n('ocbootstrap')}"/>
        </div>
        <div class="Grid-cell u-size1of2 u-textRight">
            <input class="Button Button--default" type="submit" name="PublishButton" value="{'Store'|i18n('ocbootstrap')}"/>
        </div>
        <input type="hidden" name="DiscardConfirm" value="0"/>
        <input type="hidden" name="RedirectIfDiscarded" value="{if ezhttp_hasvariable( 'RedirectIfDiscarded', 'session' )}{ezhttp( 'RedirectIfDiscarded', 'session' )}{else}{$_redirect}{/if}"/>
        <input type="hidden" name="RedirectURIAfterPublish" value="{$_redirect}"/>
    </div>

</form>


{undef $_redirect $tab}
