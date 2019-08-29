<div class="mt-2">

    <p>
        <strong>{"Created"|i18n("design/standard/content/edit")}:</strong>
        {section show=$object.published}
            {$object.published|l10n(date)}
        {section-else}
            {"Not yet published"|i18n("design/standard/content/edit")}
        {/section}
    </p>
    <p>
        <strong>{"Last Modified"|i18n("design/standard/content/edit")}:</strong>
        {section show=$object.modified}
            {$object.modified|l10n(date)}
        {section-else}
            {"Not yet published"|i18n("design/standard/content/edit")}
        {/section}
    </p>

    <div class="card card-info mb-3">
        <div class="card-header">{"Sezioni"|i18n("design/standard/content/edit")}</div>
        <div class="card-body">
            {include uri='design:content/parts/edit_sections.tpl'}
        </div>
    </div>

    <div class="card card-info mb-3">
        <div class="card-header">{"States"|i18n("design/standard/content/edit")}</div>
        <div class="card-body">
            {include uri='design:content/parts/edit_states.tpl'}
        </div>
    </div>

    <div class="card card-info mb-3">
        <div class="card-header">{"Versions"|i18n("design/standard/content/edit")}</div>
        <table class="table">
        <tr>
            <td class="menu">
                <strong>{"Editing"|i18n("design/standard/content/edit")}</strong>
            </td>
            <td class="menu" width="1">
            {$edit_version}
            </td>
        </tr>
        <tr>
            <td class="menu">
                <strong>{"Current"|i18n("design/standard/content/edit")}</strong>
            </td>
            <td class="menu" width="1">
            {$object.current_version}
            </td>
        </tr>
        <tr>
            <td class="menu" colspan="2" align="right">
              <input class="btn btn-sm btn-info" type="submit" name="VersionsButton" value="{'Manage'|i18n('design/standard/content/edit')}" />
            </td>
        </tr>
        </table>
    </div>

    <div class="card card-info mb-3">
        <div class="card-header">{"Translations"|i18n("design/standard/content/edit")}</div>
        <table class="table">
        <tr>
            <td>
                <strong>{'No translation'|i18n( 'design/standard/content/edit' )}</strong>
            </td>
            <td>
                <input type="radio" name="FromLanguage" value=""{if $from_language|not} checked="checked"{/if}{if $object.status|eq(0)} disabled="disabled"{/if} />
            </td>
        </tr>
        {if $object.status}
            {foreach $object.languages as $language}
            <tr>
                <td>
                    <strong>{$language.name|wash}</strong>
                </td>
                <td>
                    <input type="radio" name="FromLanguage" value="{$language.locale}"{if $language.locale|eq($from_language)} checked="checked"{/if} />
                </td>
            </tr>
            {/foreach}
        {/if}

        <tr>
            <td colspan="2" align="right">
                <input class="btn btn-sm btn-info" type="submit" name="FromLanguageButton" value="{'Translate'|i18n( 'design/standard/content/edit' )}" />
            </td>
        </tr>
        </table>
    </div>
</div>