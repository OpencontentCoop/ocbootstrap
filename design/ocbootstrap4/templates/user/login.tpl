<div class="row">
    <div class="col-md-4 offset-md-4">
        <h1 class="text-center title">{"Login"|i18n("design/ocbootstrap/user/login")}</h1>

        {if $User:warning.bad_login}
            <div class="alert alert-danger">
                <p><strong>{"Could not login"|i18n("design/ocbootstrap/user/login")}</strong></p>
                <p>{"A valid username and password is required to login."|i18n("design/ocbootstrap/user/login")}</p>
            </div>
        {/if}

        {if $site_access.allowed|not}
            <div class="alert alert-danger">
                <p><strong>{"Access not allowed"|i18n("design/ocbootstrap/user/login")}</strong></p>
                <p>{"You are not allowed to access %1."|i18n("design/ocbootstrap/user/login",,array($site_access.name))}</p>
            </div>
        {/if}

        <form class="validate-form" method="post" action={"/user/login/"|ezurl} name="loginform">
            <div class="form-group">
                <div class="controls">
                    <input type="text" autofocus="" autocomplete="off" name="Login"
                           placeholder="{"Username"|i18n("design/ocbootstrap/user/login","User name")}"
                           class="form-control" data-rule-required="true" value="{$User:login|wash}">
                </div>
            </div>
            <div class="form-group">
                <div class="controls">
                    <input type="password" autocomplete="off" name="Password"
                           placeholder="{"Password"|i18n("design/ocbootstrap/user/login")}" class="form-control"
                           data-rule-required="true">
                </div>
            </div>
            <div class="form-group form-check">
                <input id="remember_me" class="form-check-input" type="checkbox" tabindex="1" name="Cookie" />
                <label class="form-check-label" for="remember_me">{"Remember me"|i18n("design/ocbootstrap/user/login")}</label>
            </div>
            <button class="btn btn-lg btn-primary d-block mx-auto"
                    name="LoginButton">{"Login"|i18n("design/ocbootstrap/user/login","Button")}</button>

            {if and( is_set( $User:post_data ), is_array( $User:post_data ) )}
                {foreach $User:post_data as $key => $postData}
                    <input name="Last_{$key|wash}" value="{$postData|wash}" type="hidden"/>
                    <br/>
                {/foreach}
            {/if}
            <input type="hidden" name="RedirectURI" value="{$User:redirect_uri|wash}"/>

        </form>
    </div>
</div>
<hr>
<div class="text-center mb-5">
    <a href={if ezmodule( 'userpaex' )}{'/userpaex/forgotpassword'|ezurl}{else}{"/user/forgotpassword"|ezurl}{/if}>{"Forgot your password?"|i18n( "design/ocbootstrap/user/login" )}</a>
</div>
