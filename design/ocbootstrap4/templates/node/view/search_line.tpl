<div class="card mb-2">
    <div class="card-body">
        <h5 class="card-title">
            <a href="{$node.url_alias|ezurl('no')}" title="{$node.name|wash()}">{$node.name|wash()}</a>
        </h5>
        <h6 class="card-subtitle mb-2 text-muted">{$node.object.published|l10n(date)} - {$node.class_name}</h6>
        {if $node|has_abstract()}
            <p>{$node|abstract()|oc_shorten(200)}</p>
        {/if}
        <small class="text-muted">{$node.path_with_names}</small>
    </div>
</div>