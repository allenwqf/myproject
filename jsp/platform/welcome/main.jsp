<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<!--[if lt IE 7 ]><html class="ie ie6"><![endif]-->
<!--[if IE 7 ]><html class="ie ie7"><![endif]-->
<!--[if IE 8 ]><html class="ie ie8"><![endif]-->
<!--[if IE 9 ]><html class="ie ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--><html><!--<![endif]-->
<html>
<head>
	<meta charset="utf-8">
	<meta name="renderer" content="webkit">
	
	<meta name="viewport" content="initial-scale=1,minimum-scale=1" />
	<title>交广领航管理平台</title>
	<c:import url="/public/head-tag.jsp"/>
    <style>
    
		span.logo-name {
		    display: inline-block;
		    position: relative;
		    color: transparent;
		    -webkit-user-select: none;
		}
		
		span.logo-name:after {
		    content: "交广领航管理平台";
		    position: absolute;
		    left: 0;
		    top: 0;
		    width: 100%;
		    height: 100%;
		    color: #3A3A3B;
		}

		
		.sidebar {
		    display: none;
		}
		
		.content {
		    margin: 0;
		}
		.title-logo {
		    text-align: center;
		    padding-top: 100px;
		}
		.title-logo img{
			width:90px;
		}
		.title {
		    font-size: 26px;
		    margin: 5px 0 15px;
		    text-align: center;
		    letter-spacing: 1px;
		    color: #155E6C;
		}
		
		.row {
		    overflow: hidden;
		    text-align: center;
		}
		
		.col-6 {
		    width: 25%;
		    display: inline-block;
		    margin: 10px;
		}
		
		.module {
		    font-size: 46px;
		    text-align: center;
		    letter-spacing: 5px;
		    border-radius: 1px;
		}
		.module img {
		    max-width: 100%;
		    vertical-align: top;
		}
    </style>
</head>
<body>

    <c:import url="/public/header.jsp"/>
    <section class="container">
    
    	<div class="content">
    		<div class="content-main">
    			<div class="title-logo">
    				<img src="/pages/assets/img/logo-150x150.png?v=bf8e9e57c013c3764a94d9bae4136f12" alt="交广领航管理平台" />
    			</div>
				<h1 class="title">交广领航管理平台</h1>
				<div id="showcontent" class="row" data-params=${sessionScope[cookie.token.value].puid }>
					<div  class="col-6 module module-zhibo">
						<a data-action="gozbpt" href="javascript:"><img src="/pages/assets/img/main/zhibo.jpg?v=4bb2527d09ba2c3a1a9d5248aa78cf70" alt="直播平台" /></a>
					</div>
					<div class="col-6 module module-rongmei">
						<a href="/Manager/web/welcome"><img src="/pages/assets/img/main/rongmei.jpg?v=c20bbd5af849e3dca4fe52017ba5e40b" alt="融媒管理" /></a>
					</div>
				</div>
    		</div>
    	</div>
    </section>
    
    <script type="text/template" id="item/show" title="前往绑定">
		<div class="form-row">
			<p style="margin-left: -70px;">您的账号没有绑定app，请前往绑定。<a class="action-link" href="javascript:window.open('/Manager/web/system/user/setting')">去绑定&raquo; </a></p>
			<p style="margin-left: -70px;">完成绑定后请刷新当前页面。  <a class="action-link" href="">刷新&raquo;</a></p>
		</div>
    </script>
    <script>
    if(window.top!=window.self) parent.location.href=location.href;
    </script>
    <script src="/pages/assets/js/require.all.js?v=4293636e2ff5c4a96b189a7661023e42"></script>
    <script>
         requirejs([
             'artDialog',
             'artTemplate'
         ], 
         function(dialog,template){
             var App={
                showDialog:function(){
       				var title="提示";
       				var id="item/show";
       				var content=template(id);
   					var idialog=dialog({
   						id : id,
   						title:title,
   						content:content,
   						button:[
   							{
   								id:"cancel",value:"取消"
   							},
   							{
  								id:"ok",value:"确定",
  								autofocus:true
  							}
   						]
   					})
   					.showModal();
                },
                initListeners:function(){
    	    		var app=this;
					$('body').on('click', '[data-action]', function(e){
						var $this=$(this);
						var action=$this.data("action");
						if(action=="gozbpt"){
							var text=$("#showcontent").data("params");
							if(!text){
								app.showDialog();
							}else{
								location.href="/Manager/web/index#/Manager/web/zbpt/page";
							}
						}
						return false;
					})
				},
             }
             App.initListeners();
         })
    </script>
    </body>
</html>