{* Load JavaScript dependencys + JavaScriptList *}
{ezscript_load( array(
    'ezjsc::jquery',
    ezini( 'JavaScriptSettings', 'JavaScriptList', 'design.ini' ),
    ezini( 'JavaScriptSettings', 'FrontendJavaScriptList', 'design.ini' )
))}

<!--[if lt IE 9]>
<script type="text/javascript" src={"javascript/respond.js"|ezdesign()} ></script>
<![endif]-->