
{* get the sections list which consist of: sections allowed to assign to the object by the
   current loged in user, plus the section which is currently assigned to the object *}
{*{def $sections=fetch( 'content', 'section_list' )*}
{def $sections=$object.allowed_assign_section_list
     $currentSectionName='unknown'}

{* get the name of the object's current section *}
{foreach $sections as $sectionItem }
    {if eq( $sectionItem.id, $object.section_id )}
        {set $currentSectionName=$sectionItem.name}
    {/if}
{/foreach}

{undef $currentSectionName}


{* show the section selector *}
    <label for="SelectedSectionId">{'Choose section'|i18n( 'design/admin/node/view/full' )}:</label>
    <div class="input-group">
        <select id="SelectedSectionId" name="SelectedSectionId" class="form-control">
        {foreach $sections as $section}
            {if eq( $section.id, $object.section_id )}
            <option value="{$section.id}" selected="selected">{$section.name|wash}</option>
            {else}
            <option value="{$section.id}">{$section.name|wash}</option>
            {/if}
        {/foreach}
        </select>
        <div class="input-group-append">
            <input type="submit" value="{'Set'|i18n( 'design/admin/node/view/full' )}" name="SectionEditButton" class="btn btn-sm btn-info" />
        </div>
    </div>


