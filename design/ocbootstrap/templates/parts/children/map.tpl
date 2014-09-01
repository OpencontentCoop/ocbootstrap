{ezscript_require( array( 'ezjsc::jquery', 'plugins/leaflet/leaflet.js') )}
{ezcss_require( array( 'plugins/leaflet/leaflet.css', 'plugins/leaflet/map.css' ) )}

{set_defaults(hash(
  'height', 600
))}

{def $markers = fetch( 'ocbtools', 'map_markers', hash( 'parent_node_id', $node.node_id ) )}

{if $markers|count()}

<div class="row">
  <div class="col-md-9">
	<div id="map-{$node.node_id}" style="height: {$height}px; width: 100%"></div>
	
	<script>
	L.Icon.Default.imagePath = {'javascript/plugins/leaflet/images'|ezdesign()};
	var map = L.map( 'map-{$node.node_id}' );
	var markers = [];
	var markersObjects = {$markers|json_encode()};
	$.each( markersObjects, function(i,m){ldelim}           
		marker = L.marker([m.lat,m.lon]).addTo(map);	
		marker.bindPopup( "<h3><a href='"+m.urlAlias+"'>"+m.popupMsg+"</a><h3>");
		markers[i] = marker;
	{rdelim});            
	var group = new L.featureGroup( markers );
	map.fitBounds(group.getBounds());    
	L.tileLayer({literal}'http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png'{/literal}, {ldelim}
		attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors',
		maxZoom: 18
	{rdelim}).addTo(map);
	$(document).ready( function(){ldelim}
	  $('.list-markers-text a').bind( 'click', function(e){ldelim}
		var id = $(this).data('id');
		markers[id].openPopup();
		e.preventDefault();
	  {rdelim});
	{rdelim});
	</script>
  </div>
  <div class="col-md-3">
	<ul class="list-markers-text list-unstyled" style="height: {$height}px;overflow-y: auto">
	{foreach $markers as $i => $marker}
	  <li><a data-id="{$i}" href='{$marker.urlAlias}'>{$marker.popupMsg}</a></li>
	{/foreach}
	</ul>
  </div>

</div>
{/if}