<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!DOCTYPE html>
<html lang="en"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  
  <title>一起去Java管理系统</title>
  <meta name="description" content="particles.js is a lightweight JavaScript library for creating particles.">
  <meta name="author" content="Vincent Garreau">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <link rel="stylesheet" media="screen" href="<%=request.getContextPath()%>/resources/admin/login/css/style.css">
  <link rel="stylesheet" type="text/css" href="../resources/admin/login/css/reset.css">
  
 <script src="<%=request.getContextPath()%>/resources/admin/login/js/jquery-1.8.0.min.js"></script>


<body>
	<div id="particles-js">
			<div class="login" style="display: block;">
				<div class="login-top">
					登录
				</div>
				<div class="login-center clearfix">
					<div class="login-center-img"><img src="../resources/admin/login/images/name.png"></div>
					<div class="login-center-input">
						<input type="text" name="username" id="username" placeholder="请输入您的用户名" onfocus="this.placeholder=&#39;&#39;" onblur="this.placeholder=&#39;请输入您的用户名&#39;">
						<div class="login-center-input-text">用户名</div>
					</div>
				</div>
				<div class="login-center clearfix">
					<div class="login-center-img"><img src="../resources/admin/login/images/password.png"></div>
					<div class="login-center-input">
						<input type="password" name="password" id="password" placeholder="请输入您的密码" onfocus="this.placeholder=&#39;&#39;" onblur="this.placeholder=&#39;请输入您的密码&#39;">
						<div class="login-center-input-text">密码</div>
					</div>
				</div>
				<!-- 验证码 -->
				<div class="login-center clearfix">
					<div class="login-center-img"><img src="<%=request.getContextPath() %>/resources/admin/login/images/yanzhengCode.png"></div>
					<div  class="login-center-input">
						<input type="text"  placeholder="请输入验证码"  name="cpacha" id="cpacha" style="width:50%">
						<div class="login-center-input-text">验证码</div>
					<img id="cpacha-img" title="点击切换验证码" style="cursor:pointer;" src="yanzCode?vl=4&w=150&h=40&type=loginCpacha" width="110px" height="30px" onclick="changeCpacha()">
					</div>
				</div>
				<div id="errorMsg"  class="login-center clearfix" style="color:red;"></div>
				<div class="login-button" >登录</div>
			</div>
	</div>
<script type="text/javascript">
	
	//刷新验证码
	function changeCpacha(){
		$("#cpacha-img").attr("src",'yanzCode?vl=4&w=150&h=40&type=loginCpacha&t=' + new Date().getTime());
	}
	function checkUsername() {
		var username = $("#username").val();
		var reg_username = /^\w{5,6}$/;
	    var flag = reg_username.test(username);
	    if(flag){
            $("#username").css("border","");
            $("#errorMsg").html(" ");
		}else{
			$("#username").css("border","1px solid red");
			$("#errorMsg").html("账号长度有误！");
		}
        return flag;
    }
	function checkPassword() {
		var password = $("#password").val();
		var reg_password = /^\w{1}$/;
	    var flag = reg_password.test(password);
	    if(flag){
            $("#password").css("border","");
            $("#errorMsg").html(" ");
		}else{
			$("#password").css("border","1px solid red");
			$("#errorMsg").html("密码长度有误！");
		}
        return flag;
    }
	//登陆按钮
	document.querySelector(".login-button").onclick = function(){
			var username = $("#username").val();
			var password = $("#password").val();
			var cpacha = $("#cpacha").val();
			if(username == '' || username == 'undefined'){
				alert("请填写用户名！");
				return;
			}
			if(password == '' || password == 'undefined'){
				alert("请填写密码！");
				return;
			}
			if(cpacha == '' || cpacha == 'undefined'){
				alert("请填写验证码！");
				return;
			}
			
			$.ajax({
				url:'login',
				data:{
					username:username,
					password:password,
					cpacha:cpacha
					},
				type:'post',
				dataType:'json',
				success:function(data){
					if(data.type == 'success'){
						window.parent.location = 'index';//跳转到首页
					}else{
						
						alert(data.msg);
						changeCpacha();
					}
				}
			});
			
	}
	
</script>
</body>

</html>					