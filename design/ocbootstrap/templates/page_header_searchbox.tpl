
<form role="form" class="form form-search" method="get" action="{'/content/search'|ezurl( 'no' )}" id="site-wide-search">
  <div class="form-group">
  <label for="site-wide-search-field" class="control-label sr-only">{'Search'|i18n('design/ocbootstrap/pagelayout')}</label>
  {if $pagedata.is_edit}
    <input class="form-control" type="search" name="SearchText" id="site-wide-search-field" placeholder="{'Search text'|i18n('design/ocbootstrap/pagelayout')}" disabled="disabled" />
  {else}
    <input class="form-control" type="search" name="SearchText" id="site-wide-search-field" placeholder="{'Search text'|i18n('design/ocbootstrap/pagelayout')}" />
    {if eq( $ui_context, 'browse' )}
     <input name="Mode" type="hidden" value="browse" />
    {/if}
  {/if}
  </div>
</form>

{developer_warning( 'verifica se inserire o meno icona lente - vedi form has-feedback in doc bootstrap')}
