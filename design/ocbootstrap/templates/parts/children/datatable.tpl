{if is_set( $parameters )|not()}
  
  {def $classeTypes = fetch( 'ezfind', 'search', hash( 'subtree_array', array( $node.node_id ),
													   'limit', 1,
													   'filter', array( concat( '-meta_id_si:', $node.contentobject_id ) ),
													   'facet', array( hash( 'field', 'meta_class_identifier_ms', 'name', 'class_identifier', 'limit', 200 ) )
													)
						  ).SearchExtras.facet_fields[0].nameList
	   $_classes = fetch( 'class', 'list', hash( 'class_filter', $classeTypes ) )
	   $classes = array()
	   $class_names = array()
	   $fields = array( 'name', 'meta_class_name_ms', 'published', 'main_url_alias' )
	   $keys = array( 'Titolo', 'Tipo', 'Data' )}
  {foreach $_classes as $class}
	{set $classes = $classes|append( $class.identifier )}
	{set $class_names = $class_names|append( $class.name )}	
  {/foreach}

  {def $parameters = hash(
	'subtree', array( $node.node_id ),
	'classes', $classes,
	'class_names', $class_names,
	'fields', $fields,
	'keys', $keys,
	'filters', array( concat( '-meta_id_si:', $node.contentobject_id ) ),
	'table_id', concat( 'childOf-', $node.node_id ),
  )}
{/if}

<div class='row'>
    <div class='col-sm-12'>
        {include uri='design:datatable/view.tpl'
                 subtree=$parameters.subtree
                 classes=$parameters.classes
                 class_names=$parameters.class_names
                 fields=$parameters.fields
                 keys=$parameters.keys
                 filters=$parameters.filters
                 table_id=$parameters.table_id} 
    </div>
</div>
