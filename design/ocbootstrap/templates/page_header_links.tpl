<ul class="nav nav-pills">
{if $current_user.is_logged_in}
    <li id="myprofile"><a href={"/user/edit/"|ezurl} title="{'My profile'|i18n('design/ocbootstrap/pagelayout')}">{'My profile'|i18n('design/ocbootstrap/pagelayout')}</a></li>
    <li id="logout"><a href={"/user/logout"|ezurl} title="{'Logout'|i18n('design/ocbootstrap/pagelayout')}">{'Logout'|i18n('design/ocbootstrap/pagelayout')} ( {$current_user.contentobject.name|wash} )</a></li>
{else}
    {if ezmodule( 'user/register' )}
    <li id="registeruser"><a href={"/user/register"|ezurl} title="{'Register'|i18n('design/ocbootstrap/pagelayout')}">{'Register'|i18n('design/ocbootstrap/pagelayout')}</a></li>
    {/if}
    <li id="login" class="dropdown">
      <a href="#" title="hide login form" class="dropdown-toggle" data-toggle="dropdown">{'Login'|i18n('design/ocbootstrap/pagelayout')}</a>
      <form class="login-form dropdown-menu" action="{'/user/login'|ezurl( 'no' )}" method="post">
          <fieldset>
              <label>
                  <span class="hidden">{'Username'|i18n('design/ocbootstrap/pagelayout')}</span>
                  <input type="text" name="Login" id="login-username" placeholder="Username">
              </label>
              <label>
                  <span class="hidden">{'Password'|i18n('design/ocbootstrap/pagelayout')}</span>
                  <input type="password" name="Password" id="login-password" placeholder="Password">
              </label>
              <div class="clearfix">
                  <a href="{'/user/forgotpassword'|ezurl( 'no' )}" class="forgot-password">{'Forgot your password?'|i18n('design/ocbootstrap/pagelayout')}</a>
                  <button class="btn btn-warning pull-right" type="submit">
                      {'Login'|i18n('design/ocbootstrap/pagelayout')}
                  </button>
              </div>
          </fieldset>
          <input type="hidden" name="RedirectURI" value="" />
      </form>
    </li>
{/if}
</ul>
