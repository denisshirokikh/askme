//= require jquery
//= require jquery_ujs
//= require_tree .

// Этот код добавляет обработчик события выдвигания формы при клике на кнопку
// «Задать вопрос», которая видна только, когда страница открыта в маленьком
// окне.
$(function(){
    $('#ask-button').click(function(){
        $('#ask-form').slideToggle(300);
        return false;
    });
});
