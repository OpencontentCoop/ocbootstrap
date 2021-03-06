<div class="content-draft mb-3">

<script type="text/javascript">
{literal}
function checkAll()
{
{/literal}
    if ( document.draftaction.selectall.value == "{'Select all'|i18n('design/ocbootstrap/content/draft')}" )
{literal}
    {
{/literal}
        document.draftaction.selectall.value = "{'Deselect all'|i18n('design/ocbootstrap/content/draft')}";
{literal}
        with (document.draftaction) 
    {
            for (var i=0; i < elements.length; i++) 
        {
                if (elements[i].type == 'checkbox' && elements[i].name == 'DeleteIDArray[]')
                     elements[i].checked = true;
        }
        }
     }
     else
     {
{/literal}
         document.draftaction.selectall.value = "{'Select all'|i18n('design/ocbootstrap/content/draft')}";
{literal}
         with (document.draftaction) 
     {
            for (var i=0; i < elements.length; i++) 
        {
                if (elements[i].type == 'checkbox' && elements[i].name == 'DeleteIDArray[]')
                     elements[i].checked = false;
        }
         }
     }
}
{/literal}
</script>
{def $page_limit=30
     $list_count=fetch('content','draft_count')}

<form name="draftaction" action={concat("content/draft/")|ezurl} method="post" >

<div class="attribute-header">
    <h1 class="long">{"My drafts"|i18n("design/ocbootstrap/content/draft")}</h1>
</div>

{if $list_count}

<div class="float-right">
    <button class="btn btn-danger" type="submit" name="EmptyButton"><i class="fa fa-trash"></i> {'Empty draft'|i18n('design/ocbootstrap/content/draft')}</button>
</div>

<p>
    {"These are the current objects you are working on. The drafts are owned by you and can only be seen by you.
      You can either edit the drafts or remove them if you don't need them any more."|i18n("design/ocbootstrap/content/draft")|nl2br}
</p>

<table class="table" width="100%" cellspacing="0" cellpadding="0" border="0">
<tr>
    <th></th>
    <th>{"Name"|i18n("design/ocbootstrap/content/draft")}</th>
    <th>{"Class"|i18n("design/ocbootstrap/content/draft")}</th>
    <th>{"Section"|i18n("design/ocbootstrap/content/draft")}</th>
    <th>{"Version"|i18n("design/ocbootstrap/content/draft")}</th>
    <th>{"Language"|i18n("design/ocbootstrap/content/draft")}</th>
    <th>{"Last modified"|i18n("design/ocbootstrap/content/draft")}</th>
    <th>{"Edit"|i18n("design/ocbootstrap/content/draft")}</th>
</tr>

{foreach fetch('content', 'draft_version_list', hash( 'limit', $page_limit, 'offset', $view_parameters.offset ) ) as $draft
         sequence array(bglight,bgdark) as $style}
<tr class="{$style}">
    <td align="left" width="1">
        <input type="checkbox" name="DeleteIDArray[]" value="{$draft.id}" />
    </td>
    <td>
        <a href={concat("/content/versionview/",$draft.contentobject.id,"/",$draft.version,"/")|ezurl}>{$draft.version_name|wash}</a>
    </td>
    <td>
        {$draft.contentobject.content_class.name|wash}
    </td>
    <td>
        {$draft.contentobject.section_id}
    </td>
    <td>
        {$draft.version}
    </td>
    <td>
        {$draft.initial_language.name|wash}
    </td>
    <td>
        {$draft.modified|l10n(datetime)}
    </td>
    <td width="1">
        <a class="btn btn-sm btn-success" href={concat("/content/edit/",$draft.contentobject.id,"/",$draft.version,"/")|ezurl}>
            <i class="fa fa-pencil"></i>
        </a>
    </td>
</tr>
{/foreach}
<tr class="bgdark">
    <td colspan="8" align="left" width="1">
        <button class="btn btn-danger" type="submit" name="RemoveButton"><i class="fa fa-trash"></i> {'Remove'|i18n('design/ocbootstrap/content/draft')}</button>
        <input class="btn btn-info" name="selectall" onclick=checkAll() type="button" value="{'Select all'|i18n('design/ocbootstrap/content/draft')}" />
    </td>
</tr>
</table>
{include name=navigator
         uri='design:navigator/google.tpl'
         page_uri='/content/draft'
         item_count=$list_count
         view_parameters=$view_parameters
         item_limit=$page_limit}

{else}

<div class="alert alert-success">
<h2>{"You have no drafts"|i18n("design/ocbootstrap/content/draft")}</h2>
</div>

{/if}

</form>

</div>
