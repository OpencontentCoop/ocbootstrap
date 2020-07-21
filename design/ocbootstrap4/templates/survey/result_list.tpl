<div class="row">
    <div class="col px-lg-4">

        {def $survey_object=fetch('content', 'object', hash('object_id', $contentobject_id))}
        <h2>
            <a class="text-decoration-none" href={$survey_object.main_node.url_alias|ezurl()}>{$survey_object.name|wash(xhtml)}</a> {"has %count answers."|i18n('survey',,hash('%count', $count))}
        </h2>

        <ul class="nav nav-tabs">
            <li class="nav-item"><a class="nav-link" href={concat('/survey/result/', $contentobject_id, '/', $contentclassattribute_id, '/', $language_code)|ezurl}>{"Summary"|i18n('survey')}</a></li>
            <li class="nav-item"><a class="nav-link active" href={concat('/survey/result_list/', $contentobject_id, '/', $contentclassattribute_id, '/', $language_code)|ezurl}>{"All evaluations"|i18n('survey')}</a></li>
            <li class="nav-item"><a class="nav-link" href={concat('/survey/export/', $contentobject_id, '/', $contentclassattribute_id, '/', $language_code, '/?_=', currentdate())|ezurl}>{"Download CSV"|i18n('survey')}</a></li>
        </ul>

        <div class="tab-content p-3">
            {if count($result_list)}
            <form enctype="multipart/form-data" method="post"
                  action={concat("/survey/result_list/", $contentobject_id, '/', $contentclassattribute_id, '/', $language_code)|ezurl}>
                <table class="table">
                    <tr>
                        <th class="tight">&nbsp;</th>
                        <th>{"Participant"|i18n('survey')}</th>
                        <th>{"Evaluated"|i18n('survey')}</th>
                        <th width="1">&nbsp;</th>
                        <th width="1">&nbsp;</th>
                    </tr>
                    {def $showRemoveButton=false()}
                    {foreach $result_list as $index => $result_item sequence array('bglight','bgdark') as $style}
                        {let can_edit_results=$survey.can_edit_results}
                            <tr class="{$style}">
                                <td>
                                    {if $can_edit_results}
                                        <input type="checkbox" name="DeleteIDArray[]" value="{$result_item.id}"/>
                                        {set $showRemoveButton=true()}
                                    {else}
                                        &nbsp;
                                    {/if}
                                </td>
                                {let user=fetch( content, object, hash( object_id, $result_item.user_id ) )}
                                    <td><a href={$user.main_node.url_alias|ezurl}>{$user.name|wash}</a></td>
                                {/let}
                                <td class="survey-date">{$result_item.tstamp|l10n(datetime)}</td>
                                <td>
                                    {section show=$can_edit_results}
                                        <a href={concat( "/survey/result_edit/", $result_item.id )|ezurl}>
                                            <span class="fa-stack">
                                              <i class="fa fa-circle fa-stack-2x"></i>
                                              <i class="fa fa-pencil fa-stack-1x fa-inverse"></i>
                                            </span>
                                        </a>
                                    {/section}
                                </td>
                                <td>
                                    <a href={concat( "/survey/rview/", , $contentobject_id, '/', $contentclassattribute_id, '/', $language_code, '/', $result_item.id, '/(offset)/', sum($view_parameters.offset, $index) )|ezurl}>
                                        <span class="fa-stack">
                                          <i class="fa fa-circle fa-stack-2x"></i>
                                          <i class="fa fa-list fa-stack-1x fa-inverse"></i>
                                        </span>
                                    </a>
                                </td>
                            </tr>
                        {/let}
                    {/foreach}
                </table>
                {include name=navigator
                         uri='design:navigator/google.tpl'
                         page_uri=concat('/survey/result_list/', $contentobject_id, '/', $contentclassattribute_id, '/', $language_code )
                         item_count=$count
                         view_parameters=$view_parameters
                         item_limit=$limit}
                {if $showRemoveButton|eq(true())}<input class="button" type="submit" name="RemoveButton" value="Remove"/>{/if}
            </form>
            {/if}
        </div>

    </div>
</div>
