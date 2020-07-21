<fieldset>
    <legend>{"Text entry (Validated)"|i18n('survey')}</legend>

    <div class="form-group mb-3">
        <label for="{$prefix_attribute}_ezsurvey_question_{$question.id}_num_{$attribute_id}" class="m-0">{"Number of columns for an answer textarea"|i18n('survey')}:</label>
        <input class="form-control border" type="text" id="{$prefix_attribute}_ezsurvey_question_{$question.id}_num_{$attribute_id}" name="{$prefix_attribute}_ezsurvey_question_{$question.id}_num_{$attribute_id}" value="{$question.num|wash('xhtml')}" size="3" />
    </div>

    <div class="form-group mb-3">
        <label for="{$prefix_attribute}_ezsurvey_question_{$question.id}_num2_{$attribute_id}" class="m-0">{"Number of rows"|i18n('survey')}:</label>
        <input class="form-control border" type="text" id="{$prefix_attribute}_ezsurvey_question_{$question.id}_num2_{$attribute_id}" name="{$prefix_attribute}_ezsurvey_question_{$question.id}_num2_{$attribute_id}" value="{$question.num2|wash('xhtml')}" size="3" />
    </div>

    <div class="form-group mb-3">
        <label for="{$prefix_attribute}_ezsurvey_question_{$question.id}_text_{$attribute_id}" class="m-0">{"Text of question"|i18n('survey')}:</label>
        <input class="form-control border" type="text" id="{$prefix_attribute}_ezsurvey_question_{$question.id}_text_{$attribute_id}" name="{$prefix_attribute}_ezsurvey_question_{$question.id}_text_{$attribute_id}" value="{$question.text|wash('xhtml')}" size="70" />
    </div>

    <div class="form-check mb-3">
        <input type="hidden" name="{$prefix_attribute}_ezsurvey_question_{$question.id}_mandatory_hidden_{$attribute_id}" value="1" />
        <input class="form-check-input" type="checkbox" id="{$prefix_attribute}_ezsurvey_question_{$question.id}_mandatory_{$attribute_id}" name="{$prefix_attribute}_ezsurvey_question_{$question.id}_mandatory_{$attribute_id}" value="1" {section show=$question.mandatory}checked{/section} />
        <label class="m-0" class="form-check-label" for="{$prefix_attribute}_ezsurvey_question_{$question.id}_mandatory_{$attribute_id}">{"Mandatory answer"|i18n('survey')}</label>
    </div>

    {* Validation Type. *}
    {def $validation_options        = ezini("Validation", "ValidationTypes", "mugosurveyvalidators.ini")}
    {def $validation_descriptions   = ezini("Validation", "ValidationTypesDescriptions", "mugosurveyvalidators.ini")}
    <div class="form-group mb-3">
        <label for="{$prefix_attribute}_ezsurvey_question_{$question.id}_text2_{$attribute_id}" class="m-0">{'Validation Type'|i18n( 'survey' )}:</label>
        <select class="form-control border"  name="{$prefix_attribute}_ezsurvey_question_{$question.id}_text2_{$attribute_id}" id="{$prefix_attribute}_ezsurvey_question_{$question.id}_text2_{$attribute_id}">
            {foreach $validation_options as $option}
            <option value="{$option}"
                    {section show=eq($question.text2,$option)}selected{/section}>
                {$validation_descriptions.$option}
            </option>
            {/foreach}
        </select>
    </div>

    <div class="form-group mb-3">
        <label for="{$prefix_attribute}_ezsurvey_question_{$question.id}_text3_{$attribute_id}" class="m-0">{"Default settings"|i18n('survey')}:</label>
        <select class="form-control border"  name="{$prefix_attribute}_ezsurvey_question_{$question.id}_text3_{$attribute_id}" id="{$prefix_attribute}_ezsurvey_question_{$question.id}_text3_{$attribute_id}">
            <option value="" {section show=$question.text3|eq('')} selected="selected"{/section}>{"Default answer"|i18n('survey')}</option>
            <option value="user_email" {section show=$question.text3|eq('user_email')} selected="selected"{/section}>{"User email"|i18n('survey')}</option>
            <option value="user_name" {section show=$question.text3|eq('user_name')} selected="selected"{/section}>{"User name"|i18n('survey')}</option>
        </select>
    </div>

    <div class="form-group mb-3">
        <label for="{$prefix_attribute}_ezsurvey_question_{$question.id}_default_{$attribute_id}" class="m-0">{"Default answer"|i18n('survey')}:</label>
        <input class="form-control border" type="text" name="{$prefix_attribute}_ezsurvey_question_{$question.id}_default_{$attribute_id}" id="{$prefix_attribute}_ezsurvey_question_{$question.id}_default_{$attribute_id}" value="{$question.default_value|wash('xhtml')}" size="70" />
    </div>
</fieldset>