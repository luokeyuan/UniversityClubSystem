function ajaxConn(url,params){  //传入URL地址，以及详细参数对象
	var xmlhttp;
	if (window.XMLHttpRequest){// code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp=new XMLHttpRequest();
	}else{// code for IE6, IE5
		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	}

	xmlhttp.open('post',url,true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	var str = new Array();
	var index = 0;
	for (var s in params){
		str[index] = s + "=" + params[s];
		index++;
	}
	str.join('&');
	xmlhttp.send(str);
	xmlhttp.onreadystatechange = function(){
	    if(xmlhttp.readyState === 4 && xmlhttp.status === 200) {
	        return xmlhttp.responseText;
	    }
	}
}