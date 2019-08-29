<div class="alert alert-warning">
    <h2>{"View not found"|i18n("design/standard/error/kernel")}</h2>
    <p>{"The requested view %view could not be found in module %module"|i18n("design/standard/error/kernel",,
        hash('%view',$parameters.view|wash,
        '%module',$parameters.module|wash))}</p>
    <p>{"Possible reasons for this are"|i18n("design/standard/error/kernel")}:</p>
    <ul>
        <li>{"The view name was misspelled, try changing the URL."|i18n("design/standard/error/kernel")}</li>
        <li>{"The view does not exist for the module %module."|i18n("design/standard/error/kernel",,
            hash('%module',$parameters.module|wash))}</li>
        <li>{"This site uses siteaccess matching in the URL and you did not supply one, try inserting a siteaccess name before the module in the URL ."|i18n("design/standard/error/kernel")}</li>
    </ul>
</div>

{if $embed_content}
    {$embed_content}
{/if}
