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
	<title>订单管理-会员充值</title>
	 
	<c:import url="/public/head-tag.jsp"/>
	<style type="text/css">
		.menustyle{
			width: 100px;
		}
		.contentstyle{
			padding-left: 50px;
		}
		.table-detail {
		    width: 30%;
		    margin: 5px 0;
		    text-align: left;
		}
	</style>
</head>
<body>

    <c:import url="/public/header.jsp"/>
    
    <section class="container" id="app">
    
		<c:set var="sidebar" scope="request" value="order"/>
		<c:set var="navbar" scope="request" value="userecharge"/>
		<c:import url="/public/sidebar.jsp"/>
		
    	<div class="content">
    		<div class="content-top">
    			<h3 class="content-title">
    				<div class="bread">
    					<a href="/car-platform/order/usercharge/listPage">会员充值</a>
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
						<form  method="post">
							<div class="form-block">
								<div class="form-row">
									<span class="row-label menustyle">订单号码：</span>
									<div class="row-content contentstyle">
	                                 	<div class="row-value">
	                                 		<p v-text="form.id"></p>
	                                 	</div>
	                                 </div>
								</div>

								<div class="form-row">
									<span class="row-label menustyle">下单时间：</span>
									<div class="row-content contentstyle">
										<div class="row-value">
										<p v-text="formatDate(form.createTime)"></p>
										</div>
									</div>
								</div>

								<div class="form-row">
									<span class="row-label menustyle">下单用户：</span>
									<div class="row-content contentstyle">
										<div class="row-value">
										<p v-text="form.name"></p>
										<p v-text="form.phone"></p>
										</div>
									</div>
								</div>
								<template  v-if="form.payStatus==0">
								    <div class="form-row">
                                        <span class="row-label menustyle">支付信息：</span>
                                        <div class="row-content contentstyle">
                                            <div class="row-value">
                                                <p>未支付</p>
                                            </div>
                                        </div>
                                    </div>
								</template>
								
                                <template v-else>
                                    <div class="form-row">
                                        <span class="row-label menustyle">付款时间：</span>
                                        <div class="row-content contentstyle">
                                            <div class="row-value">
                                            <p v-text="formatDate(form.payTime)"></p>
                                            </div>
                                        </div>
                                    </div>
    
                                    <div class="form-row">
                                        <span class="row-label menustyle">支付方式：</span>
                                        <div class="row-content contentstyle">
                                            <div class="row-value">
                                                <template v-for="item in payType">
                                                    <template v-if="form.channel==item.type">
                                                        <p>{{item.desc}}</p>
                                                    </template>
                                                </template>
                                            </div>
                                        </div>
                                    </div>
                                </template>
								
								
								<div class="form-row">
									<span class="row-label menustyle">订单项目：</span>
									<div class="row-content contentstyle">
											
										<!--<div class="row-value">-->
											<table class="table-detail">
					                        <tr>
					                            <td><span  v-text="form.name"></span>:</td>
					                            <td>
					                            	<template v-if="form.curBalance"><b v-text="form.curBalance" class="rmb"></b></template>
					                            	<template v-else><b class="rmb">0</b></template>
					                            </td>
					                        </tr>
					                        <tr>
					                            <td>支付共计：</td>
					                            <td><b class="rmb" v-text="form.price"></b></td>
					                        </tr>
					                    </table>
										<!--<ul>
										  <li>
										    <span class="row-label2" v-text="form.name"></span>：
										    <template v-if="form.curBalance">
										      <b v-text="form.curBalance" class="rmb"></b>
										    </template>
										    <template v-else>
										      <b class="rmb">0</b>
										    </template>
										  </li>
										  <li><span class="row-label2" >支付共计：</span><b class="rmb" v-text="form.payAmount"></b></li>
										</ul>-->
										<!--</div>-->
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
            'vender.actions', 
        ],
        function(Vue,  moment, Search,  Modal, Action){
        	
        	var search = new Search().getParams();
            var isEdit = !!search.id;
            
            Action.extend({
                'form.detail' : '/car-platform/order/usercharge/detail?id={id}'
            });
            
            var payChannel=[
                {"type":"alipay",
                 "desc":"支付宝"   
                },
                {"type":"wx",
                 "desc":"微信"   
                },
                {"type":"jglh_account",
                 "desc":"余额支付"   
                }
            ];
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
								form:formData,
								payType:payChannel
							}
    					},
						computed:{
							'isEdit':function(){
    							return isEdit;
    						}
						},
    					methods:{
                            formatDate :function(t){
								return moment(Number(t)).format('YYYY-MM-DD MM:HH:ss');
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