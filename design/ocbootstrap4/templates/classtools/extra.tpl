<div class="global-view-full">

{if is_set( $class )}
    <h2>Impostazioni di visualizzazione {$class.name}</h2>
{/if}

{if count( $extra_handlers )|gt(1)}
    <form method="post" action="">
        <div class="row">
            <div class="col-md-6">
                <label for="handler">
                    Seleziona impostazione
                </label>
            </div>
            <div class="col-md-4">
                <label for="class">
                    Classe
                </label>
            </div>
            <div class="col-md-2">
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <select name="handler" id="handler" class="form-control">
                    {foreach $extra_handlers as $identifier => $item}
                        <option value="{$item.identifier}"
                                {if $item.identifier|eq($handler.identifier)}selected="selected"{/if}>{$item.name|wash()}</option>
                    {/foreach}
                </select>
            </div>
            <div class="col-md-4">
                {def $classList = fetch( 'class', 'list', hash( 'sort_by', array( 'name', true() ) ) )}
                <select name="class" id="class"  class="form-control">
                    {foreach $classList as $classItem}
                        <option value="{$classItem.identifier}"
                                {if $class.identifier|eq($classItem.identifier)}selected="selected"{/if}>{$classItem.name|wash()}</option>
                    {/foreach}
                </select>
            </div>
            <div class="col-md-2">
                <button type="submit" class="btn btn-warning">Seleziona</button>
            </div>
        </div>
    </form>
    <hr />
{/if}

{if is_set( $class )}

    <h3>{$handler.name|wash()}</h3>

    <form action="{concat('/classtools/extra/',$class.identifier,'/',$handler.identifier)|ezurl()}" method="post">

        <div class="extra_parameters_handlers">
            <div class="checkbox">
                <label>
                    <input type="checkbox" class="handler-toggle" data-handler="{$handler.identifier}" name="extra_handler_{$handler.identifier}[class][{$class.identifier}][enabled]" value="1" {if $handler.enabled}checked="checked"{/if} /> Abilita {$handler.name|wash()}
                </label>
            </div>
            {include uri=$handler.class_edit_template_url handler=$handler class=$class}
        </div>

        {if $handler.handle_attributes}
        <table width="100%" cellspacing="0" cellpadding="0" border="0" class="table list">
            <tbody>
            {foreach $class.data_map as $attribute}
                <tr id="{$attribute.identifier}">
                    <th style="vertical-align: middle;width: 20%">
                        {$attribute.name} ({$attribute.identifier})
                    </th>
                    {include uri=$handler.attribute_edit_template_url handler=$handler class=$class attribute=$attribute}
                </tr>
            {/foreach}
            </tbody>
        </table>
        {/if}

        {if $handler.handle_custom_attributes}
            <h5>Attributi custom</h5>
            <table width="100%" cellspacing="0" cellpadding="0" border="0" class="table list">
                <tbody>
                {foreach $handler.custom_attributes as $attribute}
                    <tr id="{$attribute.identifier}">
                        <th style="vertical-align: middle;width: 20%">
                            {$attribute.name} ({$attribute.identifier})
                        </th>
                        {include uri=$handler.attribute_edit_template_url handler=$handler class=$class attribute=$attribute}
                    </tr>
                {/foreach}
                </tbody>
            </table>
        {/if}

        <div class="text-right">
            <input type="submit" class="extra_parameters_handlers btn btn-success" name="StoreExtraParameters" value="Salva impostazioni" />
        </div>

    </form>


{/if}

</div>