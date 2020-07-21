<div class="form-group">
    <input type="hidden" name="{$prefix_attribute}_ezsurvey_receiver_id_{$attribute_id}" value="{$question.id}"/>
    {section show=$question.options|count|gt(1)}
        <label for="{$prefix_attribute}_ezsurvey_answer_{$question.id}_{$attribute_id}">
			{$question.question_number}. {$question.text|wash('xhtml')}
			{section show=$question.mandatory}<strong class="required">*</strong>{/section}
		</label>
        <select class="form-control" id="{$prefix_attribute}_ezsurvey_answer_{$question.id}_{$attribute_id}" name="{$prefix_attribute}_ezsurvey_answer_{$question.id}_{$attribute_id}">
            {section var=option loop=$question.options}
                <option value="{$option.id}"{section show=$option.toggled|eq(1)} selected="selected"{/section}>{$option.label}</option>
            {/section}
        </select>
    {/section}
</div>