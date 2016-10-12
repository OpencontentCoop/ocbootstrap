{default $view_parameters            = array()
$attribute_categorys        = ezini( 'ClassAttributeSettings', 'CategoryList', 'content.ini' )
$attribute_default_category = ezini( 'ClassAttributeSettings', 'DefaultCategory', 'content.ini' )}

<div class="Grid Grid--withGutter u-padding-top-xxl">
    <div class="Grid-cell u-sizeFull u-sm-size8of12 u-md-size8of12 u-lg-size8of12">

        <div class="Accordion fr-accordion js-fr-accordion" id="accordion-edit-attributes">
            {foreach $content_attributes_grouped_data_map as $attribute_group => $content_attributes_grouped}

                {if $attribute_default_category|ne($attribute_group)}
                    <h2 class="Accordion-header js-fr-accordion__header fr-accordion__header"
                        id="accordion-header-{$attribute_group}">
                        <span class="Accordion-link u-text-r-s">{$attribute_categorys[$attribute_group]}</span>
                    </h2>
                {/if}
                <div id="accordion-panel-{$attribute_group}"
                     class="Accordion-panel{if $attribute_default_category|ne($attribute_group)} fr-accordion__panel js-fr-accordion__panel{/if} {*u-layout-prose*} u-color-grey-90 u-padding-top-l">

                    {foreach $content_attributes_grouped as $attribute_identifier => $attribute}
                        {def $contentclass_attribute = $attribute.contentclass_attribute}

                        {* Show view GUI if we can't edit, otherwise: show edit GUI. *}
                        {if and( eq( $attribute.can_translate, 0 ), ne( $object.initial_language_code, $attribute.language_code ) )}
                            <div class="col-md-3">
                                <p>{first_set( $contentclass_attribute.nameList[$content_language], $contentclass_attribute.name )|wash}
                                    {if $attribute.can_translate|not} <span class="nontranslatable">
                                        ({'not translatable'|i18n( 'design/admin/content/edit_attribute' )})</span>{/if}
                                    :
                                    {if $contentclass_attribute.description} <span
                                            class="classattribute-description">{first_set( $contentclass_attribute.descriptionList[$content_language], $contentclass_attribute.description)|wash}</span>{/if}
                                </p>
                            </div>
                            <div class="col-md-9">
                                {if $is_translating_content}
                                    <div class="original">
                                        {attribute_view_gui attribute_base=$attribute_base attribute=$attribute view_parameters=$view_parameters}
                                        <input type="hidden" name="ContentObjectAttribute_id[]"
                                               value="{$attribute.id}"/>
                                    </div>
                                {else}
                                    {attribute_view_gui attribute_base=$attribute_base attribute=$attribute view_parameters=$view_parameters}
                                    <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}"/>
                                {/if}
                            </div>
                        {else}
                            {if $is_translating_content}
                                <div class="col-md-3">
                                    <p{if $attribute.has_validation_error} class="message-error"{/if}>{first_set( $contentclass_attribute.nameList[$content_language], $contentclass_attribute.name )|wash}
                                        {if $attribute.is_required} <span class="required"
                                                                          title="{'required'|i18n( 'design/admin/content/edit_attribute' )}">
                                                *</span>{/if}
                                        {if $attribute.is_information_collector} <span class="collector">
                                            ({'information collector'|i18n( 'design/admin/content/edit_attribute' )}
                                            )</span>{/if}:
                                        {if $contentclass_attribute.description} <span
                                                class="classattribute-description">{first_set( $contentclass_attribute.descriptionList[$content_language], $contentclass_attribute.description)|wash}</span>{/if}
                                    </p>
                                </div>
                                <div class="col-md-9">
                                    <div class="well well-sm">
                                        {attribute_view_gui attribute_base=$attribute_base attribute=$from_content_attributes_grouped_data_map[$attribute_group][$attribute_identifier] view_parameters=$view_parameters image_class=medium}
                                    </div>
                                    <div>
                                        {if $attribute.display_info.edit.grouped_input}
                                            <fieldset>
                                                {attribute_edit_gui attribute_base=$attribute_base attribute=$attribute view_parameters=$view_parameters html_class='form-control'}
                                                <input type="hidden" name="ContentObjectAttribute_id[]"
                                                       value="{$attribute.id}"/>
                                            </fieldset>
                                        {else}
                                            {attribute_edit_gui attribute_base=$attribute_base attribute=$attribute view_parameters=$view_parameters html_class='form-control'}
                                            <input type="hidden" name="ContentObjectAttribute_id[]"
                                                   value="{$attribute.id}"/>
                                        {/if}
                                    </div>
                                </div>
                            {else}
                                {attribute_edit_gui attribute_base=$attribute_base attribute=$attribute view_parameters=$view_parameters html_class='Form-input'}
                                <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}"/>
                            {/if}
                        {/if}
                        {undef $contentclass_attribute}
                    {/foreach}
                </div>
            {/foreach}
        </div>
    </div>

    <div class="Grid-cell u-sizeFull u-sm-size4of12 u-md-size4of12 u-lg-size4of12">
        {include uri="design:content/edit_right_menu.tpl"}
    </div>

</div>
