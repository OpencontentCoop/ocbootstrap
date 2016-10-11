{if and( fetch( 'user', 'current_user' ).is_logged_in, $node.can_edit )}    
  <div class="panel panel-info">
    <div class="panel-heading">Informazioni per l'editor</div>
	<div class="panel-body">
	  <dl class="dl-horizontal">
		  
		  <dt>Ultima modifica di:</dt>
		  <dd> <a href={$node.creator.main_node.url_alias|ezurl}>{$node.creator.name}</a> il {$node.object.modified|l10n(shortdatetime)}</dd>         
		  
		  <dt>Creato da:</dt>
		  <dd> <a href={$node.object.owner.main_node.url_alias|ezurl}>{$node.object.owner.name}</a> il {$node.object.published|l10n(shortdatetime)}</dd>    		
		  
		  <dt>Nodo:</dt>
		  <dd> {$node.node_id}</dd>
		  
		  <dt>Oggetto</dt>
		  <dd> {$node.contentobject_id} ({$node.object.remote_id})</dd>
		  
		  {if count( $node.object.assigned_nodes )|gt(1)}
			  <dt>Collocazioni:</dt>
			  <dd> <ul>{foreach $node.object.assigned_nodes as $item}<li><a href={$item|ezurl()}>{$item.path_with_names}</a> {if $item.node_id|eq($node.object.main_node_id)}(principale){/if}</li>{/foreach}</ul></dd>
		  {/if}
		  
		  {def $sezione = fetch( 'section', 'object', hash( 'section_id', $node.object.section_id ))}
		  <dt>Sezione: </dt>
		  <dd>{$sezione.name|wash}</dd>
		  
		  <dt>Tipo: </dt>
		  <dd>{$node.class_name} ({$node.class_identifier})</dd>
		  
		  {def $states = $node.object.allowed_assign_state_list}
		  {if $states|count}
		  <dt>Stati:</dt>
		  <dd> {foreach $states as $allowed_assign_state_info}{foreach $allowed_assign_state_info.states as $state}{if $node.object.state_id_array|contains($state.id)}{$allowed_assign_state_info.group.current_translation.name|wash()}/{$state.current_translation.name|wash}{/if}{/foreach}{delimiter}, {/delimiter}{/foreach}</dd>
		  {/if}
	  </dl>
	</div>
  </div>	
{/if}
