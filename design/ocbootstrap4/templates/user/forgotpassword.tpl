<div class="row mb-5">
    <div class="col-md-6 offset-md-3">
        {if $link}
            <div class="alert alert-success">
                {"An email has been sent to the following address: %1. It contains a link you need to click so that we can confirm that the correct user has received the new password."|i18n('design/ocbootstrap/user/forgotpassword',,array($email))}
            </div>
        {else}
            {if $wrong_email}
                <div class="alert alert-danger">
                    {"There is no registered user with that email address."|i18n('design/ocbootstrap/user/forgotpassword')}
                </div>
            {/if}

            {if $generated}
                <div class="alert alert-success">
                    {"Password was successfully generated and sent to: %1"|i18n('design/ocbootstrap/user/forgotpassword',,array($email))}
                </div>
                <a class="btn btn-success float-right" href={"/"|ezurl(no)}>OK</a>
            {else}
                {if $wrong_key}
                    <div class="alert alert-danger">
                        {"The key is invalid or has been used. "|i18n('design/ocbootstrap/user/forgotpassword')}
                    </div>
                    <a class="btn btn-danger float-right" href={"/"|ezurl(no)}>Indietro</a>
                {else}
                    <form method="post" name="forgotpassword" action={"/user/forgotpassword/"|ezurl}>

                        <h1 class="long">{"Have you forgotten your password?"|i18n('design/ocbootstrap/user/forgotpassword')}</h1>
                        <p>{"If you have forgotten your password, enter your email address and we will create a new password and send it to you."|i18n('design/ocbootstrap/user/forgotpassword')}</p>

                        <div class="input-group mb-3">

                            <input autocomplete="off"
                                   placeholder="{"Email"|i18n('design/ocbootstrap/user/forgotpassword')}"
                                   class="form-control" type="text" name="UserEmail" size="40"
                                   value="{$wrong_email|wash}"/>

                            <div class="input-group-append">
                                <input class="btn btn-primary btn-block" type="submit" name="GenerateButton"
                                       value="{'Generate new password'|i18n('design/ocbootstrap/user/forgotpassword')}"/>
                            </div>

                        </div>

                    </form>
                {/if}
            {/if}
        {/if}
    </div>
</div>

