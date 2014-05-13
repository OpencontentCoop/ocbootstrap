{set_defaults( hash(  
  'view', 'download_button',
  'size', 'btn-lg'
))}

{if is_set( $file.contentclassattribute_id )}
  {if $view|eq( 'download_button' )}
    <div class="download-file">
        <p>
          <a href="{concat( 'content/download/', $file.contentobject_id, '/', $file.id,'/version/', $file.version , '/file/', $file.content.original_filename|urlencode )|ezurl( 'no' )}" class="btn btn-primary {$size}">
            <span class="glyphicon glyphicon-download-alt"></span>
            {$file.content.original_filename|wash( xhtml )} {$file.content.filesize|si( byte )}
          </a>
        </p>
    </div>
  {/if}
{/if}