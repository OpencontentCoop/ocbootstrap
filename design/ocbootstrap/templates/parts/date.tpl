{set_defaults( hash(
  'l10n', 'shortdatetime'	
))}

<span class="date">{$node.object.published|l10n( shortdatetime )}</span>