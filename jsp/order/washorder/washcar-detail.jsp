<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<!--[if lt IE 7 ]><html class="ie ie6"><![endif]-->
<!--[if IE 7 ]><html class="ie ie7"><![endif]-->
<!--[if IE 8 ]><html class="ie ie8"><![endif]-->
<!--[if IE 9 ]><html class="ie ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html>
<!--<![endif]-->
<head>
<meta charset="utf-8">
<meta name="renderer" content="webkit">

<meta name="viewport" content="initial-scale=1,minimum-scale=1" />
<title>车辆清洗</title>
<c:import url="/public/head-tag.jsp" />
<style type="text/css">

.menustyle {
	width: 100px;
}

.contentstyle {
	padding-left: 50px;
}
.table-detail {
    width: 40%;
    margin: 5px 0;
    text-align: left;
}
</style>
</head>
<body>

	<c:import url="/public/header.jsp" />

	<section class="container" id="app">

		<c:set var="sidebar" scope="request" value="order" />
		<c:set var="navbar" scope="request" value="wash" />
		<c:import url="/public/sidebar.jsp" />

		<div class="content">
			<div class="content-top">
				<h3 class="content-title">
					<div class="bread">
						 <a href="/car-platform/order/washcar/listPage">车辆清洗</a>
						 <span>&gt;</span>
						 <span>详情</span>
					</div>
				</h3>
			</div>
			<div class="content-main">
				<div class="block block-main">
					<div class="block-content">
						<form >
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
									<span class="row-label menustyle">订单状态：</span>
									<div class="row-content contentstyle">
										<div class="row-value">
											<template v-if="form.payStatus==0">
												<span class="state" v-text="isInvalid"></span>
											</template>
											<template v-if="form.payStatus==1">
												<span  class="state">未消费</span>
											</template>
											<template v-if="form.payStatus==2">
												<span class="state">未评价</span>
											</template>
											<template v-if="form.payStatus==3">
												<span class="state">已评价</span>
											</template>
											<template v-if="form.payStatus==4">
												<span class="state">退款中</span>
											</template>
											<template v-if="form.payStatus==5">
												<span class="state">已退款</span>
											</template>
											<template v-if="form.payStatus==6">
												<span class="state" >已过期</span>
											</template>
											<template v-if="form.payStatus==7">
												<span class="state">未付款订单已失效</span>
											</template>
											<template v-if="form.payStatus==8">
												<span class="state">待退款</span>
											</template>
										</div>
									</div>
								</div>
								<div class="form-row">
									<span class="row-label menustyle">所属门店：</span>
									<div class="row-content contentstyle">
										<div class="row-value">
											<p v-text="form.bname?form.bname:'-'"></p>
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
											<p ><span style="padding-right: 20px;" v-text="form.name"></span><span class="value-note" v-text="form.phone"></span></p>
										</div>
									</div>
								</div>
                                <template v-if="form.payStatus==0">
                                	<div class="form-row">
	                                    <span class="row-label menustyle">付款信息：</span>
	                                    <div class="row-content contentstyle">
	                                        <div class="row-value">
	                                             <template v-for="item in paySta">
		                                             <template v-if="form.payStatus==item.type">
		                                             	<p v-text="item.desc"></p>
		                                             </template>
	                                             </template>
	                                        </div>
	                                    </div>
	                                </div>
	                                <div class="form-row">
	                                    <span class="row-label menustyle">服务项目：</span>
	                                    <div class="row-content contentstyle">
	                                    	
	                                    	<table class="table table-detail">
	                                    		<tr>
													<th>名称</th>
													<th>价格</th>
												</tr>
						                        <tr>
						                            <td><span  v-text="form.serviceDesc"></span>:</td>
						                            <td>
						                            	<template v-if="form.price"><b v-text="form.price" class="rmb"></b></template>
						                            	<template v-else><b class="rmb">0</b></template>
						                            </td>
						                        </tr>
						                        <tr>
						                            <td>费用合计：</td>
						                            <td><b class="rmb" v-text="form.price"></b></td>
						                        </tr>
						                    </table>
	                                    	
	                                    </div>
	                                </div>
                                </template>
                                
								<template v-else>
									<template v-if="form.payTime">
										<div class="form-row">
											<span class="row-label menustyle">付款时间：</span>
											<div class="row-content contentstyle">
												<div class="row-value">
													<p v-text="formatDate(form.payTime)"></p>
												</div>
											</div>
										</div>
									</template>
									
									<template v-if="form.refundTime">
	                                    <div class="form-row">
	                                        <span class="row-label menustyle">退款时间：</span>
	                                        <div class="row-content contentstyle">
	                                            <div class="row-value">
	                                            <p v-text="formatDate(form.refundTime)"></p>
	                                            </div>
	                                        </div>
	                                    </div>  
	                                </template>
	
									<template v-if="form.channel">
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
										<span class="row-label menustyle">服务项目：</span>
										<div class="row-content contentstyle">
											
											<table class="table table-detail">
												<tr>
													<th>名称</th>
													<th>价格</th>
												</tr>
						                        <tr>
						                            <td><span  v-text="form.serviceDesc"></span>:</td>
						                            <td>
						                            	<template v-if="form.price"><b v-text="form.price" class="rmb"></b></template>
						                            	<template v-else><b class="rmb">0</b></template>
						                            </td>
						                        </tr>
						                        <tr>
						                            <td>费用合计：</td>
						                            <td><b class="rmb" v-text="form.price"></b></td>
						                        </tr>
						                    </table>
											
										</div>
									</div>
									<template v-if="form.payStatus == 3 ">
										<div class="form-row">
											<span class="row-label menustyle">用户评价：</span>
											<div class="row-content contentstyle">
												<div class="row-value">
												     <a href="/car-platform/user/comment/detailPage?orderId={{form.id}}" class="action-link" target="_blank">查看评价详情</a> 
												</div>
											</div>
										</div>
	                                </template>
							</template>
							
							
							</div>
						</form>
					</div>
				</div>

			</div>
		</div>
	</section>


	<script src="/pages/assets/js/require.all.js?v=4293636e2ff5c4a96b189a7661023e42"></script>
	<script>
		requirejs([ 'vue', 'moment', 'utils.search', 'vender.actions'],
		function(Vue, moment, Search, Action) {

			var search = new Search().getParams();

			Action.extend({
				'form.detail' : '/car-platform/order/washcar/detail?orderId={orderId}',
			})
			
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

			var payStatus=[
	             {"type":"0","desc":"待付款"},
	             {"type":"1","desc":"已付款"},
	             {"type":"2","desc":"已服务"},
	             {"type":"3","desc":"已评论"},
	             {"type":"4","desc":"已申请退款"},
	             {"type":"5","desc":"已退款"},
	             {"type":"6","desc":"已过期"}
             ]
			
			var App = {

				alert : function() {
					alert(arguments[0]);
				},

				getAppData : function() {
					var dtd = $.Deferred();
					var url = Action.get('form.detail', search);
					$.getJSON(url, function(result) {
						var code = result.code;
						if (Action.isSuccessful(result)) {
							dtd.resolve(result.data)
						} else {
							var msg = Action.getResultMsg(result);
							
							dtd.reject(msg)
						}
					}).fail(function(e, type, msg) {
						dtd.reject(type + msg)
					})

					return dtd;
				},

				initForm : function(formData) {

					new Vue({
						el : '#app',
						data : function() {
							return {
								form : formData,
								payType: payChannel,
								paySta:payStatus
							}
						},
						computed:{
                			isInvalid:function(){
                				var that=this;
                				var isInvalid;
					    	    var myDate=new Date().getTime();
					    	    var time=myDate-that.form.unpayExpireTime;
					    	    if (time>0){
					    	    	isInvalid="未付款订单已失效";
					    	    }else{
					    	    	isInvalid="未付款";
					    	    }
					    	    return isInvalid;
                			}
                		},
						methods : {
							formatDate : function(t) {
								return moment(Number(t)).format('YYYY-MM-DD HH:mm:ss');
							}
						}

					})
				},

				init : function() {
					var app = this;

					this.getAppData().then(function(data) {
						app.initForm(data);
					}).fail(function(msg) {
						app.alert(msg)
					})
				}
			}

			App.init();
		})
	</script>
</body>
</html>