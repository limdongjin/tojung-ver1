# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
function comma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}
var i = 0
while( i< $(".f_money").length){
  var money=$(".f_money")[i].innerHTML;
  var newMoney=comma(money);
  $(".f_money")[i].innerHTML=newMoney;
  i+=1;
}
