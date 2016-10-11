{* content_type *}
{set-block scope=global variable=content_type}text/html{/set-block}

{* subject *}
{def $siteName = ezini( 'SiteSettings', 'SiteName' )}
{set-block scope=root variable=subject}[{$siteName}]{"Collected information from %1"|i18n("design/ocbootstrap/collectedinfomail/form",,array($collection.object.name|wash))}{/set-block}

{* email_receiver *}
{if and(is_set($node.object.data_map.email_receiver), $node.object.data_map.email_receiver.has_content)}
    {set-block scope=global variable=email_receiver}{$node.object.data_map.email_receiver.content}{/set-block}
{elseif and(is_set($node.object.data_map.recipient), $node.object.data_map.recipient.has_content)}
    {set-block scope=global variable=email_receiver}{$node.object.data_map.recipient.content}{/set-block}
{elseif and(is_set($node.object.data_map.receiver), $node.object.data_map.receiver.has_content)}
    {set-block scope=global variable=email_receiver}{$node.object.data_map.receiver.content}{/set-block}
{/if}

{* email_cc_receivers *}
{if and(is_set($node.object.data_map.email_cc_receivers), $node.object.data_map.email_cc_receivers.has_content)}
    {set-block scope=root variable=email_cc_receivers}{$node.object.data_map.email_cc_receivers.content}{/set-block}
{/if}

{* email_bcc_receivers *}
{if and(is_set($node.object.data_map.email_bcc_receivers), $node.object.data_map.email_bcc_receivers.has_content)}
    {set-block scope=root variable=email_bcc_receivers}{$node.object.data_map.email_bcc_receivers.content}{/set-block}
{/if}

{* email_sender *}
{if and(is_set($node.object.data_map.email_sender), $node.object.data_map.email_sender.has_content)}
    {set-block scope=root variable=email_sender}{$node.object.data_map.email_sender.content}{/set-block}
{/if}

{* email_reply_to *}
{if and(is_set($node.object.data_map.email_reply_to), $node.object.data_map.email_reply_to.has_content)}
    {set-block scope=root variable=email_reply_to}{$node.object.data_map.email_reply_to.content}{/set-block}
{/if}

{* redirect_to_node_id *}
{if and(is_set($node.object.data_map.redirect_to_node_id), $node.object.data_map.redirect_to_node_id.has_content)}
    {set-block scope=root variable=redirect_to_node_id}{$node.object.data_map.redirect_to_node_id.content}{/set-block}
{/if}

<strong>{"The following information was collected"|i18n("design/ocbootstrap/collectedinfomail/form")}:</strong>

<table width="100%" border="1" cellspacing="0" cellpadding="4">
{foreach $collection.attributes as $attribute}
    <tr>
        <th align='left' valign='top'>{$attribute.contentclass_attribute_name|wash}</th>
        <td align='left' valign='top'>{attribute_result_gui view=info attribute=$attribute}</td>
    </tr>
{/foreach}
</table>

<small>{$node.name|wash()} - {$node.url_alias|ezurl(no, full)}</small>