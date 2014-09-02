{*$class_content.class_constraint_list|contains( 'image', 'file', 'file_pdf' )		 *}
{if and( is_set( $class_content.class_constraint_list ),
		 $class_content.class_constraint_list|count|ne( 0 ),
     ezini( 'ObjectRelationsMultiupload', 'ClassAttributeIdentifiers', 'ocoperatorscollection.ini' )|contains( $attribute.contentclass_attribute_identifier )     
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

{ezscript_require( array( 'ezjsc::yui2', 'ezjsc::jquery', 'ezjsc::jqueryio', 'ezmultiupload_relations.js', 'jcookie.js' ) )}
<script type="text/javascript">

{run-once}
	YUILoader.addModule({ldelim}
      name: 'ezmultiupload_relations',
      type: 'js',
      fullpath: '{"javascript/ezmultiupload_relations.js"|ezdesign( 'no' )}',
      requires: ["utilities", "json", "uploader"],
      after: ["uploader"],
      skinnable: false
	{rdelim});
  YUILoader.insert({ldelim}
		require: ["ezmultiupload_relations"],		
		timeout: 10000,
  		combine: true
	  {rdelim}, "js");
{/run-once}

$(document).ready(function(){ldelim}
  $("#{concat('multiupload-', $attribute.id)}").MultiUploadRelations({ldelim}
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
		{rdelim});
{rdelim});
</script>

{run-once}
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
{/run-once}
{/if}