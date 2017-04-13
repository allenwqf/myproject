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
	<title>添加角色-角色管理</title>
    <c:import url="/public/head-tag.jsp"/>
    <link rel="stylesheet" href="/pages/assets/js/libs/uploadify/uploadify.css?v=d026d6766434e06351fdda6652a641cd" />
</head>
<body>
	
    <c:import url="/public/header.jsp"/>
    
    <section class="container">
    	
		<c:set var="sidebar" scope="request" value="user"/>
		    <c:set var="navbar" scope="request" value="role"/>
		    <c:import url="/public/sidebar.jsp"/>
		
    	<div class="content">
    		<div class="content-top">
				<h3 class="content-title">
    				<div class="bread">
    					<a href="/car-platform/role/listPage">角色管理</a>
    					<span>&gt;</span>
    					<span>添加角色</span>
    				</div>
    			</h3>
    		</div>
    		<div class="content-main">
    			<div class="block block-main">
    				<div class="block-content">
						<form  action="/car-platform/role/createSave" method="post" goback="/car-platform/role/listPage">
							<div class="form-block">
								<div class="form-row">
									<span class="row-label">英文名称：</span>
									<div class="row-content">
										<input name="ename" type="text" class="text"   ipattern="^.{1,20}$" iname="英文名称"/>
									</div>
								</div>
								<div class="form-row">
									<span class="row-label">中文名称：</span>
									<div class="row-content">
										<input name="zname" type="text" class="text"   ipattern="^.{1,20}$" iname="中文名称"/>
									</div>
								</div>
								<div class="form-row">
									<span class="row-label">角色状态：</span>
									<div class="row-content">
									    <select class="select select-col-1" name="status">
									      <option value="0">禁用</option>
					                      <option value="1"  selected="selected" >正常</option>
								        </select>
									</div>
								</div>
								<div class="form-row">
									<span class="row-label">角色介绍：</span>
									<div class="row-content">
										<textarea name="intro" class="text textarea"></textarea>
									</div>
								</div>
								<div class="form-row form-row-btn">
									<div class="row-content">
										<input type="submit" value="确认提交" class="btn btn-default"/>
									</div>
								</div>
							</div>
						</form>
						
    				</div>
    			</div>

    		</div>
    	</div>
    </section>
   
   <script src="/pages/assets/js/require.all.js?v=4293636e2ff5c4a96b189a7661023e42"></script>
   <script>
        requirejs([
            'artTemplate', 
            'artDialog', 
            
            'vender.modal',
            
            'jquery.formcheck', 
            'jquery.ajaxsubmit',
            'jquery.common',
            'jquery.pager'
        ], 
        function( template, dialog, Modal){
   			var App={
    			alert : function(){
    				alert(arguments[0]);
    			},
   				initEvents:function(){
    				
    				// 添加报名活动报名项目代码
    				var $fields=$("#fields")
    				$("body").on("click","[action]",function(){
    					var $this=$(this);
    					var action=$this.attr("action");
    					if(action=="remove"){
//  						if(itemLength<=2) return;
							var itemLength=$fields.find("li").length;
    						$this.parents("li:first").remove();
    					}
    					else if(action=="add"){
							var itemLength=$fields.find("li").length;
    						if(itemLength >=10 ) return;
    						var tempHTML=template("item/fields",{});
    						$(tempHTML).insertBefore($fields.find("li:last")).find("input:text").focus();
    					}
    				})
    			},
    			
    			initForm:function(){
					$("form").ajaxSubmitify({
						onSuccess:function(result){
							var $this=$(this);
							var code=result.code;
							if(code==200){
								var goback=$this.attr("goback");
								if(goback) location.href=goback;
							}
							else{
								var msg=result.msg || "提交失败！";
								App.alert(msg);
							}
						}
					})
    			},
    			init : function(){
    				this.initEvents();
					this.initForm();
    			}
    		}
    		App.init();
    	})
   </script>
    </body>
</html>