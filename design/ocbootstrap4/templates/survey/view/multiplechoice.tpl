<div class="form-group">
    <label>
		{$question.question_number}. {$question.text|wash('xhtml')}
		{switch match=$question.num}{case match=1}<strong class="required">*</strong>{/case}{case match=2}<strong class="required">*</strong>{/case}{case}{/case}{/switch}
	</label>

    {def $attr_id=concat($prefix_attribute,'_ezsurvey_answer_id_',$question.id,'_', $attribute_id)}
    {def $attr_name=concat($prefix_attribute, '_ezsurvey_answer_' , $question.id, '_' , $attribute_id)}
    {def $attr_alternative=concat($prefix_attribute,'_ezsurvey_answer_alternative_',$question.id, '_', $attribute_id)}

    {if is_set($question.multiple_choice_answers.options)}
        {def $options=$question.multiple_choice_answers.options}
    {else}
        {def $options=$question.options}
    {/if}

    {section show=$question_result} {* Show survey persistent view *}
    {if is_set($survey_validation.post_variables.variables[$question.id])}
        {def $previous_vars=$survey_validation.post_variables.variables[$question.id]}
    {/if}

    {switch match=$question.num}

    {case match=1} {* Radio buttons in a row *}
        <div>
            {section var=option loop=$question.options}
				<div class="form-check form-check-inline align-middle">
					<input class="form-check-input" type="radio" id="{$attr_id}_{$option.id}" name="{$attr_name}"
						   value="{$option.value|wash()}"{if is_set($previous_vars.answer)}{if $previous_vars.answer|eq($option.value)} checked="checked"{/if}{else}{if is_set( $question_result.content[$option.value] )} checked="checked"{/if}{/if}
						   onclick="synchFormElements( '{$attr_id}_{$option.id}', '{$attr_alternative}', false );">
					<label class="form-check-label" for="{$attr_id}_{$option.id}">{$option.label}</label>
				</div>
            {/section}
			{if $question.extra_info.enabled|eq(1)}
				<div class="form-check form-check-inline align-middle">
					<input class="form-check-input" id="{$attr_id}" name="{$attr_name}" type="radio"
						   value="{$question.extra_info.value|wash()}"{if is_set($previous_vars.answer)}{if $previous_vars.answer|eq($question.extra_info.value)} checked="checked"{/if}{else}{if is_set( $question_result.content[$question.extra_info.value])} checked="checked"{/if}{/if}
						   onclick="synchFormElements( '{$attr_id}', '{$attr_alternative}', true );"/>
					<label class="form-check-label text-nowrap" for="{$attr_id}">
						{$question.extra_info.label|wash(xhtml)}
						{if $question.extra_info.row|eq(1)}
							<input id="{$attr_alternative}" type="text"
								   name="{$prefix_attribute}_ezsurvey_answer_{$question.id}_extra_info_{$attribute_id}"
								   value="{if is_set($previous_vars.extra_answer)}{$previous_vars.extra_answer|wash()}{else}{$question_result.extra_info.value|wash()}{/if}"{if $question.extra_info.enable_css_style|eq(1)} class="form-control d-inline-block"{/if} />
						{else}
							<textarea id="{$attr_alternative}" type="text"
									  name="{$prefix_attribute}_ezsurvey_answer_{$question.id}_extra_info_{$attribute_id}"
									  rows="{$question.extra_info.row}" cols="{$question.extra_info.column}"{if $question.extra_info.enable_css_style|eq(1)} class="box"{/if}/>{if is_set($previous_vars.extra_answer)}{$previous_vars.extra_answer|wash()}{else}{$question_result.extra_info.value|wash()}{/if}</textarea>
						{/if}
					</label>
				</div>
			{/if}
        </div>
    {/case}

    {case match=2} {* Radio buttons in a column *}
		{section var=option loop=$question.options}
		<div class="form-check">
			<input class="form-check-input" type="radio" id="{$attr_id}_{$option.id}" name="{$attr_name}"
				   value="{$option.value|wash()}"{if is_set($previous_vars.answer)}{if $previous_vars.answer|eq($option.value)} checked="checked"{/if}{else}{if is_set( $question_result.content[$option.value] )} checked="checked"{/if}{/if}
				   onclick="synchFormElements( '{$attr_id}_{$option.id}', '{$attr_alternative}', false );">
			<label class="form-check-label" for="{$attr_id}_{$option.id}">{$option.label}</label>
		</div>
		{/section}
		{if $question.extra_info.enabled|eq(1)}
		<div class="form-check">
			<input class="form-check-input" id="{$attr_id}" name="{$attr_name}" type="radio"
				   value="{$question.extra_info.value|wash()}"{if is_set($previous_vars.answer)}{if $previous_vars.answer|eq($question.extra_info.value)} checked="checked"{/if}{else}{if is_set( $question_result.content[$question.extra_info.value])} checked="checked"{/if}{/if}
				   onclick="synchFormElements( '{$attr_id}', '{$attr_alternative}', true );"/>
			<label class="form-check-label text-nowrap" for="{$attr_id}">
				{$question.extra_info.label|wash(xhtml)}
				{if $question.extra_info.row|eq(1)}
				<input id="{$attr_alternative}" type="text"
					   name="{$prefix_attribute}_ezsurvey_answer_{$question.id}_extra_info_{$attribute_id}"
					   value="{if is_set($previous_vars.extra_answer)}{$previous_vars.extra_answer|wash()}{else}{$question_result.extra_info.value|wash()}{/if}"{if $question.extra_info.enable_css_style|eq(1)} class="form-control d-inline-block"{/if} />
				{else}
				<textarea id="{$attr_alternative}" type="text"
						  name="{$prefix_attribute}_ezsurvey_answer_{$question.id}_extra_info_{$attribute_id}"
						  rows="{$question.extra_info.row}" cols="{$question.extra_info.column}"{if $question.extra_info.enable_css_style|eq(1)} class="box"{/if}/>{if is_set($previous_vars.extra_answer)}{$previous_vars.extra_answer|wash()}{else}{$question_result.extra_info.value|wash()}{/if}</textarea>
				{/if}
			</label>
		</div>
		{/if}
    {/case}

    {case match=3} {* check box in a row *}
		<div>
			{section var=option loop=$options}
				<div class="form-check form-check-inline align-middle">
					<input class="form-check-input" type="checkbox" name="{$attr_name}[]" id="{$attr_id}-_{$option.id}"
						   value="{$option.value|wash()}"{if is_set($previous_vars.answer)}{if is_set($previous_vars.answer[$option.value])} checked="checked"{/if}{else}{if is_set( $question_result.content[$option.value] )} checked="checked"{/if}{/if} />
					<label class="form-check-label" for="{$attr_id}-_{$option.id}">{$option.label}</label>
				</div>
			{/section}
			{if $question.extra_info.enabled|eq(1)}
				<div class="form-check form-check-inline align-middle">
					<input id="{$attr_id}" name="{$attr_name}[]" type="checkbox" class="form-check-input"
						   value="{$question.extra_info.value|wash()}"{if is_set($previous_vars.answer)}{if is_set($previous_vars.answer[$question.extra_info.value])} checked="checked"{/if}{else}{if is_set( $question_result.content[$question.extra_info.value])} checked="checked"{/if}{/if}
						   onclick="synchFormElements( '{$attr_id}', '{$attr_alternative}', true );"/>
					<label class="form-check-label text-nowrap" for="{$attr_id}">
						{$question.extra_info.label|wash(xhtml)}
						{if $question.extra_info.row|eq(1)}
							<input id="{$attr_alternative}" type="text"
								   name="{$prefix_attribute}_ezsurvey_answer_{$question.id}_extra_info_{$attribute_id}"
								   value="{if is_set($previous_vars.extra_answer)}{$previous_vars.extra_answer|wash()}{else}{$question_result.extra_info.value|wash()}{/if}"{if $question.extra_info.enable_css_style|eq(1)} class="form-control"{/if} />
						{else}
							<textarea id="{$attr_alternative}" type="text"
									  name="{$prefix_attribute}_ezsurvey_answer_{$question.id}_extra_info_{$attribute_id}"
									  rows="{$question.extra_info.row}" cols="{$question.extra_info.column}"{if $question.extra_info.enable_css_style|eq(1)} class="form-control"{/if}/>{if is_set($previous_vars.extra_answer)}{$previous_vars.extra_answer|wash()}{else}{$question_result.extra_info.value|wash()}{/if}</textarea>
						{/if}
					</label>
				</div>
			{/if}
		</div>
    {/case}

    {case match=4} {* check box in a column *}
		{section var=option loop=$options}
			<div class="form-check">
				<input class="form-check-input" type="checkbox" name="{$attr_name}[]" id="{$attr_id}-_{$option.id}"
					   value="{$option.value|wash()}"{if is_set($previous_vars.answer)}{if is_set($previous_vars.answer[$option.value])} checked="checked"{/if}{else}{if is_set( $question_result.content[$option.value] )} checked="checked"{/if}{/if} />
				<label class="form-check-label" for="{$attr_id}-_{$option.id}">{$option.label}</label>
			</div>
		{/section}
		{if $question.extra_info.enabled|eq(1)}
			<div class="form-check">
				<input id="{$attr_id}" name="{$attr_name}[]" type="checkbox" class="form-check-input"
					   value="{$question.extra_info.value|wash()}"{if is_set($previous_vars.answer)}{if is_set($previous_vars.answer[$question.extra_info.value])} checked="checked"{/if}{else}{if is_set( $question_result.content[$question.extra_info.value])} checked="checked"{/if}{/if}
					   onclick="synchFormElements( '{$attr_id}', '{$attr_alternative}', true );"/>
				<label class="form-check-label text-nowrap" for="{$attr_id}">
					{$question.extra_info.label|wash(xhtml)}
					{if $question.extra_info.row|eq(1)}
						<input id="{$attr_alternative}" type="text"
							   name="{$prefix_attribute}_ezsurvey_answer_{$question.id}_extra_info_{$attribute_id}"
							   value="{if is_set($previous_vars.extra_answer)}{$previous_vars.extra_answer|wash()}{else}{$question_result.extra_info.value|wash()}{/if}"{if $question.extra_info.enable_css_style|eq(1)} class="form-control"{/if} />
					{else}
						<textarea id="{$attr_alternative}" type="text"
								  name="{$prefix_attribute}_ezsurvey_answer_{$question.id}_extra_info_{$attribute_id}"
								  rows="{$question.extra_info.row}" cols="{$question.extra_info.column}"{if $question.extra_info.enable_css_style|eq(1)} class="form-control"{/if}/>{if is_set($previous_vars.extra_answer)}{$previous_vars.extra_answer|wash()}{else}{$question_result.extra_info.value|wash()}{/if}</textarea>
					{/if}
				</label>
			</div>
		{/if}
    {/case}

    {case match=5} {* select box *}
		<select class="form-control" name="{$attr_name}"
				onclick="synchFormElements( '{$attr_id}', '{$attr_alternative}', true );">
			{section var=option loop=$question.options}
				<option value="{$option.value|wash()}"{if is_set($previous_vars.answer)}{if $previous_vars.answer|eq($option.value)} selected="selected"{/if}{else}{if is_set( $question_result.content[$option.value] )} selected="selected"{/if}{/if}>{$option.label}</option>
			{/section}
			{if $question.extra_info.enabled|eq(1)}
				<option id="{$attr_id}"
						value="{$question.extra_info.value|wash(xhtml)}"{if is_set($previous_vars.answer)}{if $previous_vars.answer|eq($question.extra_info.value)} selected="selected"{/if}{else}{if is_set( $question_result.content[$question.extra_info.value] )} selected="selected"{/if}{/if}>{$question.extra_info.label|wash(xhtml)}</option>
			{/if}
		</select>
		{if $question.extra_info.row|eq(1)}
			<input class="form-control" id="{$attr_alternative}" type="text"
				   name="{$prefix_attribute}_ezsurvey_answer_{$question.id}_extra_info_{$attribute_id}"
				   value="{if is_set($previous_vars.extra_answer)}{$previous_vars.extra_answer|wash()}{else}{$question_result.extra_info.value|wash()}{/if}"{if $question.extra_info.enable_css_style|eq(1)} class="form-control"{/if} />
		{else}
			<textarea class="form-control" id="{$attr_alternative}" type="text"
					  name="{$prefix_attribute}_ezsurvey_answer_{$question.id}_extra_info_{$attribute_id}"
					  rows="{$question.extra_info.row}" cols="{$question.extra_info.column}"{if $question.extra_info.enable_css_style|eq(1)} class="form-control"{/if}/>{if is_set($previous_vars.extra_answer)}{$previous_vars.extra_answer|wash()}{else}{$question_result.extra_info.value|wash()}{/if}</textarea>
		{/if}
	{/case}

	{case}{/case}
	{/switch}

{if $question.extra_info.enabled|eq(1)} {* Extra info block*}

{/if}

{section-else}

    {switch match=$question.num}

    {case match=1} {* Radio buttons in a row *}
        <div>
            {section var=option loop=$options}
				<div class="form-check form-check-inline align-middle">
					<input class="form-check-input" type="radio" id="{$attr_id}_{$option.id}" name="{$attr_name}"
						   value="{$option.value|wash()}"{section show=$option.toggled|eq(1)} checked="checked"{/section}
						   onclick="synchFormElements( '{$attr_id}_{$option.id}', '{$attr_alternative}', false );">
					<label class="form-check-label" for="{$attr_id}_{$option.id}">{$option.label}</label>
				</div>
            {/section}
            {if $question.extra_info.enabled|eq(1)}
				<div class="form-check form-check-inline align-middle">
                    <input class="form-check-input" id="{$attr_id}" name="{$attr_name}" type="radio"
                           value="{$question.extra_info.value|wash(xhtml)}"{section show=$question.extra_info.value_checked|eq(1)} checked="checked"{/section}
                           onclick="synchFormElements( '{$attr_id}', '{$attr_alternative}', true );"/>
					<label class="form-check-label text-nowrap" for="{$attr_id}">
						{$question.extra_info.label|wash(xhtml)}
						{if $question.extra_info.row|eq(1)}
							<input id="{$attr_alternative}" type="text"
								   name="{$prefix_attribute}_ezsurvey_answer_{$question.id}_extra_info_{$attribute_id}"
								   value="{if is_set($question.extra_info.extra_answer)}{$question.extra_info.extra_answer|wash()}{else}{$question.extra_info.default_value|wash()}{/if}"{if $question.extra_info.enable_css_style|eq(1)} class="form-control d-inline-block"{/if} />
						{else}
							<textarea id="{$attr_alternative}" type="text"
									  name="{$prefix_attribute}_ezsurvey_answer_{$question.id}_extra_info_{$attribute_id}"
									  rows="{$question.extra_info.row}" cols="{$question.extra_info.column}"{if $question.extra_info.enable_css_style|eq(1)} class="form-control"{/if}/>{if is_set($question.extra_info.extra_answer)}{$question.extra_info.extra_answer|wash()}{else}{$question.extra_info.default_value|wash()}{/if}</textarea>
						{/if}
					</label>
				</div>
            {/if}
        </div>
    {/case}

    {case match=2} {* Radio buttons in a column *}
		{section var=option loop=$options}
			<div class="form-check">
				<input class="form-check-input" type="radio" name="{$attr_name}" id="{$attr_id}_{$option.id}"
					   value="{$option.value|wash()}"{section show=$option.toggled|eq(1)} checked="checked"{/section}
					   onclick="synchFormElements( '{$attr_id}_{$option.id}', '{$attr_alternative}', false );">
				<label class="form-check-label" for="{$attr_id}_{$option.id}">
					{$option.label}
				</label>
			</div>
		{/section}
		{if $question.extra_info.enabled|eq(1)}
			<div class="form-check">

				<input class="form-check-input" id="{$attr_id}" name="{$attr_name}" type="radio"
					   value="{$question.extra_info.value|wash(xhtml)}"{section show=$question.extra_info.value_checked|eq(1)} checked="checked"{/section}
					   onclick="synchFormElements( '{$attr_id}', '{$attr_alternative}', true );"/>
				<label class="form-check-label text-nowrap" for="{$attr_id}">
					{$question.extra_info.label|wash(xhtml)}
					{if $question.extra_info.row|eq(1)}
						<input id="{$attr_alternative}" type="text"
							   name="{$prefix_attribute}_ezsurvey_answer_{$question.id}_extra_info_{$attribute_id}"
							   value="{if is_set($question.extra_info.extra_answer)}{$question.extra_info.extra_answer|wash()}{else}{$question.extra_info.default_value|wash()}{/if}"{if $question.extra_info.enable_css_style|eq(1)} class="form-control d-inline-block"{/if} />
					{else}
						<textarea id="{$attr_alternative}" type="text"
								  name="{$prefix_attribute}_ezsurvey_answer_{$question.id}_extra_info_{$attribute_id}"
								  rows="{$question.extra_info.row}" cols="{$question.extra_info.column}"{if $question.extra_info.enable_css_style|eq(1)} class="form-control"{/if}/>{if is_set($question.extra_info.extra_answer)}{$question.extra_info.extra_answer|wash()}{else}{$question.extra_info.default_value|wash()}{/if}</textarea>
					{/if}
				</label>
			</div>
		{/if}
    {/case}

    {case match=3} {* Checkbox in a row *}
        <div>
            {section var=option loop=$options}
				<div class="form-check form-check-inline align-middle">
					<input class="form-check-input" type="checkbox" name="{$attr_name}[]" id="{$attr_id}-_{$option.id}" value="{$option.value|wash()}"{section show=$option.toggled|eq(1)} checked="checked"{/section}>
					<label class="form-check-label" for="{$attr_id}-_{$option.id}">{$option.label}</label>
				</div>
            {/section}
            {if $question.extra_info.enabled|eq(1)}
				<div class="form-check form-check-inline align-middle">
                    <input id="{$attr_id}" name="{$attr_name}[]" type="checkbox" class="form-check-input"
                           value="{$question.extra_info.value|wash(xhtml)}"{section show=$question.extra_info.value_checked|eq(1)} checked="checked"{/section}
                           onclick="synchFormElements( '{$attr_id}', '{$attr_alternative}', true );"/>
					<label class="form-check-label text-nowrap" for="{$attr_id}">
						{$question.extra_info.label|wash(xhtml)}
						{if $question.extra_info.row|eq(1)}
							<input id="{$attr_alternative}" type="text"
								   name="{$prefix_attribute}_ezsurvey_answer_{$question.id}_extra_info_{$attribute_id}"
								   value="{if is_set($question.extra_info.extra_answer)}{$question.extra_info.extra_answer|wash()}{else}{$question.extra_info.default_value|wash()}{/if}"{if $question.extra_info.enable_css_style|eq(1)} class="form-control d-inline-block"{/if} />
						{else}
							<textarea id="{$attr_alternative}" type="text"
									  name="{$prefix_attribute}_ezsurvey_answer_{$question.id}_extra_info_{$attribute_id}"
									  rows="{$question.extra_info.row}" cols="{$question.extra_info.column}"{if $question.extra_info.enable_css_style|eq(1)} class="form-control"{/if}/>{if is_set($question.extra_info.extra_answer)}{$question.extra_info.extra_answer|wash()}{else}{$question.extra_info.default_value|wash()}{/if}</textarea>
						{/if}
					</label>
				</div>
            {/if}
        </div>
    {/case}

    {case match=4} {* Checkbox in a column *}
		{section var=option loop=$options}
			<div class="form-check">
				<input class="form-check-input" type="checkbox" name="{$attr_name}[]" id="{$attr_id}-_{$option.id}" value="{$option.value|wash()}"{section show=$option.toggled|eq(1)} checked="checked"{/section}>
				<label class="form-check-label" for="{$attr_id}-_{$option.id}">{$option.label}</label>
			</div>
		{/section}
		{if $question.extra_info.enabled|eq(1)}
			<div class="form-check">
				<input id="{$attr_id}" name="{$attr_name}[]" type="checkbox" class="form-check-input"
					   value="{$question.extra_info.value|wash(xhtml)}"{section show=$question.extra_info.value_checked|eq(1)} checked="checked"{/section}
					   onclick="synchFormElements( '{$attr_id}', '{$attr_alternative}', true );"/>
				<label class="form-check-label text-nowrap" for="{$attr_id}">
					{$question.extra_info.label|wash(xhtml)}
					{if $question.extra_info.row|eq(1)}
						<input id="{$attr_alternative}" type="text"
							   name="{$prefix_attribute}_ezsurvey_answer_{$question.id}_extra_info_{$attribute_id}"
							   value="{if is_set($question.extra_info.extra_answer)}{$question.extra_info.extra_answer|wash()}{else}{$question.extra_info.default_value|wash()}{/if}"{if $question.extra_info.enable_css_style|eq(1)} class="form-control d-inline-block"{/if} />
					{else}
						<textarea id="{$attr_alternative}" type="text"
								  name="{$prefix_attribute}_ezsurvey_answer_{$question.id}_extra_info_{$attribute_id}"
								  rows="{$question.extra_info.row}" cols="{$question.extra_info.column}"{if $question.extra_info.enable_css_style|eq(1)} class="form-control"{/if}/>{if is_set($question.extra_info.extra_answer)}{$question.extra_info.extra_answer|wash()}{else}{$question.extra_info.default_value|wash()}{/if}</textarea>
					{/if}
				</label>
			</div>
		{/if}
    {/case}

    {case match=5} {* Select box *}
        <select class="form-control" name="{$attr_name}"
                onclick="synchFormElements( '{$attr_id}', '{$attr_alternative}', true );">
            {section var=option loop=$options}
                <option value="{$option.value|wash()}"{section show=$option.toggled|eq(1)} selected="selected"{/section}>{$option.label}</option>
            {/section}
            {if $question.extra_info.enabled|eq(1)}
                <option id="{$attr_id}"
                        value="{$question.extra_info.value|wash(xhtml)}"{section show=$question.extra_info.value_checked|eq(1)} selected="selected"{/section}>{$question.extra_info.label|wash(xhtml)}</option>
            {/if}
        </select>
		{if $question.extra_info.row|eq(1)}
			<input class="form-control" id="{$attr_alternative}" type="text"
				   name="{$prefix_attribute}_ezsurvey_answer_{$question.id}_extra_info_{$attribute_id}"
				   value="{if is_set($question.extra_info.extra_answer)}{$question.extra_info.extra_answer|wash()}{else}{$question.extra_info.default_value|wash()}{/if}"{if $question.extra_info.enable_css_style|eq(1)} class="form-control"{/if} />
		{else}
			<textarea class="form-control" id="{$attr_alternative}" type="text"
					  name="{$prefix_attribute}_ezsurvey_answer_{$question.id}_extra_info_{$attribute_id}"
					  rows="{$question.extra_info.row}" cols="{$question.extra_info.column}"{if $question.extra_info.enable_css_style|eq(1)} class="form-control"{/if}/>{if is_set($question.extra_info.extra_answer)}{$question.extra_info.extra_answer|wash()}{else}{$question.extra_info.default_value|wash()}{/if}</textarea>
		{/if}
    {/case}

    {case}{/case}
    {/switch}

{/section}


<script type="text/javascript">
    <!--
    {literal}
    function synchFormElements() {
        var synchElement = document.getElementById(synchFormElements.arguments[0]);
        if (synchElement != undefined && synchElement != null) {
            var tag = synchElement.tagName.toLowerCase();
            var synchPolarity = synchFormElements.arguments[arguments.length - 1];
            var inputArray = new Array();

            for (var x = 0; x < (synchFormElements.arguments.length - 2); x++) {
                inputArray[x] = synchFormElements.arguments[x + 1];
            }

            if ((tag == 'input' && ((synchElement.checked && synchPolarity) || (!synchElement.checked && !synchPolarity))) || (tag == 'option' && ((synchElement.selected && synchPolarity) || (!synchElement.selected && !synchPolarity)))) {
                setFormElements(inputArray, true);
            } else {
                setFormElements(inputArray, false);
            }
        }
    }

    function setFormElements(inputArray, enabled) {
        var modeString = '';

        if (!enabled) {
            modeString = 'disabled';
        }

        for (var x = 0; x < inputArray.length; x++) {
            var inputElement = document.getElementById(inputArray[x]);
            if (inputElement != undefined && inputElement != null) {
                inputElement.disabled = modeString;
                if (modeString == 'disabled') {
                    setClass(inputElement, 'disabled');
                } else {
                    removeClass(inputElement, 'disabled');
                }
            }
        }
    }

    function readClassArray(element) {
        if (typeof (element) == 'string') {
            element = document.getElementById(element);
        }

        var classString = element.className;
        var classArray = classString.split(' ');
        return classArray;
    }

    function writeClassArray(element, classArray) {
        if (typeof (element) == 'string') {
            element = document.getElementById(element);
        }

        var classString = classArray.join(' ');
        element.className = classString;
    }

    function setClass(element, className) {
        if (!checkClass(element, className)) {
            var classArray = readClassArray(element);
            classArray[classArray.length] = className;
            writeClassArray(element, classArray);
        }
    }

    function checkClass(element, className) {
        var classArray = readClassArray(element);

        for (x = 0; x < classArray.length; x++) {
            if (classArray[x] == className) {
                return true;
            }
        }

        return false;
    }

    function removeClass(element, className) {
        var classArray = readClassArray(element);

        for (x = 0; x < classArray.length; x++) {
            if (classArray[x] == className) {
                classArray[x] = '';
            }
        }

        writeClassArray(element, classArray);
    }
    {/literal}

    synchFormElements('{$attr_id}', '{$attr_alternative}', true);
    // -->
</script>
</div>