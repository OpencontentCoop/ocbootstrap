<form action={concat($module.functions.edit.uri,"/",$userID)|ezurl} method="post" name="Edit">
    <h1>{"User profile"|i18n("design/ocbootstrap/user/edit")}</h1>

    <div class="row mb-5">
        <div class="col">
            <dl class="row">
                <dt class="col-sm-3">{"Username"|i18n("design/ocbootstrap/user/edit")}</dt>
                <dd class="col-sm-9">{$userAccount.login|wash}</dd>
                <dt class="col-sm-3">{"Email"|i18n("design/ocbootstrap/user/edit")}</dt>
                <dd class="col-sm-9">{$userAccount.email|wash(email)}</dd>
                <dt class="col-sm-3">{"Name"|i18n("design/ocbootstrap/user/edit")}</dt>
                <dd class="col-sm-9">{$userAccount.contentobject.name|wash}</dd>
            </dl>

            <input class="btn btn-warning" type="submit" name="EditButton"
                   value="{'Edit profile'|i18n('design/ocbootstrap/user/edit')}"/>
            {if ezmodule( 'userpaex' )}
                <a class="btn btn-info"
                   href="{concat("userpaex/password/",$userID)|ezurl(no)}">{'Change password'|i18n('design/ocbootstrap/user/edit')}</a>
            {else}
                <input class="btn btn-info" type="submit" name="ChangePasswordButton"
                       value="{'Change password'|i18n('design/ocbootstrap/user/edit')}"/>
            {/if}
        </div>
        <div class="col">
            <div class="list-group">
                {if fetch( 'user', 'has_access_to', hash( 'module', 'content','function', 'edit' ) )}
                    <a class="list-group-item list-group-item-action" href={"content/draft"|ezurl}>{"My drafts"|i18n("design/ocbootstrap/user/edit")}</a>
                {/if}
                {if fetch( 'user', 'has_access_to', hash( 'module', 'shop','function', 'administrate' ) )}
                    <a class="list-group-item list-group-item-action" href={concat("/shop/customerorderview/", $userID, "/", $userAccount.email)|ezurl}>{"My orders"|i18n("design/ocbootstrap/user/edit")}</a>
                {/if}
                {if fetch( 'user', 'has_access_to', hash( 'module', 'content','function', 'pendinglist' ) )}
                    <a class="list-group-item list-group-item-action" href={"/content/pendinglist"|ezurl}>{"My pending items"|i18n("design/ocbootstrap/user/edit")}</a>
                {/if}
                {if fetch( 'user', 'has_access_to', hash( 'module', 'notification','function', 'use' ) )}
                    <a class="list-group-item list-group-item-action" href={"notification/settings"|ezurl}>{"My notification settings"|i18n("design/ocbootstrap/user/edit")}</a>
                {/if}
                {if fetch( 'user', 'has_access_to', hash( 'module', 'shop','function', 'buy' ) )}
                    <a class="list-group-item list-group-item-action" href={"/shop/wishlist"|ezurl}>{"My wish list"|i18n("design/ocbootstrap/user/edit")}</a>
                {/if}
            </div>
        </div>
    </div>
</form>
