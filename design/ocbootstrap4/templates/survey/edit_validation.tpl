{section show=and( is_set( $survey_validation ), or( is_set($survey_validation.error), is_set($survey_validation.warning) ))}
    {if or(count($survey_validation.errors),count($survey_validation.warnings))}
        <div class="message-warning bg-white">
            <h2>{"Warning"|i18n( 'survey' )}</h2>
            <ul class="list-unstyled">
                {foreach $survey_validation.errors as $key => $error}
                    <li>
                        <a class="badge badge-danger text-decoration-none"
                           href="#survey_question_{$error.question_id}">{$error.question_id}</a> {$error.message}
                    </li>
                {/foreach}
                {foreach $survey_validation.warnings as $key => $warning}
                    <li>
                        <a class="badge badge-warning text-decoration-none"
                           href="#survey_question_{$warning.question_id}">{$warning.question_id}</a> {$warning}
                    </li>
                {/foreach}
            </ul>
        </div>
    {/if}
{/section}
