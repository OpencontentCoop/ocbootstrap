<div class="row mb-5">
    <div class="col-md-8 offset-md-2">
        <form action={concat($module.functions.password.uri,"/",$userID)|ezurl} method="post" name="Password">
            <h1>{"Change password for user"|i18n("design/ocbootstrap/user/password")} {$userAccount.login}</h1>
            {if $message}
                {if or( $oldPasswordNotValid, $newPasswordNotMatch, $newPasswordTooShort )}
                    {if $oldPasswordNotValid}
                        <div class="alert alert-warning">
                            {'Please retype your old password.'|i18n('design/ocbootstrap/user/password')}
                        </div>
                    {/if}
                    {if $newPasswordNotMatch}
                        <div class="alert alert-warning">
                            {"Password didn't match, please retype your new password."|i18n('design/ocbootstrap/user/password')}
                        </div>
                    {/if}
                    {if $newPasswordTooShort}
                        <div class="alert alert-warning">
                            {"The new password must be at least %1 characters long, please retype your new password."|i18n( 'design/ocbootstrap/user/password','',array( ezini('UserSettings','MinPasswordLength') ) )}
                        </div>
                    {/if}

                {else}
                    <div class="alert alert-success">
                        {'Password successfully updated.'|i18n('design/ocbootstrap/user/password')}
                    </div>
                {/if}
            {/if}

            <div class="form-group">
                <label>{"Old password"|i18n("design/ocbootstrap/user/password")}</label>
                <input class="form-control" type="password" name="oldPassword" size="11" value="{$oldPassword|wash}"/>
            </div>

            <div class="form-group">
                <label>{"New password"|i18n("design/ocbootstrap/user/password")}</label>
                <input class="form-control" autocomplete="off" type="password" name="newPassword" size="11"
                       value="{$newPassword|wash}"/>
            </div>

            <div class="form-group">
                <label>{"Retype password"|i18n("design/ocbootstrap/user/password")}</label>
                <input class="form-control" autocomplete="off" type="password" name="confirmPassword" size="11"
                       value="{$confirmPassword|wash}"/>
            </div>

            <div class="clearfix">
                <input class="btn btn-success float-right" type="submit" name="OKButton"
                       value="{'OK'|i18n('design/ocbootstrap/user/password')}"/>
                <input class="btn btn-dark float-left" type="submit" name="CancelButton"
                       value="{'Cancel'|i18n('design/ocbootstrap/user/password')}"/>
            </div>
        </form>
    </div>
</div>

