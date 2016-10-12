{default attribute_base='ContentObjectAttribute' html_class='full' placeholder=false()}
{def $contentclass_attribute = $attribute.contentclass_attribute}
<div class="Form-field{if $attribute.has_validation_error} has-error{/if}">
    <label class="Form-label {if $attribute.is_required}is-required{/if}" for="ezcoa-{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}">
        {first_set( $contentclass_attribute.nameList[$content_language], $contentclass_attribute.name )|wash}
        {if $attribute.is_information_collector} <em class="collector">{'information collector'|i18n( 'design/admin/content/edit_attribute' )}</em>{/if}
        {if $attribute.is_required} ({'richiesto'|i18n('design/ocbootstrap/designitalia')}){/if}
    </label>
    <input class="Form-input ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}"
           id="ezcoa-{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}"
           type="text"
           size="70"
           name="{$attribute_base}_ezstring_data_text_{$attribute.id}"
           value="{$attribute.data_text|wash( xhtml )}"
           {if $contentclass_attribute.description}aria-describedby="info-{$attribute.contentclassattribute_id}"{/if}
           {if $attribute.is_required}required aria-required="true"{/if}>
    {if $contentclass_attribute.description}
        <div role="tooltip" id="info-{$attribute.contentclassattribute_id}">{first_set( $contentclass_attribute.descriptionList[$content_language], $contentclass_attribute.description)|wash}</div>
    {/if}
</div>
{undef $contentclass_attribute}
{/default}
