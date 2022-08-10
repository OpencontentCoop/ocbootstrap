<style>.g-recaptcha div{ldelim}margin: 0{rdelim}</style>
<div class="form-group">
    <div class="g-recaptcha" data-sitekey="{$question.text2}"></div>
    <script type="text/javascript" src="https://www.recaptcha.net/recaptcha/api.js?hl={fetch( 'content', 'locale' ).country_code|downcase}"></script>
</div>