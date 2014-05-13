{* https://github.com/blueimp/Gallery vedi anche page_extra.tpl *}
{ezscript_require( array( "ezjsc::jquery", "plugins/blueimp/jquery.blueimp-gallery.min.js" ) )}
{ezcss_require( array( "plugins/blueimp/blueimp-gallery.css" ) )}

<div class="gallery">    
    {foreach $items as $item}
      <a href={$item|attribute('image').content.original.url|ezroot} title="{$item.name}" data-gallery>
        {attribute_view_gui attribute=$item|attribute('image') image_class=squarethumb fluid=false()}
      </a>
    {/foreach}    
</div>
