<div class="alert alert-warning">
    {if $parameters.check.view_checked}
        <h2>{"View is disabled"|i18n("design/standard/error/kernel",,array($parameters.check.view,$parameters.check.module))}</h2>
        <ul>
            <li>{"The view %module/%view is disabled and cannot be accessed."|i18n("design/standard/error/kernel",,
                hash('%view',$parameters.check.view,
                '%module',$parameters.check.module))}</li>
        </ul>
    {else}
        <h2>{"Module is disabled"|i18n("design/standard/error/kernel",,array($parameters.check.module))}</h2>
        <ul>
            <li>{"The module %module is disabled and cannot be accessed."|i18n("design/standard/error/kernel",,hash('%module',$parameters.check.module))}</li>
        </ul>
    {/if}
</div>

{if $embed_content}
    {$embed_content}
{/if}