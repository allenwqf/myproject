<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<!--[if lt IE 7 ]><html class="ie ie6"><![endif]-->
<!--[if IE 7 ]><html class="ie ie7"><![endif]-->
<!--[if IE 8 ]><html class="ie ie8"><![endif]-->
<!--[if IE 9 ]><html class="ie ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--><html><!--<![endif]-->
<head>
	<meta charset="utf-8">
	<meta name="renderer" content="webkit">
  
	<meta name="viewport" content="initial-scale=1,minimum-scale=1" />
	<title>交广领航车生活运营管理平台</title>
    <c:set var="appRoot" value="../../" />
	<c:import url="/public/head-tag.jsp" />
    <style>
		.welcome {
		    font-size: 28px;
		    margin: 200px 0;
		    text-align: center;
		    letter-spacing: 5px;
		    display:none;
		}
    </style>
    </head>
<body>
	
    <c:import url="/public/header.jsp"/>
    
    <section class="container">
    	
	    <c:set var="sidebar" scope="request" value="welcome"/>
	    <c:set var="navbar" scope="request" value="welcome"/>
	    <c:import url="/public/sidebar.jsp"/>
		
    	<div class="content">
    		<div class="content-main">
    			<div class="block block-main">
    				<div class="block-content">
						<h3 class="welcome" id="speak"></h3>
    				</div>
    			</div>

    		</div>
    	</div>
    </section>
    <script>
    function getWord(hour){
    	var word = '';
    	if(hour==4) word='好早呀'
    	if(hour>=5) word='早上好'
    	if(hour>=8) word='上午好'
    	if(hour==12) word='中午好'
    	if(hour>12) word='下午好'
    	if(hour>=20) word='晚上好'
    	if(hour>23 || hour<4) word='这么晚了，还没睡觉？'
    	return word
    }
    $('#speak').html(getWord(new Date().getHours())+', ' + '欢迎进入车生活运营管理平台！').fadeIn(1000)
    </script>
    </body>
</html>