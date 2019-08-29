{ezscript_require(array(
  "password-score/password-score.js",
  "password-score/password-score-options.js",
  "password-score/bootstrap-strength-meter.js"
))}


<form action={concat($module.functions.password.uri,"/",$userID)|ezurl} method="post" name="Password">
    <div class="row mb-3">

    <div class="col-md-8 offset-md-2">

        <h1>Cambia la password</h1>
        
        {if $message}
            {if or($oldPasswordNotValid,$newPasswordNotMatch,$newPasswordNotValidate,$newPasswordMustDiffer)}
                {if $oldPasswordNotValid}
                    <div class="alert alert-warning">
                        Reinserisci la vecchia password
                    </div>
                {/if}
                {if $newPasswordNotMatch}
                    <div class="alert alert-warning">
                        Controlla le nuove password perché non corrispondono
                    </div>
                {/if}
                {if $newPasswordNotValidate}
                    <div class="alert alert-warning">
                        Password non valida
                    </div>
                {/if}
                {if $newPasswordMustDiffer}
                    <div class="alert alert-warning">
                        La nuova password deve essere diversa dalla vecchia
                    </div>
                {/if}                    
            {else}
                <div class="feedback">
                    {'Password successfully updated.'|i18n('mbpaex/userpaex')}
                </div>
            {/if}
        {/if}
    

        {if $oldPasswordNotValid}*{/if}
        <label>Vecchia password</label>
        <input type="password" class="form-control" name="oldPassword" size="11" value="{$oldPassword}" />


      <div class="row mt-3">
          <div class="col-md-6">
              {if or($newPasswordNotMatch,$newPasswordNotValidate)}*{/if}
              <label>Nuova password</label>
              <input id="pwd-input" type="password" class="form-control" name="newPassword" size="11" value="{$newPassword}" />
              <span id="pwd-text"></span>
          </div>
          <div class="col-md-6">
              {if or($newPasswordNotMatch,$newPasswordNotValidate)}*{/if}
              <label>Ridigita la nuova password</label>
              <input type="password" class="form-control" name="confirmPassword" size="11" value="{$confirmPassword}" />

          </div>
      </div>


      <div class="clearfix mt-3">
          <input class="btn btn-dark float-left" type="submit" name="CancelButton" value="Annulla" />
          <input class="btn btn-primary float-right" type="submit" name="OKButton" value="{'OK'|i18n('mbpaex/userpaex')}" />
      </div>

    </div>

    </div>

</form>

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
        '50': ['text-success', 'Valutazione della complessità: ottima']]
        {rdelim}
      {rdelim});
    {rdelim});
</script>

