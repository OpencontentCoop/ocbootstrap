<div class="row mb-5">
    <div class="col-md-8 offset-md-2">
        <h1>{"User registered"|i18n("design/ocbootstrap/user/success")}</h1>
        <div class="alert alert-success clearfix">
            {if $verify_user_email}
                {'Your account was successfully created. An email will be sent to the specified address. Follow the instructions in that email to activate your account.'|i18n('design/ocbootstrap/user/success')}
            {else}
                {"Your account was successfully created."|i18n("design/ocbootstrap/user/success")}
                <a class="btn btn-success float-right" href={'/'|ezurl()}>OK</a>
            {/if}
        </div>
    </div>
</div>

