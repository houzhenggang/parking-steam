<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>车位详情</title>
	<link rel="icon" href="${APP_PATH}/static/img/stop.ico" type="image/x-icon">
	<link rel="stylesheet" type="text/css" href="${APP_PATH}/static/css/default.css"/>
	<link rel="stylesheet" type="text/css" href="${APP_PATH}/static/css/parkingdetail.css"/>
	<link rel="stylesheet" type="text/css" href="${APP_PATH}/static/css/SearchInfoWindow_min.css"/>
</head>
<body>
	<!--
        	作者：offline
        	时间：2018-07-17
        	描述：top
        -->
	<div class="top" id="item4">
		<div class="container clearfix">
			<ul class="fr clearfix">
			 <c:choose>
			    <c:when test="${userObj==null }">
				<li><a class="a_login" href="toUserLogin" title="登录">登录</a></li>
				</c:when>
				<c:otherwise>
				<li><a class="a_account" href="">${userObj.getAccount() }</a></li>
				<li><a class="a_logout" href="logout" onclick="alert('注销成功！');">退出登录</a></li>
				<li><a class="a_personal" href="usercenter/showOrder">个人中心</a></li>
				</c:otherwise>
			</c:choose>
			</ul>
		</div>
	</div>
	
	<!--
        	作者：offline
        	时间：2018-07-17
        	描述：header
        -->
	<div class="header">
		<div class="container clearfix">
			<div class="logo fl">
				<a href="userLoginToMain"> <img src="${APP_PATH}/static/img/logo.png"
					alt="什么冬梅" />
				</a>
			</div>
			<div class="mm fr clearfix">
				<a href="carSelect">查车位</a>
			</div>
		</div>
	</div>
	<!--
        	作者：offline
        	时间：2018-07-18
        	描述：detailmain
        -->
	<div class="detail-main">
		<div class="container clearfix">
			<div class="bread">
				当前位置： <a href="userLoginToMain">首页</a> > <a href="#">车位详情</a>
			</div>
			<div class="main-left fl clearfix">
				<div class="zoom-wrap fl" style="width: 60%">
				     <input type="text" value="${lotList.address }" id="text">  
   					 <input type="button" value="搜索" id="btn">
					 <div id="allmap"></div>
				</div>
				<div class="attr fl" style="width: 300px">
					<p>
						车位编号：<span>${lotList.number }</span>
					</p>
					<p>
						价格：<span>￥${lotList.price }</span>
					</p>
					<p>
						路线推介：<span>进入停车场后直行${lotList.id+10}米，左转弯行驶${lotList.id }米</span>
					</p>
					<p>
						<a class="pay" href="" id="appointmentBtn">立即预约</a>
					</p>
				</div>
				<div class="clearfix"></div>
			</div>

		</div>
	</div>

	<!--
        	作者：offline
        	时间：2018-07-17
        	描述：footer
        -->
	<div class="footer">
		<div class="container">
			<div class="zhinan">
				<ul class="clearfix">
					<li class="item-li">关于我们
						<ul>
							<li><a href="#">联系我们</a></li>
							<li><a href="#">网站公告</a></li>
						</ul>
					</li>
					<li class="item-li">新手指南
						<ul>
							<li><a href="#">如何买票</a></li>
							<li><a href="#">修改密码</a></li>
						</ul>
					</li>
					<li class="item-li">配送方式
						<ul>
							<li><a href="#">配送范围</a></li>
							<li><a href="#">配送时间</a></li>
						</ul>
					</li>
					<li class="item-li">售后服务
						<ul>
							<li><a href="#">退票申请</a></li>
							<li><a href="#">改签申请</a></li>
						</ul>
					</li>
				</ul>
			</div>

			<div class="bottom">
				<p>友情链接：百度</p>
				<p>本站所有信息均为用户自由发布，本站不对信息的真实性负任何责任，交易时请注意识别信息的真假如有网站内容侵害了您的权益请联系我们删除</p>
				<p>Copyright &copy;1956-2018 什么冬梅停车系统.</p>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="${APP_PATH}/static/js/jquery.min.js"></script>
	<script src="http://map.qq.com/api/js?v=2.exp&key=7LVBZ-LDH3S-PXSOG-6XRG5-APHYH-JVBIS"></script>
	<script type="text/javascript" src="${APP_PATH}/static/js/parkingdetail.js"></script>
	<script type="text/javascript">
		$(function(){
			$("#appointmentBtn").on("click",function(){
				var userObj = '${userObj}';
				var lotId = '${lotId}';
				if(userObj == ''){
					alert("请先登录！");
					$(this).attr("href","");
				}
				else{
					$(this).attr("href","usercenter/toShowOrder?lotId="+lotId);
				}
			});
		});	
	</script>
</body>
</html>