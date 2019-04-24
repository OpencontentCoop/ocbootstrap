<div class="row mb-5">
    <div class="col-md-8 offset-md-2">
        {if $account_activated}
            <h1>{"Activate account"|i18n("design/ocbootstrap/user/activate")}</h1>
            <div class="alert alert-success">
                {if $is_pending}
                    {'Your email address has been confirmed. An administrator needs to approve your sign up request, before your login becomes valid.'|i18n('design/standard/user')}
                {else}
                    {'Your account is now activated.'|i18n('design/standard/user')}
                {/if}
            </div>
        {elseif $already_active}
            <h1>{"Activate account"|i18n("design/ocbootstrap/user/activate")}</h1>
            <div class="alert alert-success">
                {'Your account is already active.'|i18n('design/standard/user')}
            </div>
        {else}
            <div class="alert alert-danger">
                {'Sorry, the key submitted was not a valid key. Account was not activated.'|i18n('design/standard/user')}
            </div>
        {/if}
        <form action={"/user/login"|ezurl} method="post" class="form float-right">
            <input class="btn btn-danger" type="submit" value="{'OK'|i18n( 'design/ocbootstrap/user/activate' )}"/>
        </form>
    </div>
</div>

