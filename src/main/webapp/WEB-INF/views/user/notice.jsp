<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>公告详情</title>
	<link rel="icon" href="${APP_PATH}/static/img/stop.ico" type="image/x-icon">
	<link rel="stylesheet" type="text/css" href="${APP_PATH}/static/css/default.css"/>
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
		notice
	 -->
	<div class="mainbody">
		<div class="container clearfix" style="background-color: white">
			<div class="mainbody_topbg"><img src="${APP_PATH}/static/img/mainbody_topbg.gif"/></div>
			<div class="bread">当前位置：
				<a href="userLoginToMain">首页</a> >
				<a>公告</a> >
				<a>公告详情</a>
			</div>
			
			<div class="maincontent" style="width: 100%">
				<div class="post">
					<h2><a>${notice.title }</a></h2>
					<div class="postdata" style="background-image: url(${APP_PATH}/static/img/postdata.png);">
						<div class="date">
						<fmt:formatDate value="${notice.createTime }" pattern="yyyy-MM-dd"/>
						</div>
						<div class="cate"><a href="#">${adminName }</a>&nbsp;&nbsp;&nbsp;&nbsp;发表于<a href="#">&nbsp;&nbsp;&nbsp;通知公告</a></div>
					</div>
					<div class="content">
						<p>${notice.context }</p>
						<br /><br />
						<p style="text-align: right;">
						<fmt:formatDate value="${now }" pattern="yyyy-MM-dd"/>
						</p>
					</div>
				</div>
	
			</div>
			<div class="mainbody_bottombg"><img src="${APP_PATH}/static/img/mainbody_bottombg.gif"/></div>
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
</body>
</html>