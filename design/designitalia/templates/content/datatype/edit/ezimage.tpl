{default attribute_base='ContentObjectAttribute' html_class='Form-input' placeholder=false() }
{let attribute_content=$attribute.content}

{def $contentclass_attribute = $attribute.contentclass_attribute}
<fieldset class="Form-field{if $attribute.has_validation_error} has-error{/if}">
    <legend class="Form-label {if $attribute.is_required}is-required{/if}">
        {first_set( $contentclass_attribute.nameList[$content_language], $contentclass_attribute.name )|wash}
        {if $attribute.is_information_collector} <em class="collector">{'information collector'|i18n( 'design/admin/content/edit_attribute' )}</em>{/if}
        {if $attribute.is_required} ({'richiesto'|i18n('design/ocbootstrap/designitalia')}){/if}
    </legend>

    <div class="Grid Grid--withGutter zones">

        <div class="Grid-cell u-sizeFull u-sm-size1of3 u-md-size1of3 u-lg-size1of3">

            {if $attribute_content.original.is_valid}

                <div class="Card Card--round Card--withBorder Card--shadow u-color-grey-30 u-background-white">
                    <figure class="Card-image u-background-grey-60 u-padding-all-s u-textCenter">
                        {attribute_view_gui image_class=medium attribute=$attribute}
                        <figcaption class="u-padding-r-top u-textLeft">
                            <span class="u-color-white u-floatRight u-text-r-l">
                                {if $attribute_content.original.is_valid}
                                    <button class="u-color-white" type="submit" name="CustomActionButton[{$attribute.id}_delete_image]" title="{'Remove image'|i18n( 'design/standard/content/datatype' )}">
                                        <span class="fa fa-trash"></span>
                                    </button>
                                {/if}
                            </span>
                            <p class="u-color-teal-50 u-text-r-xxs u-textWeight-700 u-padding-bottom-xs">{$attribute.content.original.original_filename|wash( xhtml )}</p>
                            <p class="u-color-white u-text-r-xxs">{$attribute.content.original.mime_type|wash( xhtml )} {$attribute.content.original.filesize|si( byte )}</p>
                        </figcaption>
                    </figure>
                </div>

            {else}
                <em>{'There is no image file.'|i18n( 'design/standard/content/datatype' )}</em>
            {/if}


        </div>

        <div class="Grid-cell u-sizeFull u-sm-size2of3 u-md-size2of3 u-lg-size2of3">
            <input type="hidden" name="MAX_FILE_SIZE" value="{$attribute.contentclass_attribute.data_int1|mul( 1024, 1024 )}" />
            <label class="Form-label {if $attribute.is_required}is-required{/if}" for="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}_file">
                {'New image file for upload'|i18n( 'design/standard/content/datatype' )}:
            </label>
            <input id="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}_file"
                   class="{$html_class} ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}"
                   name="{$attribute_base}_data_imagename_{$attribute.id}" type="file" />

            <input placeholder="{'Alternative image text'|i18n( 'design/standard/content/datatype' )}"
                   id="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}_alttext"
                   class="{$html_class} ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}"
                   name="{$attribute_base}_data_imagealttext_{$attribute.id}"
                   type="text"
                   value="{$attribute_content.alternative_text|wash(xhtml)}" />
        </div>
    </div>





</fieldset>
{undef $contentclass_attribute}

{/let}
{/default}
