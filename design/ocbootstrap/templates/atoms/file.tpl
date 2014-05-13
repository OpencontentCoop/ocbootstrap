{if is_set( $file.contentclassattribute_id )}
<div class="download-file">
    <p><a href="{concat( 'content/download/', $file.contentobject_id, '/', $file.id,'/version/', $file.version , '/file/', $file.content.original_filename|urlencode )|ezurl( 'no' )}" class="btn btn-warning">{$file.content.original_filename|wash( xhtml )} {$file.content.filesize|si( byte )}</a></p>
</div>
{/if}