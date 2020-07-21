{if $question.num2|eq(0)}
    <div class="form-group">
        <label for="{$prefix_attribute}_ezsurvey_answer_{$question.id}_{$attribute_id}">
			{$question.question_number}. {$question.text|wash('xhtml')}
			{section show=$question.mandatory}<strong class="required">*</strong>{/section}
		</label>

        <div class="survey-choices">
            {section show=$question_result}
            <input class="form-control" id="{$prefix_attribute}_ezsurvey_answer_{$question.id}_{$attribute_id}" name="{$prefix_attribute}_ezsurvey_answer_{$question.id}_{$attribute_id}" name="{$prefix_attribute}_ezsurvey_answer_{$question.id}_{$attribute_id}"
                   type="text" size="20" value="{$question_result.text|wash('xhtml')}"/>
            {section-else}
                <input class="form-control" id="{$prefix_attribute}_ezsurvey_answer_{$question.id}_{$attribute_id}" name="{$prefix_attribute}_ezsurvey_answer_{$question.id}_{$attribute_id}"
                       type="text" size="20" value="{$question.answer|wash('xhtml')}"/>
            {/section}
        </div>
    </div>
{else}
    <input name="{$prefix_attribute}_ezsurvey_answer_{$question.id}_{$attribute_id}" type="hidden"
           value="{if $question_result}{$question_result.text|wash('xhtml')}{else}{$question.answer|wash('xhtml')}{/if}"/>
{/if}