{ezscript_require(array(
  "password-score/password-score.js",
  "password-score/password-score-options.js",
  "password-score/bootstrap-strength-meter.js"
))}

<div class="row mb-5">
    <div class="col-md-6 offset-md-3">

{if $link}
    <div class="alert alert-info text-center">
        <i class="fa fa-envelope-o fa-5x"></i>
        <p>
            {"A mail has been sent to the following email address: %1. This email contains a link you need to click so that we can confirm that the correct user is getting the new password."|i18n('mbpaex/userpaex/forgotpassword',,array($email))}
        </p>
    </div>
{else}
    {if $wrong_email}
        <div class="alert alert-warning">
            {"There is no registered user with that email address."|i18n('mbpaex/userpaex/forgotpassword')}
        </div>
    {/if}
    {if $password_form}
        {if $password_changed}
            <div class="alert alert-success">
                {"The password has been changed successfully."|i18n('mbpaex/userpaex/forgotpassword')}
            </div>
            <a class="btn btn-success float-right" href={"/"|ezurl(no)}>OK</a>
        {else}
            <form method="post" name="forgotpassword" action={concat("/userpaex/forgotpassword/",$HashKey)|ezurl}>
                <h1>{"Choose a new password"|i18n('mbpaex/userpaex/forgotpassword')}</h1>

                <div class="alert alert-info">
                    {"Enter your desired new password in the form below."|i18n('mbpaex/userpaex/forgotpassword')}
                </div>

                {if $newPasswordNotMatch}
                    <div class="alert alert-warning">
                        {"The passwords do not match. Please, be sure to enter the same password in both fields."|i18n('mbpaex/userpaex/forgotpassword')}
                    </div>
                {/if}
                {if $newPasswordNotValidate}
                    <div class="alert alert-warning">
                        {"The new password is invalid, please choose new one."|i18n('mbpaex/userpaex/forgotpassword')}
                    </div>
                {/if}
                {if $newPasswordMustDiffer}
                    <div class="alert alert-warning">
                        {"New password must be different from the old one. Please choose another password."|i18n('mbpaex/userpaex')}
                    </div>
                {/if}

                <div class="form-group">
                    <label for="password">{"Password"|i18n('mbpaex/userpaex/forgotpassword')}:</label>
                    <input id="pwd-input" class="form-control" type="password" name="NewPassword" size="20" value="" />
                    <span id="pwd-text"></span>
                </div>

                <div class="form-group">
                    <label for="password">{"Password Confirm"|i18n('mbpaex/userpaex/forgotpassword')}:</label>
                    <input class="form-control" type="password" name="NewPasswordConfirm" size="20" value="" />
                </div>

                
                <div class="clearfix">
                    <input class="btn btn-primary pull-right" type="submit" name="ChangePasswdButton" value="{'Change password'|i18n('mbpaex/userpaex/forgotpassword')}" />
                    <input type="hidden" name="HashKey" value="{$HashKey}" />
                </div>
            </form>
        {/if}
    {else}
        {if $wrong_key}
            <div class="alert alert-warning">
                {"The key is invalid or has been used. "|i18n('mbpaex/userpaex/forgotpassword')}
            </div>
        {else}
            <form method="post" name="forgotpassword" action={"/userpaex/forgotpassword/"|ezurl}>
                <h1>{"Have you forgotten your password?"|i18n('mbpaex/userpaex/forgotpassword')}</h1>
                <div class="alert alert-info">
                    <p>
                        {"If you have forgotten your password we can generate a new one for you. All you need to do is to enter your email address and we will create a new password for you."|i18n('mbpaex/userpaex/forgotpassword')}
                    </p>
                </div>


                <div class="input-group mb-3">
                        <input class="form-control" placeholder="{"Email"|i18n('mbpaex/userpaex/forgotpassword')}" type="text" name="UserEmail" size="40" value="{$wrong_email|wash}" />
                    <div class="input-group-append">
                        <input class="btn btn-primary" type="submit" name="GenerateButton" value="{'Generate new password'|i18n('mbpaex/userpaex/forgotpassword')}" />
                    </div>
                </div>
            </form>
        {/if}
    {/if}
{/if}
<script type="text/javascript">
  $(document).ready(function() {ldelim}
    $('#pwd-input').strengthMeter('text', {ldelim}
      container: $('#pwd-text'),
      hierarchy: {ldelim}
        '0':  ['text-danger', 'Valutazione della complessità: pessima'],
        '10': ['text-danger', 'Valutazione della complessità: molto debole'],
        '20': ['text-warning', 'Valutazione della complessità: debole'],
        '30': ['text-info', 'Valutazione della complessità: buona'],
        '40': ['text-success', 'Valutazione della complessità: molto buona'],
        '50': ['text-success', 'Valutazione della complessità: ottima']
        {rdelim}
      {rdelim});
    {rdelim});
</script>
    </div>
</div>
