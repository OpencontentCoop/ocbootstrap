{set_defaults( hash(  
  'image_class', 'squaremedium',  
  'items', array(),
  'wide_class', 'original',
  'show_number', 3
))}


{ezscript_require( array( 'ezjsc::jquery', 'plugins/owl-carousel/owl.carousel.min.js', "plugins/blueimp/jquery.blueimp-gallery.min.js" ) )}
{ezcss_require( array( 'plugins/owl-carousel/owl.carousel.css', 'plugins/owl-carousel/owl.theme.css', "plugins/blueimp/blueimp-gallery.css" ) )}

<div id="owl-demo" class="owl-carousel">
  {foreach $items as $item}
	<div class="item text-center">
	  
	  <a href={$item|attribute('image').content[$wide_class].url|ezroot} title="{$item.name}" data-gallery>
		{attribute_view_gui attribute=$item|attribute( 'image' ) image_class=$image_class}
	  </a>
			  
	</div>
  {/foreach}  
</div>

<script>
{literal}
$(document).ready(function() {
  $("#owl-demo").owlCarousel({	
	items : {/literal}{$show_number}{literal}	
  });
});
{/literal}
</script>