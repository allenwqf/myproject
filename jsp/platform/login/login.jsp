<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
	<meta charset="utf-8">
	
	<meta name="viewport" content="initial-scale=1,minimum-scale=1" />
	<title>交广领航车生活运营平台</title>
	<link rel="shortcut icon" href="/pages/assets/img/favicon.ico" type="image/x-icon">
	<link rel="stylesheet" href="/pages/assets/css/global-2016.css" />
	<link rel="stylesheet" href="/pages/assets/css/login.css" />
	<script src="/pages/assets/js/global.js"></script>	
	<!--[if lt IE 9]>
	  <script src="/pages/assets/js/libs/html5shiv.min.js"></script>
	  <script src="/pages/assets/js/libs/respond.min.js"></script>
	<![endif]-->
	<style>
		/*选项卡样式*/
		.listify-select{
			border-right:0;
		}
		.listify-select li {
			position: relative;
		}
		.listify-select li:after {
			content: "";
			width: 1px;
			height: 100%;
			position: absolute;
			right: 0;
			top: 0;
			background: #5BAFBF;
		}
		
		.form-block-wrapper {
		    border: 1px solid #E4E4E4;
		    border-radius: 2px;
		}
		.ie-warn {
		    text-align: center;
		    padding: 5px;
		    background: rgba(245, 225, 115, 0.98);
		    border-bottom: 1px solid #FFD700;
		    font-size: 14px;
		    color: #DE1818;
		    position: static;
		}
	</style>
	<script>
	if(window.top!=window.self) window.parent.location.replace(location.href);
	</script>
</head>
<body>
	<div class="tip tip-show tip-warn ie-warn ie-warn" style="display:none" id="ie-warn">
		您使用的浏览器有些过时，某些功能可能无法正常使用，建议使用现代浏览器！如<a  target="_blank"  href="http://cn.bing.com/search?q=%E8%B0%B7%E6%AD%8C%E6%B5%8F%E8%A7%88%E5%99%A8">谷歌浏览器</a>或<a target="_blank" href="http://chrome.360.cn/">360极速浏览器</a>
	</div>
    <section class="container">
    
		
    	<div class="content">
	    	<div class="content-head align-center">
	    		<img class="thelogo" src="/pages/assets/img/logo-150x150.png" alt="交广领航融媒管理平台" />
	    		<h3 class="head-title">交广领航车生活运营平台</h3>
	    	</div>
	    	
	    	<form action="<%=request.getContextPath()%>/web/login" method="post" goback="<%=request.getContextPath()%>/web/welcome" autocomplate="off">
	    		<div class="form-block-wrapper">
			    	<div class="form-block form-block-inline form-theme2">
						<div class="form-row">
							<span class="row-label">账户名：</span>
							<div class="row-content">
								<input type="text" class="text" iname="账户名" placeholder="账户名" name="username" />
							</div>
						</div>
						
						<div class="form-row">
							<span class="row-label">登录密码：</span>
							<div class="row-content">
								<input type="password" class="text" iname="登录密码" placeholder="登录密码" name="password" />
							</div>
						</div>
						
						<!--需要时显示，否则不显示-->
						<!--<div class="form-row">
							<span class="row-label">验证码：</span>
							<div class="row-content">
								<input type="text text-captcha" id="captcha-input" class="text" iname="验证码" placeholder="请输入验证码" name="captcha" />
								<p class="captcha">
									<img id="captcha" alt="点击刷新验证码" data-target="#captcha-input" width=100 height=30 data-src="https://omeo.alipay.com/service/checkcode?sessionID=182c2cf5b05bfb86afef50d19b395304" />
								</p>
							</div>
						</div>-->
						
						<div class="form-row form-row-btn">
							<div class="row-content">
								<input type="checkbox" id="remLogin" name="remLogin" value="1"/>
								<label for="remLogin">自动登录</label>
								<a class="findpwd fn-right fn-hide" href="#">密码忘了？</a>
							</div>
						</div>
						
						<div class="form-row form-row-btn">
							<div class="row-content">
								<button class="btn btn-large btn-default btn-login">登录</button>
							</div>
						</div>
			    	</div>
	    		</div>
	    	</form>
    	</div>
    </section>
    
   <script src="/pages/assets/js/libs/form/jquery.formCheck.js"></script>
   <script src="/pages/assets/js/libs/form/jquery.ajaxSubmit.js"></script>
   <script>
   	$(function(){
   		//Operation general 
		$.extend($.fn,{
			listifySelect:function(options){
				
				var settings=$.extend({
					containerClass:'listify-select',
					activeClass:'listify-select-active',
					onChange:$.noop
				},options)
				
				return this.each(function(){
					var $select=$(this);
					var $ul=$('<ul>').addClass(settings.containerClass);
					var $options=$select.children();
					$options.each(function(i){
						var $self=$(this);
						var value=$self.attr("value");
						var text=$self.text().replace(/\s/g,"");
						var $item=$('<li>').append($('<a>').text(text).attr({
							'href':'#',
							'hidefocus':true
						}).data('value',value))
						if($self.is(":selected")) $item.addClass(settings.activeClass);
						$ul.append($item);
					})
					
					$select.hide();
					$ul.insertBefore($select);
					
					$ul.on("click","a",function(e){
						e.preventDefault();
						var $target=$(this);
						var value=$target.data("value");
						$ul.find("."+settings.activeClass).removeClass(settings.activeClass);
						$target.parent().addClass(settings.activeClass);
						$select.val(value).trigger("change");
						settings.onChange.call($select);
					})
				})
			},
			captcha:function(){
	   			return this.each(function(){
	   				var $this=$(this);
	   				var $target=$($this.data("target"));
	   				$this.on("click",function(e,focus){
	   					var src=$this.data("src");
	   					$this.attr("src",[src,Math.random()].join("&"))
	   					$target.empty();
	   					if(focus!==false) $target.focus();
	   				})
	   				.trigger("click",false)
	   			})
	   		}
		})
		
		$("form").ajaxSubmitify()
		
   		$("#captcha").captcha();
		
		(function checkIE(){
			var isIE = /MSIE/.test(navigator.userAgent)
			if(isIE) $('#ie-warn').show();
		}())
   	})
    </script>
    </body>
</html>
