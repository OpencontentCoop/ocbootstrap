;(function ( $, window, document, undefined ) {

    var pluginName = "initLeafletMap";

    function InitLeafletMap ( element, markersObjects ) {        
        this.element = element;
        this.markersObjects = markersObjects;        
        this.init();        
    }

    InitLeafletMap.prototype = {
        init: function () {                        
            var map = L.map( $(this.element).attr( 'id' ) ).setView([51.505, -0.09], 13);
            //L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
            //    attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
            //}).addTo(map);
            //var markers = [];
            //$.each( this.markersObjects, function(i,m){                
            //    marker = L.marker( L.latLng( m.lat, m.lon ) );
            //    marker.addTo(map);
            //    marker.bindPopup( "<a href='m.urlAlias'>m.popupMsg</a>");
            //    markers.push(marker);
            //});            
            //var group = new L.featureGroup( markers );
            //map.fitBounds(group.getBounds());            
        },
    };

    $.fn[ pluginName ] = function ( markersObjects ) {                
        this.each(function() {            
            if ( !$.data( this, "plugin_" + pluginName ) ) {
                $.data( this, "plugin_" + pluginName, new InitLeafletMap( this, markersObjects ) );                
            }
        });
        return this;
    };
})( jQuery, window, document );
