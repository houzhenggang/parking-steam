<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>用户登录页面</title>
	<link rel="icon" href="${APP_PATH}/static/img/stop.ico" type="image/x-icon">
	<link rel="stylesheet" href="${APP_PATH}/static/css/style1.css" />
</head>
<body>
	<div class="main">
		<div class="w3layouts_main agileinfo w3"">
			<div class="w3_agile_signup_form agileits">
				<h1 class="w3_agileits w3ls" style="margin-top: 60px;">登录</h1>
				<div class="agile_login_form">
					<form action="" method="post" id="loginForm" class="agileits_w3layouts_form" style="margin: 0 auto;">
						<input type="text" name="account" id="account" placeholder="用户名称" autocomplete="off">
						<input type="password" name="password" id="password" placeholder="密码" autocomplete="off"> 
						<input type="button" id="loginBtn" value="登录">
					</form>
				</div>
				<div>
					<a class="toSignUp" href="toSignUp">去注册</a>
				</div>
			</div>
		</div>
		<div class="agileits_copyright w3l">
			<p>© 2018 什么冬梅停车系统</p>
		</div>
	</div>
	<script src="${APP_PATH}/static/js/jquery.min.js"></script>
	<script type="text/javascript">
		$(function(){
			$("#loginBtn").on("click",function(){
				var account = $("#account").val();
				var password = $("#password").val();
				$.ajax({
					url:"checkUserLogin",
					type:"post",
					data:{"account":account,"password":password},
					success:function(data){
						console.log(data);
						if(data.code == 5){
							alert(data.msg);
							window.location.href = "userLoginToMain";
						}
						else{
							alert(data.msg);
						}
					},
					error:function(){
						alert("验证失败！");
					}
				});
			});
		});
	</script>
</body>
</html>