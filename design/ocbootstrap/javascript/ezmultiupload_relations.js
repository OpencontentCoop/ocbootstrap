;(function($){
    $.fn.extend({
        MultiUploadRelations: function(options) {
            
            var Dom = YAHOO.util.Dom,
                Event = YAHOO.util.Event,
                Connect = YAHOO.util.Connect,
                JSON = YAHOO.lang.JSON;
            
            this.defaultOptions = {
                swfURL: false,
                uploadURL: false,
                uploadVars: false,
                fileType: false,
                progressBarWidth: 300,
                allFilesRecived: '',
                uploadCanceled: '',
                thumbnailCreated: '',
                container:''
            };
            var settings = $.extend({}, this.defaultOptions, options);
            
            var onContentReady = function(o)
            {        
                this.setAllowMultipleFiles(true);
                if ( settings.fileType[0].extensions )
                    this.setFileFilters(settings.fileType);
                Event.removeListener( Dom.get(settings.container+'uploadButtonOverlay'), 'click', missingFlashClick );
            };
        
            var missingFlashClick = function(o)
            {
                if ( settings.flashError )
                    alert( settings.flashError );
                else
                    alert( "Could not load flash(or not yet loaded), this is needed for MultiUploadRelations!" );
            };
        
            var onFileSelect = function(e)
            {
                Dom.setStyle(settings.container+'multiuploadProgress' , 'display', 'block');
                if( Dom.getStyle(settings.container+'multiuploadProgress' , 'opacity' ) == 0)
                {
                    fadeAnimate(settings.container+'multiuploadProgress' , 0, 1);
                }
                Dom.setStyle(settings.container+'multiuploadProgressBar' , 'width', 0);        
        
                for(var i in e.fileList)
                {
                    this.queue.push(e.fileList[i]);
                }
        
                var fileID = this.queue[this.uploadCounter]['id'];
                
                this.upload(fileID, settings.uploadURL, 'POST', settings.uploadVars);
        
                Dom.get(settings.container+'uploadButton').disabled = true;
        
                var cancelUploadButton = Dom.get(settings.container+'cancelUploadButton');
                Dom.setStyle(cancelUploadButton, 'visibility', 'visible');
        
                Event.on(cancelUploadButton, 'click', cancelUpload, this, true);
        
                this.disable();
            };
        
            var onUploadStart = function(e)
            {
                Dom.setStyle(settings.container+'multiuploadProgressBar' , 'width', 0);
                //Dom.get(settings.container+'multiuploadProgressMessage').innerHTML = '';
                //Dom.get(settings.container+'multiuploadProgressFile').innerHTML = (this.uploadCounter + 1) + '/' + this.queue.length;
                //Dom.get(settings.container+'multiuploadProgressFileName').innerHTML = this.queue[this.uploadCounter]['name'];
            };
        
            var onUploadProgress = function(e)
            {
                var width = Math.floor((settings.progressBarWidth * e['bytesLoaded']) / e['bytesTotal']);
                widthAnimate(settings.container+'multiuploadProgressBar', width);
            };
        
            var onUploadComplete = function(e)
            {
                //Dom.get(settings.container+'multiuploadProgressMessage').innerHTML = settings.thumbnailCreated;
                Dom.setStyle(settings.container+'multiuploadProgressBar' , 'width', '100%');
        
                if (this.uploadCounter < this.queue.length - 1) {
                    this.uploadCounter++;
        
                    var fileID = this.queue[this.uploadCounter]['id'];
                    this.upload(fileID, settings.uploadURL, 'POST', settings.uploadVars);
                } else {
                    this.uploadCounter = 0;
                    this.queue = [];
        
                    Dom.get(settings.container+'uploadButton').disabled = false;
                    //Dom.get(settings.container+'multiuploadProgressMessage').innerHTML = settings.allFilesRecived;
        
                    Dom.setStyle(settings.container+'cancelUploadButton', 'visibility', 'hidden');
                    Dom.setStyle(settings.container+'multiuploadProgress' , 'display', 'none');
                    var cancelUploadButton = Dom.get(settings.container+'cancelUploadButton');
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
                    var priority = parseInt($('#'+settings.container).parent().prev().find('input[name^="ContentObjectAttribute_priority"]:last-child').val()) || 0;
                    priority = priority + this.uploadCounter;
                    $.ez('ezjsctemplate::relation_list_row::'+result.contentobject_id+'::'+settings.attributeId+'::'+priority+'::?ContentType=json', false, function(content){                
                        if (content.error_text.length) {
                            alert(content.error_text);
                        }else{
                            var table = $('#'+settings.container).parents( ".ezcca-edit-datatype-ezobjectrelationlist" ).find('table').show().removeClass('hide');
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
        
                //Dom.get(settings.container+'multiuploadProgressMessage').innerHTML = settings.uploadCanceled;
                Dom.get(settings.container+'uploadButton').disabled = false;
                Dom.setStyle(settings.container+'multiuploadProgress' , 'display', 'none');
                var cancelUploadButton = Dom.get(settings.container+'cancelUploadButton');
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
            
            return this.each(function() {
                
                var uploadButton = Dom.getRegion(settings.container+'uploadButton');
                var overlay = Dom.get(settings.container+'uploadButtonOverlay');

                Event.addListener( overlay, 'click', missingFlashClick );

                Dom.setStyle(overlay, 'width', uploadButton.right - uploadButton.left + "px");
                Dom.setStyle(overlay, 'height', uploadButton.bottom - uploadButton.top + "px");

                YAHOO.widget.Uploader.SWFURL = settings.swfURL;
                var uploader = new YAHOO.widget.Uploader(settings.container+'uploadButtonOverlay');

                uploader.on('contentReady', onContentReady);
                uploader.on('fileSelect', onFileSelect);
                uploader.on('uploadStart', onUploadStart);
                uploader.on('uploadProgress', onUploadProgress);
                uploader.on('uploadComplete', onUploadComplete);
                uploader.on('uploadCompleteData', onUploadCompleteData);
                uploader.on('uploadError', onUploadError);

                uploader.uploadCounter = 0;
                uploader.queue = [];
                
            });
        }
    });
})(jQuery);