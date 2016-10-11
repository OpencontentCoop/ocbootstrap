<div class="content-view-full class-{$node.class_identifier} row">
  
  {include uri='design:nav/nav-section.tpl'}
  
  <div class="content-main">
    
    <h1>{$node.name|wash()}</h1>
    
    {if $node|has_attribute( 'description' )}
      <div class="description">
        {attribute_view_gui attribute=$node|attribute( 'description' )}
      </div>
    {/if}
    
    {include name=Validation uri='design:content/collectedinfo_validation.tpl'
             class='message-warning'
             validation=$validation collection_attributes=$collection_attributes}

    <form method="post" action={"content/action"|ezurl} class="form-horizontal" role="form">

      <div class="form-group attribute-sender-first-name">
          <label class="col-sm-2 control-label">
              {$node.data_map.first_name.contentclass_attribute.name}
          </label>
          <div class="col-sm-8">
              {attribute_view_gui attribute=$node.data_map.first_name}
          </div>
      </div>

       <div class="form-group">
          <label class="col-sm-2 control-label">
              {$node.data_map.last_name.contentclass_attribute.name}
		  </label>
          <div class="col-sm-8">
              {attribute_view_gui attribute=$node.data_map.last_name}
          </div>
      </div>
      <div class="form-group attribute-sender-email">
          <label class="col-sm-2 control-label">
              {$node.data_map.email.contentclass_attribute.name}
          </label>
          <div class="col-sm-8">
              {attribute_view_gui attribute=$node.data_map.email}
          </div>
      </div>
      <div class="form-group attribute-sender-country">
          <label class="col-sm-2 control-label">
              {$node.data_map.country.contentclass_attribute.name}
          </label>
          <div class="col-sm-8">
              {attribute_view_gui attribute=$node.data_map.country}
          </div>
      </div>
      <div class="form-group attribute-sender-subject">
          <label class="col-sm-2 control-label">
              {$node.data_map.subject.contentclass_attribute.name}
		  </label>
          <div class="col-sm-8">
              {attribute_view_gui attribute=$node.data_map.subject}
          </div>
      </div>
      <div class="form-group attribute-sender-message">
          <label class="col-sm-2 control-label">
              {$node.data_map.message.contentclass_attribute.name}
          </label>
          <div class="col-sm-8">
              {attribute_view_gui attribute=$node.data_map.message}
          </div>
      </div>
      
      <div class="form-group">
		<div class="col-sm-offset-2 col-sm-10">
          <input type="submit" class="btn btn-warning" name="ActionCollectInformation" value="{"Send form"|i18n("design/ocbootstrap/full/feedback_form")}" />
          <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
          <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
          <input type="hidden" name="ViewMode" value="full" />
        </div>
      </div>
    </form>
	
  </div>
  
</div>

