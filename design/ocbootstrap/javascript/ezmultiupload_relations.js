YAHOO.namespace('ez');

YAHOO.ez.MultiUploadRelations = (function()
{
    // Private

    var Dom = YAHOO.util.Dom,
        Event = YAHOO.util.Event,
        Connect = YAHOO.util.Connect,
        JSON = YAHOO.lang.JSON;

    var onContentReady = function(o)
    {
        this.setAllowMultipleFiles(true);
        if ( YAHOO.ez.MultiUploadRelations.cfg.fileType[0].extensions )
            this.setFileFilters(YAHOO.ez.MultiUploadRelations.cfg.fileType);

        Event.removeListener( Dom.get(YAHOO.ez.MultiUploadRelations.cfg.container+'uploadButtonOverlay'), 'click', missingFlashClick );
    };

    var missingFlashClick = function(o)
    {
        if ( YAHOO.ez.MultiUploadRelations.cfg.flashError )
            alert( YAHOO.ez.MultiUploadRelations.cfg.flashError );
        else
            alert( "Could not load flash(or not yet loaded), this is needed for MultiUploadRelations!" );
    };

    var onFileSelect = function(e)
    {
        Dom.setStyle(YAHOO.ez.MultiUploadRelations.cfg.container+'multiuploadProgress' , 'display', 'block');
        if( Dom.getStyle(YAHOO.ez.MultiUploadRelations.cfg.container+'multiuploadProgress' , 'opacity' ) == 0)
        {
            fadeAnimate(YAHOO.ez.MultiUploadRelations.cfg.container+'multiuploadProgress' , 0, 1);
        }
        Dom.setStyle(YAHOO.ez.MultiUploadRelations.cfg.container+'multiuploadProgressBar' , 'width', 0);        

        for(var i in e.fileList)
        {
            this.queue.push(e.fileList[i]);
        }

        var fileID = this.queue[this.uploadCounter]['id'];
        
        this.upload(fileID, YAHOO.ez.MultiUploadRelations.cfg.uploadURL, 'POST', YAHOO.ez.MultiUploadRelations.cfg.uploadVars);

        Dom.get(YAHOO.ez.MultiUploadRelations.cfg.container+'uploadButton').disabled = true;

        var cancelUploadButton = Dom.get(YAHOO.ez.MultiUploadRelations.cfg.container+'cancelUploadButton');
        Dom.setStyle(cancelUploadButton, 'visibility', 'visible');

        Event.on(cancelUploadButton, 'click', cancelUpload, this, true);

        this.disable();
    };

    var onUploadStart = function(e)
    {
        Dom.setStyle(YAHOO.ez.MultiUploadRelations.cfg.container+'multiuploadProgressBar' , 'width', 0);
        //Dom.get(YAHOO.ez.MultiUploadRelations.cfg.container+'multiuploadProgressMessage').innerHTML = '';
        //Dom.get(YAHOO.ez.MultiUploadRelations.cfg.container+'multiuploadProgressFile').innerHTML = (this.uploadCounter + 1) + '/' + this.queue.length;
        //Dom.get(YAHOO.ez.MultiUploadRelations.cfg.container+'multiuploadProgressFileName').innerHTML = this.queue[this.uploadCounter]['name'];
    };

    var onUploadProgress = function(e)
    {
        var width = Math.floor((YAHOO.ez.MultiUploadRelations.cfg.progressBarWidth * e['bytesLoaded']) / e['bytesTotal']);
        widthAnimate(YAHOO.ez.MultiUploadRelations.cfg.container+'multiuploadProgressBar', width);
    };

    var onUploadComplete = function(e)
    {
        //Dom.get(YAHOO.ez.MultiUploadRelations.cfg.container+'multiuploadProgressMessage').innerHTML = YAHOO.ez.MultiUploadRelations.cfg.thumbnailCreated;
        Dom.setStyle(YAHOO.ez.MultiUploadRelations.cfg.container+'multiuploadProgressBar' , 'width', '100%');

        if (this.uploadCounter < this.queue.length - 1) {
            this.uploadCounter++;

            var fileID = this.queue[this.uploadCounter]['id'];
            this.upload(fileID, YAHOO.ez.MultiUploadRelations.cfg.uploadURL, 'POST', YAHOO.ez.MultiUploadRelations.cfg.uploadVars);
        } else {
            this.uploadCounter = 0;
            this.queue = [];

            Dom.get(YAHOO.ez.MultiUploadRelations.cfg.container+'uploadButton').disabled = false;
            //Dom.get(YAHOO.ez.MultiUploadRelations.cfg.container+'multiuploadProgressMessage').innerHTML = YAHOO.ez.MultiUploadRelations.cfg.allFilesRecived;

            Dom.setStyle(YAHOO.ez.MultiUploadRelations.cfg.container+'cancelUploadButton', 'visibility', 'hidden');
            Dom.setStyle(YAHOO.ez.MultiUploadRelations.cfg.container+'multiuploadProgress' , 'display', 'none');
            var cancelUploadButton = Dom.get(YAHOO.ez.MultiUploadRelations.cfg.container+'cancelUploadButton');
            Dom.setStyle(cancelUploadButton, 'visibility', 'hidden');

            this.enable();
            this.clearFileList();
        }
    };

    var onUploadCompleteData = function(e)
    {        
        var response = JSON.parse(e.data);
        var result = response.result;
        if ( result.errors.length > 0 ){
            //$('#multiuploadProgressMessage').empty();
            //$.each( result.errors, function(){ $('#multiuploadProgressMessage').append( this.description ); });
        }else{
            var priority = parseInt($('#'+YAHOO.ez.MultiUploadRelations.cfg.container).parent().prev().find('input[name^="ContentObjectAttribute_priority"]:last-child').val()) || 0;
            priority = priority + this.uploadCounter;
            $.ez('ezjsctemplate::relation_list_row::'+result.contentobject_id+'::'+YAHOO.ez.MultiUploadRelations.cfg.attributeId+'::'+priority+'::?ContentType=json', false, function(content){                
                if (content.error_text.length) {
                    alert(content.error_text);
                }else{
                    var table = $('#'+YAHOO.ez.MultiUploadRelations.cfg.container).parents( ".ezcca-edit-datatype-ezobjectrelationlist" ).find('table').show().removeClass('hide');
                    table.find('tr.hide').before(content.content);                
                }
            });
        }
    };

    var onUploadError = function(e)
    {
        //console.log(e);
        alert( "Errore" );
    };

    var cancelUpload = function()
    {
        this.cancel();
        this.enable();
        this.clearFileList();

        this.uploadCounter = 0;
        this.queue = [];

        //Dom.get(YAHOO.ez.MultiUploadRelations.cfg.container+'multiuploadProgressMessage').innerHTML = YAHOO.ez.MultiUploadRelations.cfg.uploadCanceled;
        Dom.get(YAHOO.ez.MultiUploadRelations.cfg.container+'uploadButton').disabled = false;
        Dom.setStyle(YAHOO.ez.MultiUploadRelations.cfg.container+'multiuploadProgress' , 'display', 'none');
        var cancelUploadButton = Dom.get(YAHOO.ez.MultiUploadRelations.cfg.container+'cancelUploadButton');
        Dom.setStyle(cancelUploadButton, 'visibility', 'hidden');
    };

    var fadeAnimate = function(elementID, fromValue, toValue)
    {
        var anim = new YAHOO.util.Anim(elementID , { opacity: { from: fromValue, to: toValue } }, 0.2);
        anim.animate();
    };

    var widthAnimate = function(elementID, toValue)
    {
        var anim = new YAHOO.util.Anim(elementID , { width: { to: toValue } } , 0.5);
        anim.animate();
    };

    var stripTags = function(s)
    {
        return s.replace(/<\/?[^>]+>/gi, '');
    };

    var unescapeHTML = function(s)
    {
        var div = document.createElement('div');
        div.innerHTML = stripTags(s);
        return div.childNodes[0] ? div.childNodes[0].nodeValue : s;
    };

    // Public

    return {

        init: function() {            
            Event.onDOMReady(function()
            {
                var uploadButton = Dom.getRegion(YAHOO.ez.MultiUploadRelations.cfg.container+'uploadButton');
                var overlay = Dom.get(YAHOO.ez.MultiUploadRelations.cfg.container+'uploadButtonOverlay');

                Event.addListener( overlay, 'click', missingFlashClick );

                Dom.setStyle(overlay, 'width', uploadButton.right - uploadButton.left + "px");
                Dom.setStyle(overlay, 'height', uploadButton.bottom - uploadButton.top + "px");

                YAHOO.widget.Uploader.SWFURL = YAHOO.ez.MultiUploadRelations.cfg.swfURL;
                var uploader = new YAHOO.widget.Uploader(YAHOO.ez.MultiUploadRelations.cfg.container+'uploadButtonOverlay');

                uploader.on('contentReady', onContentReady);
                uploader.on('fileSelect', onFileSelect);
                uploader.on('uploadStart', onUploadStart);
                uploader.on('uploadProgress', onUploadProgress);
                uploader.on('uploadComplete', onUploadComplete);
                uploader.on('uploadCompleteData', onUploadCompleteData);
                uploader.on('uploadError', onUploadError);

                uploader.uploadCounter = 0;
                uploader.queue = [];
            }, this, true );
        },

        cfg: { swfURL: false,
               uploadURL: false,
               uploadVars: false,
               fileType: false,
               progressBarWidth: 300,
               allFilesRecived: '',
               uploadCanceled: '',
               thumbnailCreated: '',
               container:''}
    }
})();
