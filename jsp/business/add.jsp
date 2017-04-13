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
		<title>商家账号-添加</title>
		<c:import url="/public/head-tag.jsp" />
		<style type="text/css">
			
			.menustyle {
				width: 100px;
			}
			
			.contentstyle {
				padding-left: 50px;
			}
			.text-150 {
			    width: 60px;
			}
			.text-80{
                 width: 80px;
             }
            .unit{
               padding-left: 10px;
            }
			.text-320{
                 width: 220px;
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
			
			.pass-item-error {
			    display: none;
			    /*float: left;
			    position: relative;*/
			    width: 250px;
			    top: 12px;
			    color: #fc4343;
			    height: 16px;
			    line-height: 14px;
			    padding-left: 20px;
			    background: url(/static/passpc-account/img/reg/err_small.png) 0 0 no-repeat;
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
    					<span >添加</span>
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
								<form action={{submitAction}} goback="/car-platform/business/info/listPage"  method="post">
									<div class="form-block">

										<div class="form-row  require">
											<span class="row-label  menustyle">商家名称：</span>
											<div class="row-content contentstyle">
												<input name="name" type="text" class="text" iname="商家名称" autocomplete="off"  v-model="form.name" placeholder="商家名称" />
											</div>
										</div>

										<div class="form-row require">
											<span class="row-label menustyle">管理帐户：</span>
											<div class="row-content contentstyle">
												<div class="row-value">
													<input type="text" name="adminName" id="adminName" autocomplete="off" autocomplete="new-password" class="text" iname="管理帐户" placeholder="管理帐户" />
													<span id="repeat-check" class="pass-item-error">
														此帐户已存在,请更换一个
													</span>
												</div>
											</div>
										</div>
										<div class="form-row require">
											<span class="row-label menustyle">管理密码：</span>
											<div class="row-content contentstyle">
												<div class="row-value">
													<input type="password" class="text" name="adminPassword" autocomplete="new-password" autocomplete="off" iname="管理密码" placeholder="管理密码"  /></p>
												</div>
											</div>
										</div>

										<div class="form-row require">
											<span class="row-label menustyle">业务资质：</span>
											<div class="row-content contentstyle">
											<input type="hidden" name="items" :value="ITEMS" iname="业务" />
											<input type="hidden" :value="serviceItem" />
												<table class="table table-middle">
													<thead>
														<tr>
															<th style="width: 30%">业务名称</th>
															<th style="width: 10%" class="align-left">操作</th>
														</tr>
													</thead>
													<tbody>
														<template v-if="serviceItemLen!=0">

															<tr>
																<td class="align-left">
																	<p>车辆清洗</p>
																</td>
																<td class="align-left">
                                                                    <a href="javascript:;" class="action-link action-add" @click="removeData(item)" class="action-link">删除</a>
																</td>
															</tr>
														</template>
														<template v-else>
															<a href="javascript:;" class="action-link action-add" @click="addData()">添加业务+</a>
														</template>

													</tbody>
												</table>
												</div>
											</div>
										</div>

                                        <div class="form-row require">
											<span class="row-label menustyle">法人</span>
											<div class="row-content contentstyle">
												<input name="ownerName" type="text" class="text" iname="运营负责人" v-model="form.companyOwner" placeholder="运营负责人" />
											</div>
										</div>

										<div class="form-row require">
											<span class="row-label menustyle">负责人手机：</span>
											<div class="row-content contentstyle">
												<input name="ownerPhone" type="text" class="text" iname="负责人手机" v-model="form.companyOwnerPhone" placeholder="负责人手机" />
											</div>
										</div>
										<div class="form-row require">
											<span class="row-label menustyle">运营负责人</span>
											<div class="row-content contentstyle">
												<input name="operationManager" type="text" class="text" iname="运营负责人" v-model="form.companyOwner" placeholder="运营负责人" />
											</div>
										</div>

										<div class="form-row require">
											<span class="row-label menustyle">负责人手机：</span>
											<div class="row-content contentstyle">
												<input name="operationManagerPhone" type="text" class="text" iname="负责人手机" v-model="form.companyOwnerPhone" placeholder="负责人手机" />
											</div>
										</div>

										<div class="form-row">
											<span class="row-label menustyle">所在区域：</span>
											<div class="row-content contentstyle">
												<select name="province"  class="select" >													
													<template v-for="item in provinces">
                                                        <option value={{item.name}}>{{item.name}}</option>
                                                    </template>
													
												</select>
												<select name="city"  class="select" >
													
													<template v-for="item in citys">
                                                        <option value={{item.name}}>{{item.name}}</option>
                                                    </template>
													
												</select>
												
												<select name="county"  class="select">
                                                    <template v-for="item in areas">
                                                        <option value={{item.name}}>{{item.name}}</option>
                                                    </template>
                                                </select>
											</div>
											
										</div>

										<div class="form-row">
											<span class="row-label menustyle">联系地址：</span>
											<div class="row-content contentstyle">
												<input name="address" type="text" class="text" iname="联系地址" v-model="form.address" placeholder="联系地址" />
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
			<form action="json/action.json" method="post">
				<div class="align-center remove-content">确定要删除该业务吗？</div>
				<input type="hidden" name="id" value="{{id}}" />
			</form>
		</script>

		<script type="text/template" id="item/add" note="添加业务">
			<style>
				.remove-content {
					padding: 10px;
					color: red;
				}
			</style>
			<form >
				<!--<div class="loading">加载中...</div>-->
				<input type="hidden" name="bid" :value="bid" />
				<input type="hidden" name="items" :value="itemsJson" />
				<div class="form-row">
					<span class="row-label1">业务名称：</span>
					<div class="row-content contentstyle">
						<div class="row-value">
							<p>车辆清洗</p>
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
								<template v-if="itemsJson!='[]'">	
									<tr v-for="item in serviceList">
									<td class="align-left">
										<input type="hidden" v-model="item.notdo" />
										<template v-if="item.notdo">
											<!--<input type="checkbox" id={{item.flag}} v-model="item.checked" disabled="disabled">-->
											<input type="checkbox" id={{item.flag}} checked="checked" disabled="disabled">
										</template>
										<template v-else>
											<input type="checkbox" id={{item.flag}} v-model="item.checked" >
										</template>
									</td>
										<td class="align-left">
											<label for={{item.flag}} v-text="item.name"></label>
										</td>
										<td class="align-left">
											<span class="rmb"><input type="number" class="text-150" v-model="item.oldPrice" :disabled="!item.checked" iname="原价" placeholder="原价"  /></span>
										</td>
										<td class="align-left">
											<span class="rmb"><input type="number" class="text-150" v-model="item.price"  :disabled="!item.checked" iname="现价" placeholder="现价" /></span>
											<input type="hidden" :value="expireTime">
											<input type="hidden" :value="sdate">
											<input type="hidden" :value="edate">
										</td>
									</tr>
								</template>
								<template v-if="itemsJson==='[]'">
									<tr>
										<td class="align-left">
											<p>暂无新业务</p>
										</td>
									</tr>
								</template>
							</tbody>
						</table>

					</div>
				</div>
					<div class="form-row">
						<span class="row-label1">订单有效期：</span>
						<div class="row-content contentstyle">
							<input name="account" type="number" class="text text-80" v-model="expireTime" iname="有效期" itip="有效期" placeholder="有效期" /><span class="unit">天</span>
						</div>
					</div>
					<div class="form-row">
						<span class="row-label1">营业时段：</span>
						<div class="row-content contentstyle">
							<input type="text" class="text text-100" iname="开始时间" itip="开始时间"  placeholder="开始时间"  v-model="sdate" datetimepicker/>
                             <span>至</span>
                        	<input type="text" class="text text-100" iname="结束时间" itip="结束时间"  placeholder="结束时间"  v-model="edate" datetimepicker/>	
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

					Action.extend({
		                'form.detail' : '/car-platform/business/info/search?id={id}',
						'form.service':'/car-platform/business/wash/service/detail?bid={bid}&serviceId={serviceId}',
						'form.notinstall':'/car-platform/business/goods/list?serviceId=0',

						'form.area':'/car-platform/business/info/allCounty/get',
						'form.password':'/car-platform/business/admin/user/password/update',
						'form.check':"/business/info/admin/username/check?adminName={adminName}",
						
						'form.updatesave':'/car-platform/business/info/update',
						'form.addsave':'/car-platform/business/info/add'
					})
					
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
						
						getNotinstall:function(){
							var dtd = $.Deferred();
							var url;
							var	tmpbid={
									bid:' '
								}
							var url = Action.get("form.notinstall",tmpbid);
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
							var defaultData = {};

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
						
						matchData:function(obj){
                        	var list=[];
                        	obj.forEach(function(item,index){
                        		list.push({
									body: item.name,
									goodsId: item.id,
									serviceFlag:item.flag,
									serviceId:0,
									status:0,
									expireTime:item.expireTime,
									oldPrice:item.oldPrice,
									price:item.price,
									tips:item.tips
								})
                        	})
                        	return list;
                        },
                        
                        convertData:function(obj1,obj2){
							var list=[];
					    	list=obj2.map(function(item2,index2){
					    		var value=item2;
					    		obj1.every(function(item,index1){
						    		if(item.flag==item2.flag){
						    			item.notdo="true";
						    			value=item;
						    			return false;
						    		}
						    		return true;
					    		})
					    		return value;
					    	})
				    		return list;
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
										serviceItem: [],
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
									'ITEMS':function(){
										return JSON.stringify(App.matchData(this.serviceItem));
									},
									'serviceItemLen':function(){
										return this.serviceItem.length;
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
									addData:function(){
										var that=this;
										App.getNotinstall().then(function(data) {
											var testList=App.convertData(that.serviceItem,data);
											App.addItem(testList).then(function(result){
												result.forEach(function(item,index){
													that.serviceItem.push(item);
												})
												
											})
										})
										.fail(function(msg) {
											App.alert(msg)
										})
									},
									removeData:function(tmp){
                                        var that=this;
                                        App.removeItem(tmp).then(function(result){
                                        	that.serviceItem=[];
//                                      	console.log("serviceItem-->",JSON.stringify(that.serviceItem));
//                                          that.serviceItem.forEach(function(value,index){
//                                              if(result.flag===value.flag){
//                                                  if(index==0){
//                                                      that.serviceItem.splice(0,1);
//                                                  }else{
//                                                      that.serviceItem.splice(index,1); 
//                                                  }
//                                              }
//                                          })
                                        })
                                        
                                        /* return that.serviceItem; */
                                    },
								}

							})

						},
						initDatePicker:function(){
                            
                            $('[datetimepicker]').datetimepicker({
                                format: "hh:ii",
                                autoclose: true,
                                language:'zh-CN',
                                weekStart: 1, 
                                autoclose: 1, 
                                todayHighlight: 1,//高亮显示目前的时间
                                startView: 1,
                                minView: 0,
                                minuteStep: 15,
                                maxView: 1,
                                forceParse: 0
                            });
                            
                            $(".datetimepicker").find('.prev , .switch , .next').css('visibility','hidden');
                            
                        },
						getService: function(form,item) {
							var dtd = $.Deferred();
							var test = {
								bid: form.id,
								serviceId:item.id
							}
							var url  = Action.get("form.service");
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
							var title = "警告";
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
						

                        removeItem: function(data) {
                            var dtd=$.Deferred();
                            //tmpServiceItem
                            var id = "item/remove";
                            var title = "警告";
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
                                    value: "确定删除",
                                    autofocus: true,
                                    callback: function() {
                                        dtd.resolve(data);
                                        idialog.remove();
//                                      Modal.tip('删除成功', Modal.MsgType.SUCCESS);
                                        return false;
                                    }
                                }]
                            }).showModal();
                            return dtd;
                        },
                        
						addItem: function(data,timeObj) {
							var app = this;
		                    var dtd = $.Deferred();
							if(data.length==0){
								App.alert("暂无新业务")
							}else{
								var id = "item/add";
								var tmpServiceItem;
								var title = document.getElementById(id).title || "设置业务";
								
								var timeObj={
									myExpireTime:'',
									mySdate:'',
									myEdate:''
								}
								
			                    var tplDom = document.getElementById(id);
			                    var content=tplDom.innerHTML;
			                    
			                    
//			                    var idialog=dialog({
//		    						title: '设置业务',
//		    						width:650,
//		    						z-index:5
//		    					}).showModal();
		    					
			                    
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
													var that=this;
													tmpServiceItem=that.serviceList;
													that.serviceList.forEach(function(item,index){
														item.expireTime=that.expireTime;
														item.sdate=that.sdate;
														item.edate=that.edate;
													})
			                        				return JSON.stringify(that.serviceList);
			                        			}
			                        		},
			                        		data:function(){
			                        			return {
			                        				bid:search.id,
			                        				serviceList:data,
													expireTime:timeObj.myExpireTime,
													sdate:timeObj.mySdate,
													edate:timeObj.myEdate,
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
			                        width:650,
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
				                                    
				                                	var itemList=[];
				                                	tmpServiceItem.forEach(function(item,index){
				                                		if(item.checked===true){
				                                			item.tips=item.sdate+"~"+item.edate;
				                                			
				                                			delete item.checked;
				                                			delete item.sdate;
				                                			delete item.edate;
				                                			itemList.push(item);
				                                		}
				                                	})
				                                	
													dtd.resolve(itemList);
				                                	idialog.remove();
				                                }).fail(function(e){
				                                	app.alert(e.msg)
				                                });
				                                	
												return false;
			                                	
			                                }
			                            }
			                        ]
			                    }).showModal().reset();
			                    
							}
		                   	return dtd;
							
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
						isRepeat:function(){
							//4003,账号已存在;200,正常
							var $adminName=$("#adminName");
							var adminName=$adminName.val();
							if(adminName){
								var tmp={
									adminName:adminName
								}
								var url=Action.get('form.check',tmp);
								
								$.getJSON(url,function(result) {
									var code = result.code;
									if(code == 4003){
										var msg = Action.getResultMsg(result);
										$("#repeat-check").show();
										Modal.alert(msg, Modal.MsgType.ERROR);
									}
								})
								.fail(function(e, type, msg) {
									Modal.alert(msg, Modal.MsgType.ERROR);
								})
								
							}
						},
						initEventListen:function(){
							var that=this;
							$("#adminName").blur(function(){
								that.isRepeat();
							});
							$("#adminName").focus(function(){
								$("#repeat-check").hide();
							});
							
						},
						init: function() {
							var app = this;
							$.when(this.getAppData(),this.getArea())
							.then(function(data,area) {
								data.area=area;
								app.initForm(data);
								app.initDOMEvents();
								app.initEventListen();
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