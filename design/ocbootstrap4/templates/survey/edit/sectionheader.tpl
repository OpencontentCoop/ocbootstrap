<fieldset>
  <legend>{"Section header"|i18n( 'survey' )}</legend>

  <div class="form-group mb-3">
    <label class="m-0" for="{$prefix_attribute}_ezsurvey_question_{$question.id}_text_{$attribute_id}">{"Text of header"|i18n( 'survey' )}:</label>
    <input class="form-control border" type="text" id="{$prefix_attribute}_ezsurvey_question_{$question.id}_text_{$attribute_id}" name="{$prefix_attribute}_ezsurvey_question_{$question.id}_text_{$attribute_id}" value="{$question.text|wash('xhtml')}" size="30" />
  </div>
</fieldset>