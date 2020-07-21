<fieldset>
  <legend>{"Text entry"|i18n('survey')}</legend>

  <div class="form-group mb-3">
    <label class="m-0" for="{$prefix_attribute}_ezsurvey_question_{$question.id}_text_{$attribute_id}">{"Text of question"|i18n('survey')}:</label>
    <input class="form-control border" type="text" id="{$prefix_attribute}_ezsurvey_question_{$question.id}_text_{$attribute_id}" name="{$prefix_attribute}_ezsurvey_question_{$question.id}_text_{$attribute_id}" value="{$question.text|wash('xhtml')}" size="70" />
  </div>

  <div class="form-group mb-3 mx-1 row">
    <label class="m-0 col-sm-10 col-form-label" for="{$prefix_attribute}_ezsurvey_question_{$question.id}_num_{$attribute_id}">{"Number of columns for an answer textarea"|i18n('survey')}:</label>
    <div class="col-sm-2">
      <input class="form-control border" type="text" id="{$prefix_attribute}_ezsurvey_question_{$question.id}_num_{$attribute_id}" name="{$prefix_attribute}_ezsurvey_question_{$question.id}_num_{$attribute_id}" value="{$question.num|wash('xhtml')}" size="3" />
    </div>
  </div>

  <div class="form-group mb-3 mx-1 row">
    <label class="m-0 col-sm-10 col-form-label" for="{$prefix_attribute}_ezsurvey_question_{$question.id}_num2_{$attribute_id}">{"Number of rows"|i18n('survey')}:</label>
    <div class="col-sm-2">
      <input class="form-control border" type="text" id="{$prefix_attribute}_ezsurvey_question_{$question.id}_num2_{$attribute_id}" name="{$prefix_attribute}_ezsurvey_question_{$question.id}_num2_{$attribute_id}" value="{$question.num2|wash('xhtml')}" size="3" />
    </div>
  </div>

  <div class="form-group form-check mb-2">
    <input type="hidden" name="{$prefix_attribute}_ezsurvey_question_{$question.id}_mandatory_hidden_{$attribute_id}" value="1" />
    <input class="form-check-input" type="checkbox" id="{$prefix_attribute}_ezsurvey_question_{$question.id}_mandatory_{$attribute_id}" name="{$prefix_attribute}_ezsurvey_question_{$question.id}_mandatory_{$attribute_id}" value="1"{section show=$question.mandatory} checked="checked"{/section} />
    <label class="form-check-label" for="{$prefix_attribute}_ezsurvey_question_{$question.id}_mandatory_{$attribute_id}">{"Mandatory answer"|i18n('survey')}</label>
  </div>

  <div class="form-group mb-3 mx-1 row">
    <label class="m-0 col-sm-6 col-form-label" for="{$prefix_attribute}_ezsurvey_question_{$question.id}_text3_{$attribute_id}">{"Default settings"|i18n('survey')}:</label>
    <div class="col-sm-6">
      <select class="form-control border" name="{$prefix_attribute}_ezsurvey_question_{$question.id}_text3_{$attribute_id}" id="{$prefix_attribute}_ezsurvey_question_{$question.id}_text3_{$attribute_id}">
        <option value="" {section show=$question.text3|eq('')} selected="selected"{/section}>{"Default answer"|i18n('survey')}</option>
        {foreach $question.default_answers as $identifier => $default_answer}
        <option value="{$identifier}" {if $question.text3|eq($identifier)} selected="selected"{/if}>{$default_answer}</option>
        {/foreach}
      </select>
    </div>
  </div>

  <div class="form-group mb-3">
    <label class="m-0" for="{$prefix_attribute}_ezsurvey_question_{$question.id}_default_{$attribute_id}">{"Default answer"|i18n('survey')}:</label>
    <input class="form-control border" type="text" name="{$prefix_attribute}_ezsurvey_question_{$question.id}_default_{$attribute_id}" id="{$prefix_attribute}_ezsurvey_question_{$question.id}_default_{$attribute_id}" value="{$question.default_value|wash('xhtml')}" size="70" />
  </div>
</fieldset>