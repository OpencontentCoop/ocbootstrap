{if and( is_set( $survey_validation ), or( is_set( $survey_validation.error ), is_set( $survey_validation.warning ) ))}
    {if or(count($survey_validation.errors)|gt(0), count($survey_validation.warnings)|gt(0))}
        <div class="alert alert-warning">
            <strong>{"Warning"|i18n( 'survey' )}</strong>
            <ul class="list-unstyled">
                {foreach $survey_validation.errors as $key => $error}
                    <li>
                        <a href="#survey_question_{$error.question_number}">{$error.message}</a>
                    </li>
                {/foreach}
                {foreach $survey_validation.warnings as $key => $warning}
                    <li>
                        <a href="#survey_question_{$warning.question_number}">{$warning.message}</a>
                    </li>
                {/foreach}
            </ul>
        </div>
    {/if}
{/if}
