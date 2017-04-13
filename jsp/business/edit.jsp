<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		<title>商家账号-编辑</title>
		<c:import url="/public/head-tag.jsp" />
		<style type="text/css">
			.menustyle {
				width: 100px;
			}
			
			.contentstyle {
				padding-left: 50px;
			}
			.text-150 {
			    width: 40px;
			}
			.text-80{
                 width: 80px;
             }
			 .text-120{
                 width: 220px;
             }
            .unit{
               padding-left: 10px;
            }
            .row-label1 {
			    padding: 2px;
			    position: absolute;
			    left: 5px;
			    top: 5px;
			    color: #2C2B2B;
			    display: block;
			    width: 90px;
			}
		</style>
	</head>

	<body>

		<c:import url="/public/header.jsp" />

		<section class="container" id="app">

			<c:set var="sidebar" scope="request" value="business" />
			<c:set var="navbar" scope="request" value="data" />
			<c:import url="/public/sidebar.jsp" />

			<div class="content">
				<div class="content-top">
					<h3 class="content-title">
    				<div class="bread">
    					<a href="/car-platform/business/info/listPage">商家账号</a>
    					<span>&gt;</span>
    					
    					<template v-if="isEdit">
        					<span >编辑</span>
    					</template>
    					
    					<template v-else>
        					<span >添加</span>
    					</template>
    				</div>
    			</h3>
				</div>
				<div class="content-main">
					<div class="block block-main">
						<div v-if="!editing" class="block-content loading">
							loading...
						</div>
						<template v-else>
							<div class="block-content">
								<!--goback="data.jsp"-->
								<form action={{submitAction}} goback="/car-platform/business/info/listPage"  method="post" >
									<div class="form-block">
										<div class="form-row">
											<template v-if="form.id">
												<span class="row-label menustyle">商家编号：</span>
												<div class="row-content contentstyle">
													<div class="row-value">
														<input type="hidden" name="id" v-model="form.id" />
														<p v-text='form.id'></p>
													</div>
												</div>
											</template>
										</div>

										<div class="form-row  require">
											<span class="row-label  menustyle">商家名称：</span>
											<div class="row-content contentstyle">
												<input name="name" type="text" class="text" iname="商家名称" v-model="form.companyName" placeholder="商家名称" />
											</div>
										</div>

										<div class="form-row require">
											<span class="row-label menustyle">管理帐户：</span>
											<div class="row-content contentstyle">
												<div class="row-value">
													<template v-if="adminUserName">
														<p v-text="adminUserName"></p>
													</template>
													<template v-else>
														<input type="text" name="adminName"  class="text" iname="管理帐户" placeholder="管理帐户" />
													</template>
												</div>
											</div>
										</div>
										<div class="form-row require">
											<span class="row-label menustyle">管理密码：</span>
											<div class="row-content contentstyle">
												<div class="row-value">
													<template v-if="!isEdit">
														<tr>
															<td><input type="text" class="text" name="adminPassword" iname="管理密码" placeholder="管理密码"  /></p></td>
														</tr>
														
													</template>
													<template v-else>
														<tr>
															<td><p>******</p></td>
															<td class="contentstyle"><a href="javascript:;" class="action-link action-add" @click="editPassword(form,adminUserName)">重设密码</a></td>
														</tr>
														
													</template>
												</div>
											</div>
										</div>

										<div class="form-row require">
											<span class="row-label menustyle">业务资质：</span>
											<div class="row-content contentstyle">
												<table class="table table-middle">
													<thead>
														<tr>
															<th style="width: 13%">业务名称</th>
															<th style="width: 10%" class="align-left">操作</th>
														</tr>
													</thead>
													<tbody>
														<template v-if="serviceItem" v-model="serviceItem">

															<tr v-for="item in serviceItem">
																<td class="align-left">
																	<p>{{ item.title }}</p>
																</td>
																<td class="align-left">
																	<a href="javascript:;" class="action-link action-add" @click="editData(form,item)" class="action-link">设置</a>
																	<!-- <a href="javascript:;" class="action-link action-add" @click="removeData(item)" class="action-link">删除</a> -->
																</td>
															</tr>
															<!--<a href="javascript:;" class="action-link action-add" @click="addData(form)">添加业务+</a>-->
														</template>
														<template v-else>
															<!--<a href="javascript:;" class="action-link action-add" @click="addData(form)">添加业务+</a>-->
														</template>

													</tbody>
												</table>
												</div>
											</div>
										</div>

										<div class="form-row require">
											<span class="row-label menustyle">法人</span>
											<div class="row-content contentstyle">
												<input name="ownerName" type="text" class="text" v-model="form.companyOwner" placeholder="运营负责人" iname="运营负责人" />
											</div>
										</div>

										<div class="form-row require">
											<span class="row-label menustyle">法人手机：</span>
											<div class="row-content contentstyle">
												<input name="ownerPhone" type="text" class="text" v-model="form.companyOwnerPhone" placeholder="负责人手机" iname="负责人手机" />
											</div>
										</div>
										
										<div class="form-row require">
											<span class="row-label menustyle">运营负责人</span>
											<div class="row-content contentstyle">
												<input name="operationManager" type="text" class="text" v-model="form.operationManager" placeholder="运营负责人" iname="运营负责人" />
											</div>
										</div>

										<div class="form-row require">
											<span class="row-label menustyle">负责人手机：</span>
											<div class="row-content contentstyle">
												<input name="operationManagerPhone" type="text" class="text" v-model="form.operationManagerPhone" placeholder="负责人手机" iname="负责人手机" />
											</div>
										</div>

										<div class="form-row">
											<span class="row-label menustyle">所在区域：</span>
											<div class="row-content contentstyle">
										         
                                                 
												   <select name="province" class="select" >   
													    <template v-for="item in provinces">
													    	<template v-if="form.province==item.name">
	                                                            <option value={{item.name}} selected="selected">{{item.name}}</option>    
	                                                        </template>
	                                                      <template v-else>
	                                                            <option value={{item.name}}>{{item.name}}</option>
	                                                        </template>
													    </template>
												    </select>
												    <select name="city" class="select" >
													    <template v-for="item in citys">
	                                                        <template v-if="form.city==item.name">
	                                                            <option value={{item.name}} selected="selected">{{item.name}}</option>    
	                                                        </template>
	                                                        <template v-else>
	                                                            <option value={{item.name}}>{{item.name}}</option>
	                                                        </template>
	                                                    </template>
                                            		</select>																			
												<select name="county"  class="select" >
                                                    <template v-for="item in areas">
                                                        <template v-if="form.county==item.name">
                                                            <option value={{item.name}} selected="selected">{{item.name}}</option>    
                                                        </template>
                                                        <template v-else>
                                                            <option value={{item.name}}>{{item.name}}</option>
                                                        </template>
                                                    </template>
                                                </select>
												
											</div>
											
										</div>

										<div class="form-row">
											<span class="row-label menustyle">联系地址：</span>
											<div class="row-content contentstyle">
												<input name="address" type="text" class="text" iname="联系地址" v-model="form.companyAddress" placeholder="联系地址" />
											</div>
										</div>

										<div class="form-row form-row-btn">
											<div class="row-content contentstyle">
												<button class="btn btn-default btn-large" v-text="isEdit?'保存修改':'确认新增'">确认新增</button>
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
		
		<script type="text/template" id="item/password" note="重设密码">
			<style>
				.remove-content {
					padding: 10px;
					color: red;
				}
			</style>
			<form action="/car-platform/business/admin/user/password/update" method="post">
				<input type="hidden" name="bid" value="{{id}}" />
				<input type="hidden" name="adminName" value="{{adminName}}" />
				<div class="form-row">
					<span class="row-label">新密码：</span>
					<div class="row-content contentstyle">
						<div class="row-value">
							<input type="password" name="adminPassword" />
						</div>
					</div>

				</div>
			</form>
			<div class="form-row">
				<span class="row-label">确认密码：</span>
				<div class="row-content contentstyle">
					<div class="row-value">
						<input type="password" id="pwd2" name="adminPassword2" />
					</div>
				</div>
			</div>
		</script>
		
		
		<script type="text/template" id="item/remove" note="业务删除">
			<style>
				.remove-content {
					padding: 10px;
					color: red;
				}
			</style>
			<form method="post">
				<div class="align-center remove-content">确定要删除该业务吗？</div>
				<input type="hidden" name="id" value="{{id}}" />
			</form>
		</script>

		<script type="text/template" id="item/edit" note="设置业务">
			<style>
				.remove-content {
					padding: 10px;
					color: red;
				}
			</style>
			
			<form action="/car-platform/business/own/goods/update" post>
				<input type="hidden" id="bid" name="bid" v-model="form.bid" />
				<input type="hidden" id="serviceId" name="serviceId" v-model="form.serviceId" />
				<input type="hidden"  name="items" v-model="itemService" />
				
				<div class="form-row">
					<span class="row-label1">业务名称：</span>
					<div class="row-content contentstyle">
						<div class="row-value">
							<p v-text="form.title"></p>
						</div>
					</div>

				</div>

				<div class="form-row">
					<span class="row-label1">业务定价：</span>
					<div class="row-content contentstyle">

						<table class="table table-middle">
							<thead>
								<tr>
									<th style="width: 5%"></th>
									<th style="width: 25%">洗车服务</th>
									<th style="width: 15%" class="align-left">原价</th>
                                    <th style="width: 15%" class="align-left">现价</th>
								</tr>
							</thead>
							
							<tbody>
									
								<tr v-for="item in form.list">
									<td class="align-left">
											<input type="checkbox" id={{item.serviceFlag}} v-model="item.checked">
									</td>
									<td class="align-left">
                                        <label for={{item.serviceFlag}} v-text="item.body"></label>
									</td>
									<td class="align-left">
										<span class="rmb"><input type="number"  :disabled="!item.checked" class="text-150" v-model="item.oldPrice" /></span>
									</td>
									<td class="align-left">
										<span class="rmb"><input type="number"  :disabled="!item.checked" class="text-150" v-model="item.price" /></span>
										<input type="hidden" :value="expireTime">
										<!--<input type="hidden" :value="tips">-->
										<input type="hidden" :value="sdate">
										<input type="hidden" :value="edate">
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			
                <div class="form-row">
                    <span class="row-label1">订单有效期：</span>
                    <div class="row-content contentstyle">
                        <input name="expireTime" type="number" class="text text-80" v-model="expireTime" iname="有效期" itip="有效期"/><span class="unit">天</span>
                    </div>
                </div>
                <div class="form-row">
                    <span class="row-label1">营业时段：</span>
                    <div class="row-content contentstyle">
						<!--<textarea name="tips" class="text-120" v-model="tips" iname="重要提示" itip="重要提示"></textarea>-->
						<input type="text" class="text text-100" name="sdate" v-model="sdate" placeholder="开始时间"  datetimepicker/>
                        	<span>至</span>
                    	<input type="text" class="text text-100" name="edate" v-model="edate" placeholder="结束时间" datetimepicker/>
                   </div>
                </div>              
			</form>

		
		</script>


		<script src="/pages/assets/js/require.all.js?v=4293636e2ff5c4a96b189a7661023e42"></script>
		<script>
			requirejs([
					'vue',
					'artDialog',
					'artTemplate',
					'moment',
					'select.linkage',

					'utils.search',
					'vender.modal',
					'vender.types',
					'vender.actions',
					
					'jquery.datetimepicker',
					'jquery.formcheck',
					'jquery.ajaxsubmit',
					'jquery.common'
				],
				function(Vue, dialog, template, moment, selectLinkage, Search, Modal, Field, Action) {

					var search = new Search().getParams();
					var isEdit = !!search.id;

					var addBussinesService;
					Action.extend({
		                'form.detail' : '/car-platform/business/info/search?id={id}',
						'form.service':'/car-platform/business/own/goods/list?bid={bid}&serviceId={serviceId}',
						'form.save':'/car-platform/business/own/goods/update',
						'form.notinstall':'/car-platform/business/goods/list?serviceId=0',
						
//						'form.notinstall':'/car-platform/business/qualification/notinstall/list?bid={bid}',
						'form.updataPrice':'/car-platform/business/service/update',



						'form.area':'/car-platform/business/info/allCounty/get',
						'form.password':'/car-platform/business/admin/user/password/update',
						
						
						'form.updatesave':'/car-platform/business/info/update',
						'form.addsave':'/car-platform/business/info/add'
					})
					
					var ownService=
			            {
			                "id":"",
			                "icon":"",
			                "title":"",
			                "deposit":"",
			                "contentStandard":"",
			                "contentFlow":"",
			                "servicePriceDetail":"",
			                "brief":""
			            };
					
					var area_province=[
                        {"name":"河南省"}
					];
					var area_city=[
                        {"name":"郑州市"}
                    ];
					var area_HN=[
						{"name":"金水区"},
						{"name":"惠济区"},
						{"name":"高新区"},
						{"name":"郑东新区"},
						{"name":"经开区"},
						{"name":"中原区"},
						{"name":"管城区"},
						{"name":"二七区"}
					];
                    
					var App = {

						alert: function() {
							alert(arguments[0]);
						},
						reloadItems: function() {
							$("#box").reload();
						},
						
						getNotinstall:function(tmp){
							var dtd = $.Deferred();
							var url;
							var tmpbid;
							var url = Action.get("form.notinstall");
							$.getJSON(url, function(result) {
								var code = result.code;
								if(Action.isSuccessful(result)) {
									dtd.resolve(result.data)
								} else {
									var msg = Action.getResultMsg(result);
									dtd.reject(msg)
								}
							})
							.fail(function(e, type, msg) {
								dtd.reject(type + msg)
							})
							return dtd;
						},
						
						
						getArea:function(){
							var dtd = $.Deferred();
							var url = Action.get("form.area");
							$.getJSON(url, function(result) {
								var code = result.code;
								if(Action.isSuccessful(result)) {
									dtd.resolve(result.data)
								} else {
									var msg = Action.getResultMsg(result);
									dtd.reject(msg)
								}
							})
							.fail(function(e, type, msg) {
								dtd.reject(type + msg)
							})
							return dtd;
						},
						
						getAppData: function() {
							var dtd = $.Deferred();

							var that = this;
							var defaultData = {
							};

							if(!isEdit) {
								return dtd.resolve(defaultData);
							} else {
								var url = Action.get('form.detail', search);
								$.getJSON(url, function(result) {
										var code = result.code;
										if(Action.isSuccessful(result)) {
											dtd.resolve(result.data)
										} else {
											var msg = Action.getResultMsg(result);
											dtd.reject(msg)
										}
									})
									.fail(function(e, type, msg) {
										dtd.reject(type + msg)
									})
							}
							return dtd;
						},
							
						initForm: function(formData) {
							new Vue({
								el: '#app',
								data: function() {
									return {
										selected:formData.area[0],
										editing: true,
										adminUserName:formData.adminUserName,
										form: formData.businessInfo,
										serviceItem: formData.ownService,
										areas:area_HN,
										provinces:area_province,
										citys:area_city
									}
								},
								computed: {
									'isEdit': function() {
										return isEdit;
									},
									'submitAction': function() {
										if(isEdit) return Action.get('form.updatesave')
										return Action.get('form.addsave')
									},
									'items':function(){
										return JSON.stringify(this.serviceItem);
									}
								},
								methods: {
									createDefaultArea: function(area) {
										if(!area) return [];
										return JSON.stringify(area)
									},
									editPassword:function(tmp,pwd){
										App.editPassword(tmp,pwd);
									},
									editData: function(form,item) {
										$.when(App.getNotinstall(),App.getService(form,item)).then(function(allItem,data) {
											var timeData={
												sdate:'',
												edate:'',
												expireTime:''
											}
											var myTime;
											allItem.forEach(function(item,index){
												
												for(var i=0;i<data.length;i++){
													
													if(data[i].serviceFlag==item.flag){
														item.checked=true;
														item.goodsId=data[i].goodsId,
														item.body=data[i].body,
														item.serviceFlag=data[i].serviceFlag,
														item.body= data[i].body;
														item.expireTime=data[i].expireTime,
														item.oldPrice=data[i].oldPrice,
														item.price=data[i].price;
														item.tips=data[i].tips;
														myTime=data[i].tips.split("~");
														item.sdate=myTime[0];
														item.edate=myTime[1];
														timeData.sdate=myTime[0];
														timeData.edate=myTime[1];
														timeData.expireTime=data[i].expireTime;
													}
													
													item.goodsId=item.id;
													item.body=item.name;
													item.serviceFlag=item.flag;
													
													item.serviceId=0;
													item.status=0;
												}
											})
											App.editItem(allItem,item,timeData);
											
										})
										.fail(function(msg) {
											App.alert(msg)
										})
									},
									addData:function(tmp){
										var that=this;
										App.getNotinstall(tmp)
										.then(function(data) {
											App.addItem(data).then(function(result){
												that.serviceItem.push(result);
//												addBussinesService=result;
											})
											
										})
										.fail(function(msg) {
											App.alert(msg)
										})
									}
								}

							})

						},
						getService: function(form,item) {
							var dtd = $.Deferred();
							var test = {
								bid: form.id,
								serviceId:0
							}
							var url  = Action.get("form.service", test);
							$.getJSON(url, function(result) {
									var code = result.code;
									if(Action.isSuccessful(result)) {
										dtd.resolve(result.data)
									} else {
										var msg = Action.getResultMsg(result);
										dtd.reject(msg)
									}
								})
								.fail(function(e, type, msg) {
									dtd.reject(type + msg)
								})
							return dtd;
						},
						
						editPassword: function(data,pwd) {
							data.adminName=pwd
							var id = "item/password";
							var title = "重设密码";
							var content = template(id, data);
							var idialog = dialog({
								id: id,
								zIndex: 5,
								width: 300,
								padding: "40px 20px",
								title: title,
								content: content,
								button: [{
									id: "cancel",
									value: "取消"
								}, {
									id: "ok",
									value: "确定修改",
									autofocus: true,
									callback: function() {
										var $form = this.getContent().find("form");
										var params=$.deParam($form.serialize());
										
										var key1=params.adminPassword;
										var key2=$("#pwd2").val();
										if(key1===key2){
											$form.ajaxSubmit({
												onSuccess: function(
													result) {
													var code = result.code;
													if(code == 200) {
														idialog.remove();
														App.reloadItems();
													} else {
														var msg = result.msg || "提交失败！";
														App.alert(msg);
													}
												}
											})
										}else{
											App.alert("两次输入密码不一致,请重新输入");
										}
										
										return false;
									}
								}]
							}).showModal();
						},
						
						addItem: function(data) {
							var app = this;
		                    var dtd = $.Deferred();
		                    
							if(data.length==0){
								App.alert("暂无新业务")
							}else{
								var id = "item/add";
								var tmpServiceItem;
								$.each(data, function(index,value) {
									data[index].servicePriceDetail=JSON.parse(data[index].servicePriceDetail);
								});
								var title = document.getElementById(id).title || "设置业务";
								
			                    var tplDom = document.getElementById(id)
			                    
			                    var content=tplDom.innerHTML;
			                    var idialog=dialog({
			                        id : id,
			                        title:title,
			                        content:content,
			                        onshow:function(){
			                        	var el = this.getContent()[0];
			                        	
			                        	var vueApp = new Vue({
			                        		el:el,
			                        		computed:{
			                        			itemsJson:function(){
			                        				//tmpServiceItem=this.serviceItem1.servicePriceDetail;
			                        				tmpServiceItem=this.serviceItem1;
			                        				return JSON.stringify(this.serviceItem1.servicePriceDetail)
			                        			},
			                        			serviceItem1:function(){
			                        				var that =this;
			                        				var item=this.serviceList[0];
			                        				this.serviceList.forEach(function(value){
			                        					if(value.id==that.service){
			                        						item=value;
			                        					}
			                        				})
			                        				return item;
			                        			}
			                        		},
			                        		data:function(){
			                        			return {
			                        				bid:search.id,
			                        				serviceList:data,//
			                        				service:data[0].id
			                        			}
			                        		}
			                        	})
			                        },
			                        onclose:function(){
			                            dtd.reject();
			                            this.remove();
			                        },
			                        zIndex: 5,
			                        width:500,
			                        button:[
			                            {
			                                id:"cancel",value:"取消"
			                            },
			                            {
			                                id:"ok",value:"确定",
			                                autofocus:true,
			                                callback:function(){
			                                	var $form = this.getContent().find("form");
			                                	$form.ajaxSubmit({
													onSuccess: function(result) {
														var code = result.code;
														if(code == 200) {
															idialog.remove();
															
															dtd.resolve(tmpServiceItem);
															
															Modal.tip('添加成功', Modal.MsgType.SUCCESS);
														} else {
															var msg = result.msg || "提交失败！";
															Modal.tip('添加失败', Modal.MsgType.ERROR);
														}
													}
												})
											return false;
			                                }
			                            }
			                        ]
			                    }).showModal();
			                    
							}
		                   	return dtd;
							
						},
						editItem: function(data,tmp,timeObj) {
							var testData={
								bid:search.id,
								serviceId:0,
								title:tmp.title,
								list:data
							};
							var id = "item/edit";
							var title = document.getElementById(id).title || "设置业务";
							var app = this;
		                    var dtd = $.Deferred();
		                    var tplDom = document.getElementById(id)
		                    var content=tplDom.innerHTML;
		                    var idialog=dialog({
		                        id : id,
		                        title:title,
		                        content:content,
		                        onshow:function(){
		                        	var el = this.getContent()[0];
		                        	var vueApp = new Vue({
		                        		el:el,
		                        		computed:{
		                        			itemService:function(){
		                        				return JSON.stringify(this.form.list);
		                        			}
		                        		},
		                        		data:function(){
		                        			return {
		                        				form:testData,
												expireTime:timeObj.expireTime,
												sdate:timeObj.sdate,
												edate:timeObj.edate
		                        			}
		                        		}
		                        	})
		                        	App.initDatePicker();
		                        },
		                        onclose:function(){
		                            dtd.reject();
		                            this.remove();
		                        },
		                        zIndex: 5,
		                        width:620,
		                        button:[
		                            {
		                                id:"cancel",value:"取消"
		                            },
		                            {
		                                id:"ok",value:"确定",
		                                autofocus:true,
		                                callback:function(){
		                                	
		                                	var $form = this.getContent().find("form");
			                                $form.checkForm({promise:true})
			                                .then(function(){
		                                	
			                                	var params= $form.serialize();
			                                	var saveData=$.deParam(params);
			                                	var saveItems=[];
			                                	var contactTime=saveData.sdate+"~"+saveData.edate;
			                                	JSON.parse(saveData.items).forEach(function(item,index){
			                                		if(item.checked===true){
			                                			item.expireTime=saveData.expireTime;
			                                			item.tips=contactTime;
			                                			delete item.checked;
			                                			delete item.sdate;
			                                			delete item.edate;
			                                			delete item.flag;
			                                			delete item.name;
			                                			delete item.id;
			                                			saveItems.push(item);
			                                		}
			                                	})
			                                	delete saveData.sdate;
			                                	delete saveData.edate;
			                                	delete saveData.expireTime;
			                                	saveData.items=JSON.stringify(saveItems);
			                                	var actionURL=Action.get("form.save");
		   		                                    $.post(actionURL,saveData,function(result){
		   		                                    	var code=result.code;
		   		                                    	if(code==200){
			   		                                    	Modal.tip("修改成功",Modal.MsgType.SUCCESS);
		   		                                    	}else{
		   		                                    		var msg=result.msg || "提交失败！";
															Modal.tip(msg,Modal.MsgType.ERROR);
		   		                                    	}
		   		                                    }).fail(function(e){
		   		                                    	Modal.tip("操作失败",Modal.MsgType.ERROR);
		   		                                    });
			                                	idialog.remove();
			                                	
			                                }).fail(function(e){
			                                	app.alert(e.msg)
			                                });
											return false;
		                                }
		                            }
		                        ]
		                    }).showModal().reset();
		                    
		                    return dtd;
						},
						
						initDatePicker:function(){
                            
                            $('[datetimepicker]').datetimepicker({
                                format: "hh:ii",
                                autoclose: true,
                                language:'zh-CN',
                                weekStart: 1, 
                                autoclose: 1, 
                                todayHighlight: 1,//高亮显示目前的时间
                                minuteStep: 15,
                                startView: 1,
                                minView: 0,
                                maxView: 1,
                                forceParse: 0
                            });
                            
                            $(".datetimepicker").find('.prev , .switch , .next').css('visibility','hidden');
                            
                        },
						initDOMEvents: function() {
                        
							$("form").ajaxSubmitify({
								onFail: function(e) {
									var type = e.target ? Modal.MsgType.WARN : Modal.MsgType.ERROR;
									var msg = e.target ? e.msg : e;
									Modal.alert(msg, null, type).then(function() {
										setTimeout(function() {
											e.target && e.target.focus();
										}, 0)
									});
								},
								afterSuccess: function() {
									Modal.tip('提交成功', Modal.MsgType.SUCCESS);
									//window.close();
								}
							});
						},

						init: function() {
							var app = this;
							$.when(this.getAppData(),this.getArea())
							.then(function(data,area) {
								data.area=area;
								app.initForm(data);
								
								app.initDOMEvents();
							})
							.fail(function(msg) {
								app.alert(msg)
							})

						}
					}

					App.init();
				})
		</script>
	</body>

</html>