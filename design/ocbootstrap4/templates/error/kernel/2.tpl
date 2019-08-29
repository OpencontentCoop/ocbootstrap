<div class="alert alert-warning">
    <h2>{"Not found"|i18n("design/standard/error/kernel")}</h2>
    <p>{"The resource you requested was not found."|i18n("design/standard/error/kernel")}</p>
    <p>{"Possible reasons for this are"|i18n("design/standard/error/kernel")}:</p>
    <ul>
        <li>{"The the id or name of the resource was misspelled, try changing it."|i18n("design/standard/error/kernel")}</li>
        <li>{"The resource no longer exists on the site."|i18n("design/standard/error/kernel")}</li>
    </ul>
</div>

{if $embed_content}
    {$embed_content}
{/if}
