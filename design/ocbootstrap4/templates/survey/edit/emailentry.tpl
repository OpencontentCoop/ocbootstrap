<fieldset>
  <legend>{"Email entry"|i18n('survey')}</legend>

<div class="form-group mb-3">
  <label class="m-0" for="{$prefix_attribute}_ezsurvey_question_{$question.id}_text_{$attribute_id}">{"Text of question"|i18n('survey')}:</label>
  <input class="form-control border" type="text" name="{$prefix_attribute}_ezsurvey_question_{$question.id}_text_{$attribute_id}" id="{$prefix_attribute}_ezsurvey_question_{$question.id}_text_{$attribute_id}" value="{$question.text|wash('xhtml')}" size="70" />
</div>

<div class="form-check mb-3">
  <input type="hidden" name="{$prefix_attribute}_ezsurvey_question_{$question.id}_mandatory_hidden_{$attribute_id}" value="1" />
  <input class="form-check-input" type="checkbox" id="{$prefix_attribute}_ezsurvey_question_{$question.id}_mandatory_{$attribute_id}" name="{$prefix_attribute}_ezsurvey_question_{$question.id}_mandatory_{$attribute_id}" value="1" {section show=$question.mandatory}checked{/section} />
  <label class="m-0" class="form-check-label" for="{$prefix_attribute}_ezsurvey_question_{$question.id}_mandatory_{$attribute_id}">{"Mandatory answer"|i18n('survey')}</label>
</div>

<div class="form-group mb-3">
  <label class="m-0" for="{$prefix_attribute}_ezsurvey_question_{$question.id}_text3_{$attribute_id}">{"Default settings"|i18n('survey')}:</label>
  <select class="form-control border" id="{$prefix_attribute}_ezsurvey_question_{$question.id}_text3_{$attribute_id}" name="{$prefix_attribute}_ezsurvey_question_{$question.id}_text3_{$attribute_id}">
	<option value="" {section show=$question.text3|eq('')} selected="selected"{/section}>{"Default answer"|i18n('survey')}</option>
	<option value="user_email" {section show=$question.text3|eq('user_email')} selected="selected"{/section}>{"User email"|i18n('survey')}</option>
  </select>
</div>

<div class="form-group mb-3">
  <label class="m-0" for="{$prefix_attribute}_ezsurvey_question_{$question.id}_default_{$attribute_id}">{"Default answer"|i18n('survey')}:</label>
  <input class="form-control border" type="text" id="{$prefix_attribute}_ezsurvey_question_{$question.id}_default_{$attribute_id}" name="{$prefix_attribute}_ezsurvey_question_{$question.id}_default_{$attribute_id}" value="{$question.default_value|wash('xhtml')}" size="20" />
</div>
</fieldset>