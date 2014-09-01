{if $attribute.content.tag_ids|count}
{if is_set( $#persistent_variable.keywords )}
    {set scope='global' persistent_variable=$#persistent_variable|merge( hash( 'keywords', concat( $#persistent_variable.keywords, ', ', $attribute.content.meta_keyword_string ) ) )}
{else}
    {if is_array( $#persistent_variable )|not()}
        {set scope='global' persistent_variable=hash( 'keywords', $attribute.content.meta_keyword_string )}
    {else}
        {set scope='global' persistent_variable=$#persistent_variable|merge( hash( 'keywords', $attribute.content.meta_keyword_string ) )}
    {/if}
{/if}    
    {foreach $attribute.content.tags as $tag}
        <a href={concat( '/tags/view/', $tag.url )|ezurl}><span class="label label-default"><i class="fa fa-tag"></i> {$tag.keyword|wash}</span></a>{delimiter} {/delimiter}
    {/foreach}
{/if}