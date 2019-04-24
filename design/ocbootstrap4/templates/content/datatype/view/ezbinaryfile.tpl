{set_defaults( hash(
                'icon_size', 'small',
                'icon_title', $attribute.content.mime_type,
                'icon','no',
                'show_flip', false()
))}


{if $attribute.has_content}
	{if $attribute.content}
	{switch match=$icon}
		{case match='no'}
			<a href={concat("content/download/",$attribute.contentobject_id,"/",$attribute.id,"/file/",$attribute.content.original_filename)|ezurl} title="Scarica il file {$attribute.content.original_filename|wash( xhtml )}">
				<i class="fa fa-download"></i> {$attribute.content.original_filename} ({$attribute.content.filesize|si( byte )})
            </a>
		{/case}
		{case}
			<a href={concat("content/download/",$attribute.contentobject_id,"/",$attribute.id,"/file/",$attribute.content.original_filename)|ezurl} title="Scarica il file {$attribute.content.original_filename|wash( xhtml )}">
                {$attribute.content.mime_type|mimetype_icon( $icon_size, $icon_title )}
                {$attribute.content.original_filename} ({$attribute.content.filesize|si( byte )})               
            </a>
		{/case}
	{/switch}
	{else}
		<div class="message-error"><h2>{'The file could not be found.'|i18n( 'design/ezwebin/view/ezbinaryfile' )}</h2></div>
	{/if}
{/if}

{if and($show_flip, flip_exists($attribute.id, $attribute.version))}
    {include uri=flip_template( $attribute.id, $attribute.version ) id=$attribute.id version=$attribute.version view='small'}
{/if}
