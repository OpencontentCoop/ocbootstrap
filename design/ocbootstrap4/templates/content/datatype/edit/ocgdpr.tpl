{default attribute_base=ContentObjectAttribute}
    <div class="form-group form-check">
        <input id="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}"
               class="form-check-input ezcc-{$attribute.object.content_class.identifier} ezcca-{$attribute.object.content_class.identifier}_{$attribute.contentclass_attribute_identifier}"
               type="checkbox" name="{$attribute_base}_ocgdpr_data_int_{$attribute.id}"
                {$attribute.data_int|choose( '', 'checked="checked"' )}
               value="" />
        <label class="form-check-label" for="ezcoa-{if ne( $attribute_base, 'ContentObjectAttribute' )}{$attribute_base}-{/if}{$attribute.contentclassattribute_id}_{$attribute.contentclass_attribute_identifier}">
            <div style="font-weight: normal">{$attribute.contentclass_attribute.data_text5}</div>
            <a target="_blank" href="{$attribute.contentclass_attribute.data_text4|wash()}">{$attribute.contentclass_attribute.data_text3|wash()}</a>
        </label>
    </div>
{/default}
