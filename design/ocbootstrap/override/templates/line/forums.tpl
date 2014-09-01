{* Forums - Line view *}

<div class="content-view-line class-{$node.class_identifier} media">    
  <div class="media-body">
      <h3 class="media-heading">
		<a href={$node.url_alias|ezurl}>{$node.name|wash}</a>
	  </h3>

       {section show=$node.data_map.description.content.is_empty|not}
        <div class="attribute-short">
        {attribute_view_gui attribute=$node.data_map.description}
        </div>
       {/section}

    </div>
</div>
