{set_defaults( hash(  
  'view', 'download_button',
  'size', 'btn-lg'
))}

{if and( $view|eq( 'flip' ), flip_exists( $file.id, $file.version )|not() )}
  {set $view = 'download_button'}
{/if}

{if is_set( $file.contentclassattribute_id )}

  {if or( $view|eq( 'download_button' ), flip_exists( $file.id, $file.version )|not() )}
    <div class="download-file">
        <p>
          <a href="{concat( 'content/download/', $file.contentobject_id, '/', $file.id,'/version/', $file.version , '/file/', $file.content.original_filename|urlencode )|ezurl( 'no' )}" class="btn btn-primary {$size}">
            <span class="glyphicon glyphicon-download-alt"></span>
            {$file.content.original_filename|wash( xhtml )} {$file.content.filesize|si( byte )}
          </a>
        </p>
    </div>
  {elseif $view|eq( 'flip' )}

    {include uri=flip_template( $file.id, $file.version ) id=$file.id version=$file.version view='small'}
    
	<div class="download-file">
		<p class="text-center">
		  <a href="{concat( 'content/download/', $file.contentobject_id, '/', $file.id,'/version/', $file.version , '/file/', $file.content.original_filename|urlencode )|ezurl( 'no' )}" class="btn btn-primary btn-sm">
			<span class="glyphicon glyphicon-download-alt"></span>
			{$file.content.original_filename|wash( xhtml )} {$file.content.filesize|si( byte )}
		  </a>
		</p>
	</div>

  {/if}
{/if}
