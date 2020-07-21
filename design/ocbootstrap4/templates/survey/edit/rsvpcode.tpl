<fieldset>
    <legend>{"RSVP Code"|i18n('survey')}</legend>

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

    <div class="form-group mb-3">
        <label for="{$prefix_attribute}_ezsurvey_question_{$question.id}_text2_{$attribute_id}" class="m-0">{"Code (separated by commas)"|i18n('survey')}:</label>
        <input class="form-control border" type="text" id="{$prefix_attribute}_ezsurvey_question_{$question.id}_text2_{$attribute_id}" name="{$prefix_attribute}_ezsurvey_question_{$question.id}_text2_{$attribute_id}" value="{$question.text2|wash('xhtml')}" size="70" />
    </div>
</fieldset>