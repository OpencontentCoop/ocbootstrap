<div class="Grid">
    <div class="Form-field Grid-cell u-sizeFull u-sm-size8of12 u-md-size8of12 u-lg-size8of12">
    <select name="ContentObjectAttribute_ezpage_block_type_{$attribute.id}_{$zone_id}" class="Form-input">
    {def $allowed_zones = false()}
    {foreach ezini( 'General', 'AllowedTypes', 'block.ini' ) as $type}
        {if ezini_hasvariable( $type, 'AllowedZones', 'block.ini' )}
            {set $allowed_zones = ezini( $type, 'AllowedZones', 'block.ini' )}
        {else}
            {set $allowed_zones = false()}
        {/if}
        {if or( not( $allowed_zones ), and( $allowed_zones, $allowed_zones|contains( $zone.zone_identifier ) ) )}
            <option value="{$type}">{ezini( $type, 'Name', 'block.ini' )}</option>
        {/if}
    {/foreach}
    </select>
    </div>
    <div class="Form-field Form--Grid-cell u-sizeFull u-sm-size4of12 u-md-size4of12 u-lg-size4of12">
        <div class="u-padding-all-xs">
            <input class="button" type="submit" name="CustomActionButton[{$attribute.id}_new_block-{$zone_id}]" value="{'Add block'|i18n( 'design/standard/datatype/ezpage' )}" />
        </div>
    </div>
</div>

<button class="trigger expand-all button u-text-xxs" title="{'Expand All'|i18n( 'design/standard/datatype/ezpage' )}">{'Expand All'|i18n( 'design/standard/datatype/ezpage' )}</button>
<button class="trigger collapse-all button u-text-xxs" title="{'Collapse All'|i18n( 'design/standard/datatype/ezpage' )}">{'Collapse All'|i18n( 'design/standard/datatype/ezpage' )}</button>

<div id="zone-{$zone_id}-blocks">
{foreach $zone.blocks as $index => $block}
    {if ne( $block.action, 'remove' )}
        {block_edit_gui block=$block block_id=$index current_time=currentdate() zone_id=$zone_id attribute=$attribute zone=$zone}
    {/if}
{/foreach}
</div>
