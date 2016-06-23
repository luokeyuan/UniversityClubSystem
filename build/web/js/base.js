window.onload=function(){
	var log=document.getElementById('login');
	var reg=document.getElementById('register');
	var log_panel=document.getElementById('log-panel');
	var reg_panel=document.getElementById('reg-panel');

	log.onclick=function(){
		log_panel.style.display='block';
		reg_panel.style.display='none';
		this.style.backgroundColor="#87D6B4";
		reg.style.background="none";
	}
	reg.onclick=function(){
		reg_panel.style.display="block";
		log_panel.style.display="none";
		this.style.backgroundColor="#87D6B4";
		log.style.background="none";
	}

	var log_user=document.getElementById('log-user');
	var log_pwd=document.getElementById('log-password');
	var log_user_msg=document.getElementById('user-msg');
	var log_pwd_msg=document.getElementById('pwd-msg');
	var log_submit=document.getElementById('login-sub');

	var reg_user=document.getElementById('reg-username');
	var reg_pwd=document.getElementById('reg-password');
	var pwd_conf=document.getElementById('reg-password1');
	var reg_user_msg=document.getElementById('user-exist');
	var reg_pwd_msg=document.getElementById('pwd-confirm');
	var reg_submit=document.getElementById('register-sub');

	var user_type=document.getElementsByName('usertype');
		
	var typevalue;

	//判断登录用户名是否存在
	log_submit.onclick=function(){

		//获取单选框的值
		var value;
		for (var i = user_type.length - 1; i >= 0; i--) {
			if(user_type[i].checked){
				value=user_type[i].value
			}
		}

		//判断登录用户名、密码是否为空
		if(log_user.value==""){
			log_user_msg.innerHTML="<i></i>请输入用户名";
			log_user_msg.style.display="block";
			log_user.focus();
		}else if(log_pwd.value==""){
			log_pwd_msg.innerHTML="<i></i>请输入密码";
			log_pwd_msg.style.display="block";
			log_pwd.focus();
		}else{
			var xmlhttp;
			if (window.XMLHttpRequest){// code for IE7+, Firefox, Chrome, Opera, Safari
				xmlhttp=new XMLHttpRequest();
			}else{// code for IE6, IE5
				xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
			}

			xmlhttp.open('post','log_isset.jsp',true);
			xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			var str="log_name="+log_user.value+"&log_pwd="+log_pwd.value+"&log_type="+value;
			xmlhttp.send(str);
			xmlhttp.onreadystatechange=function(){
				if(xmlhttp.readyState===4){
					if (xmlhttp.status===200) {
						var s=xmlhttp.responseText;
						if(s==0){
							log_user_msg.innerHTML="<i></i>用户名与密码不匹配";
							log_user_msg.style.display="block";
							clearForm();
							log_user.focus();
						}
						if(s==1){
							window.open('main.jsp','_self');
						}
						if(s==2){
							window.open('manager.jsp','_self');
						}
					}
				}
			}
		}
			
	}

	function clearForm(){
		log_user.value="";
		log_pwd.value="";
	}


	//判断注册用户名、密码是否为空


	//判断注册用户名是否存在
	reg_submit.onclick=function(){
		//判断注册用户名、密码是否为空
		if(reg_user.value==""){
			reg_user_msg.innerHTML="<i></i>请填写用户名";
			reg_user_msg.style.display="block";
			reg_user.focus();
		}else if(reg_pwd.value==""){
			reg_pwd_msg.innerHTML="<i></i>请输填写密码";
			reg_pwd_msg.style.display="block";
			reg_pwd.focus();
		}else if(reg_pwd.value!=pwd_conf.value){ //判断注册页面密码是否一致
			reg_pwd_msg.innerHTML="<i></i>两次输入密码不一致！";
			reg_pwd_msg.style.display="block";
			pwd_conf.focus();
		}else{
			var xmlhttp;
			if (window.XMLHttpRequest){// code for IE7+, Firefox, Chrome, Opera, Safari
				xmlhttp=new XMLHttpRequest();
			}else{// code for IE6, IE5
				xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
			}

			xmlhttp.open('post','reg_isset.jsp',true);
			xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
			var str="reg_name="+reg_user.value+"&reg_pwd="+reg_pwd.value;
			xmlhttp.send(str);
			xmlhttp.onreadystatechange=function(){
				if(xmlhttp.readyState===4){
					if (xmlhttp.status===200) {
						var s=xmlhttp.responseText;
						if(s==0){
							window.open('regsucces.jsp','_self');
						}
						if(s==1){
							reg_user_msg.innerHTML="<i></i>该用户名已被注册！";
							reg_user_msg.style.display="block";
							reg_user.focus();
							clearpassword();
						}
					}
				}
			}
		}
	}


	function clearpassword(){
		reg_pwd.value="";
		pwd_conf.value="";
	}

	//键盘键入，清除警告信息
	log_user.onkeyup=function(){
		log_user_msg.style.display="none";
	}
	log_pwd.onkeyup=function(){
		log_pwd_msg.style.display="none";
	}
	reg_user.onkeyup=function(){
		reg_user_msg.style.display="none";
	}
	reg_pwd.onkeyup=function(){
		reg_pwd_msg.style.display="none";
	}
	pwd_conf.onkeyup=function(){
		reg_pwd_msg.style.display="none";
	}

}