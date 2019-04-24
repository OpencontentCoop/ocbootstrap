{* DO NOT EDIT THIS FILE! Use an override template instead. *}
<div class="alert alert-warning">
<h2>{"Invalid preferred currency"|i18n("design/standard/error/shop")}</h2>
{def $preferred_currency = fetch( 'shop', 'preferred_currency_code' )}
<p>{"'%1' currency does not exist."|i18n( 'design/standard/error/shop',, array( $preferred_currency ) )}</p>
{undef}

</div>

{if $embed_content}
    {$embed_content}
{/if}