'use strict';

(function() {

  var socket = io();
  var oses = [];
  
  socket.on('pageview', onPageView);

  function onPageView(data){
	oses[data.os_name] = oses[data.os_name] || 0
    oses[data.os_name] += 1
    console.log(data.os_name + " " + oses[data.os_name])
    
    var list = document.getElementById("oses")
    var html = ""
    var keys = Object.keys(oses)
    for(var i=0; i<keys.length; i++)
    {
		html += "<h2>" + keys[i] + " = " +oses[keys[i]] + "</h2>"
	}
	list.innerHTML = html;
  }

})();
