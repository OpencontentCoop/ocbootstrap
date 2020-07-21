<fieldset>
  <legend>{"Paragraph"|i18n( 'survey' )}</legend>

  <div class="form-group mb-3">
    <label class="m-0" for="{$prefix_attribute}_ezsurvey_question_{$question.id}_text_{$attribute_id}">{"Text of paragraph"|i18n( 'survey' )}:</label>
    <textarea class="form-control border" id="{$prefix_attribute}_ezsurvey_question_{$question.id}_text_{$attribute_id}" name="{$prefix_attribute}_ezsurvey_question_{$question.id}_text_{$attribute_id}" cols="70" rows="5" >{$question.text|wash('xhtml')}</textarea>
  </div>
</fieldset>