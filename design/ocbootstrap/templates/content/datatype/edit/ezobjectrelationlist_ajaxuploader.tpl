{if and( is_set( $class_content.class_constraint_list ),
		 $class_content.class_constraint_list|count|ne( 0 ),
		 $class_content.class_constraint_list|contains( 'image', 'file', 'file_pdf' )
	   )}

<div id="{concat('multiupload-', $attribute.id)}" class="pull-left">
  <div id="{concat('multiupload-', $attribute.id)}uploadButtonOverlay" style="position: absolute; z-index: 2"></div>
  <button id="{concat('multiupload-', $attribute.id)}uploadButton" class="btn btn-success" type="button" style="z-index: 1">Aggiungi file</button>
  <button id="{concat('multiupload-', $attribute.id)}cancelUploadButton" class="btn btn-danger" type="button" style="visibility: hidden">{'Cancel'|i18n('extension/ezmultiupload')}</button>
  <noscript>{'Javascript has been disabled, this is needed for multiupload!'|i18n('extension/ezmultiupload')}</noscript>
</div>  
<div id="{concat('multiupload-', $attribute.id)}multiuploadProgress" class="multiuploadProgress">	
	<p id="{concat('multiupload-', $attribute.id)}multiuploadProgressMessage" class="multiuploadProgressMessage">&nbsp;</p>
	<div id="{concat('multiupload-', $attribute.id)}multiuploadProgressBarOutline"  class="multiuploadProgressBarOutline">
		<div id="{concat('multiupload-', $attribute.id)}multiuploadProgressBar" class="multiuploadProgressBar"></div>
	</div>
</div>

{def $start_node = cond( and( is_set( $class_content.default_placement.node_id ), $class_content.default_placement.node_id|ne( 0 ) ),
                                $class_content.default_placement.node_id,
								'auto' )}

{ezscript_require( array( 'ezjsc::yui2', 'ezjsc::jquery', 'ezjsc::jqueryio', 'jcookie.js' ) )}
<script type="text/javascript">
    var previewIcon = {'websitetoolbar/ezwt-icon-preview.png'|ezimage()};
    (function(){ldelim}
	  YUILoader.addModule({ldelim}
		name: 'ezmultiupload_relations',
		type: 'js',
		fullpath: '{"javascript/ezmultiupload_relations.js"|ezdesign( 'no' )}',
		requires: ["utilities", "json", "uploader"],
		after: ["uploader"],
		skinnable: false
	  {rdelim});

	  // Load the files using the insert() method and set it up and init it on success.
	  YUILoader.insert({ldelim}
		require: ["ezmultiupload_relations"],
		onSuccess: function(){ldelim}
			YAHOO.ez.MultiUploadRelations.cfg = {ldelim}
				attributeId: {$attribute.id},
				container:"{concat('multiupload-', $attribute.id)}",
				swfURL:"{concat( ezini('eZJSCore', 'LocalScriptBasePath', 'ezjscore.ini').yui2, 'uploader/assets/uploader.swf' )|ezdesign( 'no' )}",
				uploadURL: "{concat( 'ocbtools/multiupload/', $start_node )|ezurl( 'no' )}",
				uploadVars: {ldelim}'{session_name()}': '{session_id()}','ezxform_token': '@$ezxFormToken@','UploadButton': 'Upload'{rdelim},                    
				fileType: [{ldelim} description:"{'Allowed Files'|i18n('extension/ezmultiupload')|wash('javascript')}", extensions:'{$attribute|multiupload_file_types_string_from_attribute()}' {rdelim}],
				progressBarWidth: "145",
				allFilesRecived:  "{'All files received.'|i18n('extension/ezmultiupload')|wash(javascript)}",
				uploadCanceled:   "{'Upload canceled.'|i18n('extension/ezmultiupload')|wash(javascript)}",
				thumbnailCreated: "{'Thumbnail created.'|i18n('extension/ezmultiupload')|wash(javascript)}",
				flashError: "{'Could not load flash(or not loaded yet), this is needed for multiupload!'|i18n('extension/ezmultiupload')}"
			  {rdelim};
			YAHOO.ez.MultiUploadRelations.init();
		{rdelim},
		timeout: 10000,
  		combine: true
	  {rdelim}, "js");
	{rdelim})();   
</script>
<style>
{literal}
.multiuploadProgress {
    display: none;
    margin:0;
	position: absolute;
	bottom: -7px;
}

.multiuploadProgressBarOutline {
    width: 300px;
    padding: 1px;
    border: 1px solid #ccc;
}

.multiuploadProgressBar {
    width: 0px;
    height: 3px;
    background-color: #f00;
}

.cancelUploadButton {
    visibility: hidden;
}
{/literal}
</style>
{/if}