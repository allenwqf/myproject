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
	<title>评价管理</title>
	<c:import url="/public/head-tag.jsp"/>
	<style type="text/css">

		.menustyle{
			width: 100px;
		}
		.contentstyle{
			padding-left: 50px;
		}
		.itemlogo{
            width: 40px;
            height: 40px;
            padding-right: 10px;
        }
        .bigImage{
            width: 300px;
        }
        p img{
            cursor:pointer
        }
	</style>
</head>
<body>

    <c:import url="/public/header.jsp"/>
    
    <section class="container" id="app">
    
		<c:set var="sidebar" scope="request" value="comment"/>
		<c:set var="navbar" scope="request" value="userComment"/>
		<c:import url="/public/sidebar.jsp"/>
		
    	<div class="content">
    		<div class="content-top">
    			<h3 class="content-title">
    				<div class="bread">
    					<a href="/car-platform/user/comment/listPage">用户评价</a>
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
                                 <p class="row-label">关联订单：</p>
                                 <div class="row-content contentstyle">
									
 		                            <div class="row-value">
 		                            	<p>
                                            <span>服务项目：</span>
                                            <span v-text="form.serviceDesc ? form.serviceDesc : '-'"></span>
                                        </p>
 		                            	<p>
											<span>订单号码：</span>
			                                <span v-text="form.orderId"></span>
										</p>
										<p v-if="form.orderId"><a href="/car-platform/order/washcar/detailPage?orderId={{form.orderId}}" class="action-link" target="_blank">查看订单</a></p>
                                 	</div>
                             	</div>
                             </div>

								<div class="form-row">
									<span class="row-label  menustyle">评价用户：</span>
									<div class="row-content contentstyle">
										<div class="row-value">
											<template v-if="form.uname">
									       		<span v-text="form.uname"></span>
		                                 		<p>
			                                 		<span class="value-note">联系方式：</span>
			                                 		<span v-text="form.phone" class="value-note"></span>
		                                 		</p>				
											</template>
											<template v-else>
												<span >暂无</span>
		                                 		<p>
                                                    <span class="value-note">联系方式：</span>
                                                    <span v-text="form.phone" class="value-note"></span>
                                                </p>
											</template>
	                          
	                                 	</div>
									</div>
								</div>

								<div class="form-row">
									<span class="row-label menustyle">评论：</span>
									<div class="row-content contentstyle">
										
										<table class="table table-middle">
					                        <thead>
					                        <tr>
					                            <th style="width: 15%">评论时间</th>
					                            <th style="width: 13%">综合评分</th>
					                            <th style="width: 15%">评分详情</th>
					                            <th style="width: 30%" class="align-left">用户评价</th>
					                        </tr>
					                        </thead>
					                        <tbody>
					                        	<!--<template v-if="length">
					                        		<tr v-for="item in forms">
							                            <td class="align-left" >
							                                <p v-text="formatDate(item.t)"></p>
							                            </td>
							                            <td class="align-left" >
							                               <span v-text="item.score"></span>分
							                            </td>
							                            <td class="align-left" >
							                            	<ul>
							                            		<li>店面环境:<span v-text="item.score1"></span>星</li>
							                            		<li>清洁程度:<span v-text="item.score2"></span>星</li>
							                            		<li>服务态度:<span v-text="item.score3"></span>星</li>
							                            	</ul>
							                            </td>
							                            <td class="align-left">
							                            	<p v-text="item.bvdesc"></p>
												        </td>
							                        </tr>
					                        	</template>
					                        	<template v-else>-->
					                        		<tr >
							                            <td class="align-left" >
							                                <p v-text="formatDate(form.t)"></p>
							                            </td>
							                            <td class="align-left" >
							                                <span v-text="form.score"></span>分
							                            </td>
							                            <td class="align-left" >
							                            	<ul>
							                            		<li>店面环境:<span v-text="form.score1"></span>星</li>
							                            		<li>清洁程度:<span v-text="form.score2"></span>星</li>
							                            		<li>服务态度:<span v-text="form.score3"></span>星</li>
							                            	</ul>
							                            </td>
							                            <td class="align-left">
							                            	<p v-text="form.bvdesc"></p>
							                            	<p>
							                            	    <template v-for="item in images">
							                            	    	<img :src='showSmallImage(item)' class="itemlogo" @click="showImage(item)" />
							                            	    </template>
							                            	</p>
												        </td>
							                        </tr>
					                        	<!--</template>-->
					                        		
					                        </tbody>
					                    </table>
										
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
            var isOrder = !!search.orderId;
            var isId= !!search.id;
            Action.extend({
                'form.detailbyorder' : '/car-platform/user/comment/byorderid/list?orderId={orderId}',
                'form.detailbyid' : '/car-platform/user/comment/detail?id={id}'
            })
            
   			var App={
   					
    			alert : function(){
    				alert(arguments[0]);
    			},


				getAppData :function(){
                    var dtd = $.Deferred();
                    var defaultData ={
                    }
                    var url;
                    if(isOrder){
                    	url=Action.get('form.detailbyorder', search);
                    }else if(isId){
                    	url= Action.get('form.detailbyid', search);
                    }
                    $.getJSON(url, function(result){
                        var code = result.code;
                        var usrData;
                        if(Action.isSuccessful(result)){
                        	if(isOrder){
                        		usrData=result.data[0];
		                    }else{
		                    	usrData=result.data;
		                    }
                            dtd.resolve(usrData)
                        }else{
                            var msg = Action.getResultMsg(result);
                            dtd.reject(msg)
                        }
                    })
                    .fail(function(e, type, msg){
                        dtd.reject(type + msg)
                    })	
                    
                    return dtd;
                },
    			
    			initForm:function(formData){
//  				if(formData.length){
//  					
//  				}else{
//  					formData[0]=formData;
//  				}
    				new Vue({
    					el:'#app',
    					data:function(){
    						return {
    							editing:true,
//  							form:formData[0],
								form:formData,
    							forms:formData,
    							length:formData.length
							}
    					},
    					computed:{
    						images:function(){
    							var tmp=this.form.images;
    							return tmp.split(',');
    						}
    					},
    					methods:{
                            formatDate :function(t){
								return moment(Number(t)).format('YYYY-MM-DD HH:mm:ss');
    						},
    						showSmallImage:function(item){
    							return Action.get('image.small', item)
    						},
    						showImage:function(str){
   							    var item=Action.get('image.medium', str);
							    App.playImage(item);
    						}
    					}
    				})

    			},
    			playImage :function(image){
                    require(['vender/player/photo'], function(PhotoPlayer){
                        PhotoPlayer.play(image)
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