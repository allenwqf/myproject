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
	<title>访问日志</title>
	<c:set var="appRoot" value="../../" />
	<c:import url="/public/head-tag.jsp"/>
	<style type="text/css">
		.menustyle{
			width: 100px;
		}
		.contentstyle{
			padding-left: 50px;
		}
		.a-padding{
			padding-left: 20px;
		}
	</style>
</head>
<body>

    <c:import url="/public/header.jsp"/>
    
    <section class="container" id="app">
    
		<c:set var="sidebar" scope="request" value="accesslog"/>
		<c:set var="navbar" scope="request" value="detail"/>
		<c:import url="/public/sidebar.jsp"/>
		
    	<div class="content">
    		<div class="content-top">
    			<h3 class="content-title">
    				<div class="bread">
    					<a href="/car-platform/log/listPage">访问日志</a>
    					<span>&gt;</span>
    					<span>详情</span>
    				</div>
    			</h3>
    		</div>
    		<div class="content-main">
    			<div class="block block-main">
					<div v-if="!editing" class="block-content loading">
						loading...
					</div>
					<template v-else>
    				<div class="block-content" >
						<form method="post">
							<div class="form-block">
								
								<div class="form-row">
									<span class="row-label menustyle">访问时间：</span>
									<div class="row-content contentstyle">
	                                 	<div class="row-value">
	                                 		<p v-text="formatDate(form.createDate)"></p>
	                                 	</div>
	                                 </div>
								</div>

								<div class="form-row">
									<span class="row-label menustyle">访问人用户名：</span>
									<div class="row-content contentstyle">
										<div class="row-value">
										<p><span v-text="form.userName"></span>
										</div>
									</div>
								</div>
								
								<div class="form-row">
									<span class="row-label menustyle">操作动作：</span>
									<div class="row-content contentstyle">
	                                 	<div class="row-value">
	                                 		<p><span v-text="form.description"></span>
	                                 	</div>
	                                 </div>
								</div>
								
								<div class="form-row">
									<span class="row-label menustyle">操作方法：</span>
									<div class="row-content contentstyle">
	                                 	<div class="row-value">
	                                 		<p><span v-text="form.method"></span>
	                                 	</div>
	                                 </div>
								</div>
								<div class="form-row">
									<span class="row-label menustyle">访问人IP：</span>
									<div class="row-content contentstyle">
	                                 	<div class="row-value">
	                                 		<p><span v-text="form.requestIp"></span>
	                                 	</div>
	                                 </div>
								</div>
								<div class="form-row">
									<span class="row-label menustyle">访问操作系统详细信息：</span>
									<div class="row-content contentstyle">
	                                 	<div class="row-value">
	                                 		<p><span v-text="formatuserAgent(form.userAgent).os.full"></span>
	                                 	</div>
	                                 </div>
								</div>
								<div class="form-row">
									<span class="row-label menustyle">访问浏览器详细信息：</span>
									<div class="row-content contentstyle">
	                                 	<div class="row-value">
	                                 		<p><span v-text="formatuserAgent(form.userAgent).browser.full"></span>
	                                 	</div>
	                                 </div>
								</div>
							</div>
						</form>
    				</div>

					</template>
				</div>

    		</div>
    	</div>
    </section>
    
<script type="text/javascript" src="/pages/assets/js/libs/useragent/useragent.js"></script>
   <script src="/pages/assets/js/require.all.js?v=4293636e2ff5c4a96b189a7661023e42"></script>
   
   <script>
        requirejs([
            'vue',  
            'moment',
            
            'utils.search',
            'vender.modal', 
            'vender.types', 
            'vender.actions', 
             
            'jquery.common'
        ],
        function(Vue, moment,  Search,  Modal, Field,  Action){
        	
        	var search = new Search().getParams();
            var isEdit = !!search.id;
            
            Action.extend({
                'form.detail' : '/car-platform/log/detail?id={id}'
            })
            
   			var App={
   					
    			alert : function(){
    				alert(arguments[0]);
    			},


				getAppData :function(){
                    
                    var dtd = $.Deferred();
                    
                    var defaultData ={
                    }
                    if(!isEdit){
                         return dtd.resolve(defaultData);
                    }else{
	                    var url = Action.get('form.detail', search);
	                    $.getJSON(url, function(result){
	                        var code = result.code;
	                        if(Action.isSuccessful(result)){
	                            dtd.resolve(result.data)
	                        }else{
	                            var msg = Action.getResultMsg(result);
	                            dtd.reject(msg)
	                        }
	                    })
	                    .fail(function(e, type, msg){
	                        dtd.reject(type + msg)
	                    })	
                    }
                    
                    
                    return dtd;
                },
    			
    			initForm:function(formData){
    				new Vue({
    					el:'#app',
    					data:function(){
    						return {
								editing:true,
								form:formData
							}
    					},
						computed:{
							'isEdit':function(){
    							return isEdit;
    						},
							relate:function(){
								return this.form.relateOrder;
							}
						},
    					methods:{
    						createDefaultArea:function(area){
                                if(!area) return [];
                                return JSON.stringify(area)
                            },
                            formatDate :function(t){
                            	if(!t){
                            		return "-"
                            	}else{
									return moment(Number(t)).format('YYYY-MM-DD MM:HH');
                            	}
    						},
                            formatuserAgent :function(userAgent){
                            	if(!userAgent){
                            		return "-"
                            	}else{
                            		console.log(userAgent);
									 var ua = USERAGENT.analyze(userAgent);
									 console.log(ua);
									 return ua;
                            	}
    						}
    					}
    					
    					
    				})

    			},
    			
    			init:function(){
    				var app = this;
    				
    				this.getAppData()
    				.then(function(data){

    					app.initForm(data);
    				})
    				.fail(function(msg){
    					app.alert(msg)
    				})
    			}
    		}
            
    		App.init();
   })
   </script>
    </body>
</html>