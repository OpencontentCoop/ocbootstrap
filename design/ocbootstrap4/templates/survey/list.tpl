<div class="row">
    <div class="col px-lg-4">
        <h1>{"Survey list"|i18n('survey')}</h1>

        <table class="table">
            <tr>
                <th>{"Title"|i18n('survey')}</th>
                <th class="tight">{"Enabled"|i18n('survey')}</th>
                <th class="tight">{"Persistent"|i18n('survey')}</th>
                <th class="tight">{"Activity"|i18n('survey')}</th>
                <th class="tight">{"Answers"|i18n('survey')}</th>
                <th class="tight">&nbsp;</th>
            </tr>
            {section var=survey loop=$survey_list sequence=array('bglight','bgdark')}
                {let can_view=and( $survey.survey.enabled, $survey.survey.published, $survey.survey.valid )
                contentsurveyobject_id=0
                contentsurveyobject=0}
                {set contentsurveyobject_id=$survey.info.contentobject_id}
                {set contentsurveyobject=fetch('content','object',hash('object_id',$contentsurveyobject_id))}
                    <tr class="{$survey.sequence}">
                        <td class="survey-title">
                            <img src="{$survey.info.contentobjectattribute_language_code|flag_icon}"
                                 alt="{$survey.info.name|wash(xhtml)}"/>&nbsp;
                            {$contentsurveyobject.main_node.name}
                            <a href={concat($contentsurveyobject.main_node.url_alias, '/(language)/', $survey.info.contentobjectattribute_language_code)|ezurl()}>
                                <i class="fa fa-external-link"></i>
                            </a>
                        </td>
                        <td>
                            {switch match=$survey.survey.enabled}
                            {case match=0}{"No"|i18n('survey')}{/case}
                            {case match=1}{"Yes"|i18n('survey')}{/case}
                            {/switch}
                        </td>
                        <td>
                            {switch match=$survey.survey.persistent}
                            {case match=0}{"No"|i18n('survey')}{/case}
                            {case match=1}{"Yes"|i18n('survey')}{/case}
                            {/switch}
                        </td>
                        <td>
                            {switch match=$survey.survey.activity_status}
                            {case match=0}{"Not started"|i18n('survey')}{/case}
                            {case match=1}{"Open"|i18n('survey')}{/case}
                            {case match=2}{"Closed"|i18n('survey')}{/case}
                            {/switch}
                        </td>
                        <td>
                            {let answers=fetch('survey', 'result_count', hash( 'contentobject_id', $survey.survey.contentobject_id,
                            'contentclassattribute_id', $survey.survey.contentclassattribute_id,
                            'language_code', $survey.survey.language_code))}
                            {$answers}
                            {/let}
                        </td>
                        <td>
                            <a class="text-decoration-none" href={concat("/survey/result/", $survey.survey.contentobject_id, '/', $survey.survey.contentclassattribute_id, '/', $survey.survey.language_code)|ezurl()}>
                                <span class="fa-stack">
                                  <i class="fa fa-circle fa-stack-2x"></i>
                                  <i class="fa fa-bar-chart fa-stack-1x fa-inverse"></i>
                                </span>
                            </a>
                            <a class="text-decoration-none" href="{concat('/survey/export/', $survey.survey.contentobject_id, '/', $survey.survey.contentclassattribute_id, '/', $survey.survey.language_code, '/?_=', currentdate())|ezurl(no)}">
                                <span class="fa-stack">
                                  <i class="fa fa-circle fa-stack-2x"></i>
                                  <i class="fa fa-download fa-stack-1x fa-inverse"></i>
                                </span>
                            </a>
                        </td>
                    </tr>
                {/let}
            {/section}
        </table>

        {include name=navigator
                 uri='design:navigator/google.tpl'
                 page_uri='/survey/list'
                 item_count=$count
                 view_parameters=$view_parameters
                 item_limit=$limit}

    </div>
</div>