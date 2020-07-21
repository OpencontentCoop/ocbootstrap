<div class="row">
    <div class="col px-lg-4">

        <form enctype="multipart/form-data" method="post"
              action={concat("survey/result_edit/", $survey_result.id)|ezurl}>

            <input type="hidden" name="{$prefix_attribute}_ezsurvey_id_{$contentobjectattribute_id}"
                   value="{$survey.id}"/>

            {def $survey_object=fetch('content', 'object', hash('object_id', $contentobject_id))}
            <h2>{"Edit survey results for: %result"|i18n('survey',,hash('%result', $survey_object.name|wash(xhtml)))}</h2>

            {include uri="design:survey/view_validation.tpl"}

            {let question_results=$survey_result.question_results}

            {section var=question loop=$survey.questions}
                <div class="block">
                <input type="hidden" name="{$prefix_attribute}_ezsurvey_question_list_{$contentobjectattribute_id}[]"
                       value="{$question.id}"/>
            {section show=is_set( $question_results[$question.id] )}
                {survey_question_view_gui question=$question question_result=$question_results[$question.id] attribute_id=$contentobjectattribute_id prefix_attribute=$prefix_attribute}
                {section-else}
                    {survey_question_view_gui question=$question attribute_id=$contentobjectattribute_id prefix_attribute=$prefix_attribute}
                {/section}
                <div class="break"></div>
                </div>
            {/section}

            {/let}

            <input class="button" type="submit" name="SurveyStoreButton" value="{'Submit'|i18n( 'survey' )}"/>
            <input class="button" type="submit" name="SurveyCancelButton" value="{'Cancel'|i18n( 'survey' )}"/>
        </form>

    </div>
</div>