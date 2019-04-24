{* DO NOT EDIT THIS FILE! Use an override template instead. *}

{if $attribute.has_content}
<ul class="list-unstyled">
{foreach $attribute.content as $file}
  <li>
    <a href={concat( 'ocmultibinary/download/', $attribute.contentobject_id, '/', $attribute.id,'/', $attribute.version , '/', $file.filename ,'/file/', $file.original_filename|urlencode )|ezurl}>
      <i class="fa fa-download"></i> {$file.original_filename|wash( xhtml )} ({$file.filesize|si( byte )})
    </a>
  </li>
{/foreach}
</ul>
{/if}