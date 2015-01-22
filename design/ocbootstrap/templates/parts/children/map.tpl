{ezscript_require( array( 'ezjsc::jquery', 'plugins/leaflet/leaflet.js', 'plugins/leaflet/Leaflet.MakiMarkers.js', 'plugins/leaflet/leaflet.markercluster.js') )}
{ezcss_require( array( 'plugins/leaflet/leaflet.css', 'plugins/leaflet/map.css', 'plugins/leaflet/MarkerCluster.css', 'plugins/leaflet/MarkerCluster.Default.css' ) )}

{set_defaults(hash(
  'height', 600
))}

{def $markers = fetch( 'ocbtools', 'map_markers', hash( 'parent_node_id', $node.node_id ) )}

{if $markers|count()}

<div class="row">
  <div class="col-md-9">
	<div id="map-{$node.node_id}" style="height: {$height}px; width: 100%"></div>
	
  <script>            
  var tiles = L.tileLayer('http://{ldelim}s{rdelim}.tile.osm.org/{ldelim}z{rdelim}/{ldelim}x{rdelim}/{ldelim}y{rdelim}.png', {ldelim}maxZoom: 18,attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'{rdelim});
  var map = L.map('map-{$node.node_id}').addLayer(tiles);
  map.scrollWheelZoom.disable();
  var markersList = [];
  var markers = L.markerClusterGroup();
  var markersObjects = {$markers|json_encode()};
  
  $.each( markersObjects, function(i,m){ldelim}
    var customIcon = L.MakiMarkers.icon({ldelim}icon: "library", color: "#e5b200", size: "l"{rdelim}); //https://www.mapbox.com/maki/
    markersList[i] = L.marker([m.lat,m.lon],{ldelim}icon:customIcon{rdelim})
    markersList[i].bindPopup( "<h3><a href='"+m.urlAlias+"'>"+m.popupMsg+"</a><h3>");
    markers.addLayer(markersList[i]);                 
    map.addLayer(markers);
    map.fitBounds(markers.getBounds());
  {rdelim});                
  $(document).ready( function(){ldelim}        
    $('.list-markers-text a').bind( 'click', function(e){ldelim}
    var id = $(this).data('id');
    var m = markersList[id];
    markers.zoomToShowLayer(m, function() {ldelim}
        m.openPopup();
    {rdelim});        
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