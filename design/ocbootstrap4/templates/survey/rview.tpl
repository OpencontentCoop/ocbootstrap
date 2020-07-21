<div class="row">
    <div class="col px-lg-4">

        {def $survey_object=fetch('content', 'object', hash('object_id', $contentobject_id))}
        <h2>
            <a class="text-decoration-none" href={$survey_object.main_node.url_alias|ezurl()}>{$survey_object.name|wash(xhtml)}</a> {"has %count answers."|i18n('survey',,hash('%count', $count))}
        </h2>

        <ul class="nav nav-tabs">
            <li class="nav-item"><a class="nav-link" href={concat('/survey/result/', $contentobject_id, '/', $contentclassattribute_id, '/', $language_code)|ezurl}>{"Summary"|i18n('survey')}</a></li>
            <li class="nav-item"><a class="nav-link" href={concat('/survey/result_list/', $contentobject_id, '/', $contentclassattribute_id, '/', $language_code)|ezurl}>{"All evaluations"|i18n('survey')}</a></li>
            <li class="nav-item"><a class="nav-link" href={concat('/survey/export/', $contentobject_id, '/', $contentclassattribute_id, '/', $language_code, '/?_=', currentdate())|ezurl}>{"Download CSV"|i18n('survey')}</a></li>
        </ul>

        <div class="tab-content p-3">

            <p>
                {def $user=fetch( 'content', 'object', hash( 'object_id', $survey_user_id ))}
                {def $result=fetch('survey','survey_result',hash('result_id',$result_id))}
                <span class="badge badge-info text-white"><strong>{"Participiant:"|i18n('survey')}</strong> {$user.name}</span>
                <span class="badge badge-info text-white"><strong>{"Evaluated:"|i18n('survey')}</strong> {$result.tstamp|l10n(datetime)}</span>
            </p>

            {section var=question loop=$survey_questions}
            <div class="block">
            {survey_question_result_gui view=item
                                        question=$question
                                        result_id=$result_id
                                        metadata=$survey_metadata}
            </div>
            {/section}


            {include name=navigator
                     uri='design:navigator/google.tpl'
                     page_uri=concat('/survey/rview/', $contentobject_id, '/', $contentclassattribute_id, '/', $language_code)
                     item_count=$count
                     view_parameters=$view_parameters
                     item_limit=$limit}

            <p><a class="button" href="{concat('/survey/result_edit/', $result_id)|ezurl(no)}">Edit</a></p>
        </div>

    </div>
</div>
<style>label {ldelim}font-size: 1.3em;display: block;margin-top: 15px{rdelim}</style>