<div class="row">
    <div class="col px-lg-4">

        {def $survey_object=fetch('content', 'object', hash('object_id', $contentobject_id))}
        <h2>
            <a class="text-decoration-none" href={$survey_object.main_node.url_alias|ezurl()}>{$survey_object.name|wash(xhtml)}</a> {"has %count answers."|i18n('survey',,hash('%count', $count))}
        </h2>

        <ul class="nav nav-tabs">
            <li class="nav-item"><a class="nav-link active" href={concat('/survey/result/', $contentobject_id, '/', $contentclassattribute_id, '/', $language_code)|ezurl}>{"Summary"|i18n('survey')}</a></li>
            <li class="nav-item"><a class="nav-link" href={concat('/survey/result_list/', $contentobject_id, '/', $contentclassattribute_id, '/', $language_code)|ezurl}>{"All evaluations"|i18n('survey')}</a></li>
            <li class="nav-item"><a class="nav-link" href={concat('/survey/export/', $contentobject_id, '/', $contentclassattribute_id, '/', $language_code, '/?_=', currentdate())|ezurl}>{"Download CSV"|i18n('survey')}</a></li>
        </ul>

        <div class="tab-content p-3">
            {section show=$count|gt(0)}

                {section var=question loop=$survey_questions}
                    <div class="block">
                        {survey_question_result_gui view=overview
                        question=$question
                        metadata=$survey_metadata
                        contentobject_id=$contentobject_id
                        contentclassattribute_id=$contentclassattribute_id
                        language_code=$language_code}
                    </div>
                {/section}

            {section-else}
                <p class="lead">{"No results yet."|i18n('survey')}</p>
            {/section}
        </div>

    </div>
</div>
<style>label {ldelim}font-size: 1.3em;{rdelim}</style>