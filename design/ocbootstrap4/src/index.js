window.$ = window.jQuery = require('jquery');
require('bootstrap');
import './scss/app.scss';

$(function () {
    $('[data-toggle="tooltip"]').tooltip()
});