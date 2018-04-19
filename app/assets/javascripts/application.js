// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require_tree .
function go(cid){
		var httpRequest;
		if (window.XMLHttpRequest) { 
		    httpRequest = new XMLHttpRequest();
		} else if (window.ActiveXObject) { 
		    httpRequest = new ActiveXObject("Microsoft.XMLHTTP");
		}
        httpRequest.onreadystatechange = hello; 
        cid = parseInt(cid);
        cid = cid.toString();
        httpRequest.open('GET', 'https://52.78.7.40:3000/api/community/'+ cid , true);
        console.log(httpRequest.response)
     }
     function hello(){
          console.log("ok!!!")
     } 


