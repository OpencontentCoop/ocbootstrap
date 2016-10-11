{def $settings=$handler.settings}

<div class="checkbox">
    <label>
      <input type="checkbox" name="ReceiveDigest_{$handler.id_string}" {$settings.receive_digest|choose( '', checked)} /> {'Receive all messages combined in one digest'|i18n( 'design/ocbootstrap/notification/handler/ezgeneraldigest/settings/edit' )}
    </label>
</div>

<div class="row">  
  <div class="col-md-4">
    <div class="radio">
      <input type="radio" name="DigestType_{$handler.id_string}" value="3" {eq($settings.digest_type,3)|choose('',checked)} />
      {'Daily, at'|i18n( 'design/ocbootstrap/notification/handler/ezgeneraldigest/settings/edit' )}
    </div>
  </div>
  <div class="col-md-4">      
    <select name="Time_{$handler.id_string}" class="form-control">
    {foreach $handler.available_hours as $time}
      <option value="{$time}" {if eq( $time, $settings.time )}selected="selected"{/if}>{$time}</option>
    {/foreach}
    </select>
  </div>
</div>
<div class="row">  
  <div class="col-md-4">
    <div class="radio">
      <input type="radio" name="DigestType_{$handler.id_string}" value="1" {eq( $settings.digest_type, 1 )|choose( '', checked )} />
      {'Once per week, on '|i18n( 'design/ocbootstrap/notification/handler/ezgeneraldigest/settings/edit' )}
    </div>
  </div>
  <div class="col-md-4">
    <select name="Weekday_{$handler.id_string}"  class="form-control">
    {foreach $handler.all_week_days as $week_day}
      <option value="{$week_day}" {if eq( $week_day, $settings.day )}selected="selected"{/if}>{$week_day}</option>
    {/foreach}
    </select>
  </div>
</div>
<div class="row">  
  <div class="col-md-4">
    <div class="radio">
      <input type="radio" name="DigestType_{$handler.id_string}" value="2" {eq( $settings.digest_type, 2)|choose( '', checked )} />
      {'Once per month, on day number'|i18n( 'design/ocbootstrap/notification/handler/ezgeneraldigest/settings/edit' )}
    </div>
  </div>
  <div class="col-md-4">
    <select name="Monthday_{$handler.id_string}" class="form-control">
    {foreach $handler.all_month_days as $month_day}
      <option value="{$month_day}" {if eq( $month_day, $settings.day )}selected="selected"{/if}>{$month_day}</option>
    {/foreach}
    </select>
  </div>
</div>

<p class="help-block">
  {'If day number is larger than the number of days within the current month, the last day of the current month will be used.'|i18n( 'design/ocbootstrap/notification/handler/ezgeneraldigest/settings/edit' )}
</p>

