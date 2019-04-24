<div class="card">
    {if $node|has_attribute( 'image' )}
        {attribute_view_gui attribute=$node|attribute( 'image' ) href=false() image_class='large' image_css_class="card-img-top"}
    {/if}
    <div class="card-body">
        <h5 class="card-title">
            {if is_set( $node.url_alias )}
                <a href="{$node.url_alias|ezurl('no')}" title="{$node.name|wash()}">{$node.name|wash()}</a>
            {else}
                {$node.name|wash()}
            {/if}
        </h5>
        <h6 class="card-subtitle mb-2 text-muted">
            {if $node.object.owner}{$node.object.owner.name|wash()} - {/if}{$node.object.published|l10n( shortdate )}
        </h6>
        {if $node|has_abstract()}
            {$node|abstract()}
        {/if}
    </div>
</div>