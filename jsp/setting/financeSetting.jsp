<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<!--[if lt IE 7 ]><html class="ie6"><![endif]-->
<!--[if IE 7 ]><html class="ie7"><![endif]-->
<!--[if IE 8 ]><html class="ie8"><![endif]-->
<!--[if IE 9 ]><html class="ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--><html><!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
    <meta name="viewport" content="initial-scale=1,minimum-scale=1" />
    <title>财务设置</title>
    <c:import url="${approot}/public/head-tag.jsp" />
    <style>
        .table-middle td {
            vertical-align: middle;
        }
        .row-value-p {
            margin-left: 70px;
        }
        .menustyle{
            width:100px;
        }
        .select-170{
	        width: 160px;
		    height: 35px;
		    margin-left: 70px;
        }
        .text-100{
        	width: 40%;
        	height: 100px;
        }
    </style>
</head>
<body>
<c:import url="${approot}/public/header.jsp" />
<section class="container">

    <c:set var="sidebar" scope="request" value="setting" />
    <c:set var="navbar" scope="request" value="withdraw" />
    <c:import url="${approot}/public/sidebar.jsp"/>

    <div class="content">
        <div class="content-top">
        	<h3 class="content-title">
        		<div class="bread">
					<span>财务设置</span>
				</div>
    		</h3>
        </div>
        <div class="content-main" id="app">
            <section class="content-item" data-template="item/list" id="box">

                <div class="content-main">
				<div class="block block-main">
									
					<div class="block-content">
						<form id="updateFinanceSettingform" action="/car-platform/finance/setting/update" >
							<div class="form-block">
                                <div class="form-row">
									<span class="row-label menustyle">订单入账规则：</span>
									<div class="row-content row-value-p">
										T+<input name="day" type="number" class="text text-150" style="margin-left:50px"  iname="提现到账规则" v-model="form.day">个工作日
                                        <p class="value-note row-value-p">设置商家订单在交易完成后的几个工作日内无退款<br>等问题，此订单的收入才会划入商家可提现余额。</p>
									</div>
								</div>
                                <div class="form-row">
									<span class="row-label menustyle">提现金额限制：</span>
									<div class="row-content row-value-p">
										单笔<=<input name="withdrawalsMaxAmount" type="number" class="text text-150" style="margin-left:20px"  iname="提现金额限制" v-model="form.withdrawalsMaxAmount">元
									</div>
								</div>
								
								<div class="form-row">
									<span class="row-label menustyle">付款支付密码：</span>
									<div class="row-content contentstyle">
										<div class="row-value">
											<p class="row-value-p"><span>******</span><span><button type="button" data-action="password" class="row-value-p">修改密码</button></span></p>
											<p class="value-note row-value-p">系统初始密码为123456，建议重新设置新密码。</p>
										</div>
									</div>
								</div>
								
								<div class="form-row">
									<span class="row-label menustyle">提现说明：</span>
									<div class="row-content row-value-p">
										<textarea name="withdrawalsInfo" class="text-100" iname="提现说明" v-model="form.withdrawalsInfo"></textarea>
									</div>
								</div>				
							</div>
							<input name="id" type="hidden" value="0">
						</form>
						<div class="form-row form-row-btn">
							<div class="row-value-p">
								<button class="btn btn-default btn-large" data-action="savedata">保存</button>
							</div>
						</div>
					</div>

				</div>
			</div>
            </section>
        </div>
    </div>
</section>

<script type="text/template" id="item/password" note="修改密码">
    <style>
        .psd-content{text-align:center}
    </style>
    <form action="/car-platform/finance/setting/password/update" method="post">
        <div class="psd-content">
            <div class="form-row" >
                <span class="row-label">旧密码：</span>
                <div class="row-content">
                    <input name="oldpassword" type="password" class="text text-150"   placeholder="输入旧密码"  itip="旧密码" iname="旧密码">
                </div>
            </div>
            <div class="form-row" >
                <span class="row-label">新密码：</span>
                <div class="row-content">
                    <input name="newpassword" type="password" class="text text-150"  placeholder="输入新密码"  itip="新密码" iname="新密码">
                </div>
            </div>
            <div class="form-row" >
                <span class="row-label">确认密码：</span>
                <div class="row-content">
                    <input name="newpassword2" type="password" class="text text-150"  placeholder="再次输入新密码" irequired="true" itip="再次输入新密码"  iname="再次输入新密码">
                </div>
            </div>
            <input name="id" type="hidden" value="0">
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
            
            function( Vue, dialog, template, moment, selectLinkage, Search, Modal, Field, Action){
    	        var search = new Search().getParams();
		    	Action.extend({
		            'form.detail' : '/car-platform/finance/setting/search?id=0'
		        })
		        
                var App = {

                    alert: function() {
                        alert(arguments[0]);
                    },
                    editPassword: function() {
                        var id = "item/password";
                        var title = document.getElementById(id).title || "修改密码";
                        var content = template(id);
                        var idialog = dialog({
                            id: id,
                            title: title,
                            content: content,
                            zIndex: 5,
                            width: 420,
                            padding: "0 20px",
                            onshow: function() {
                                //解决当表单中只有一个input:text时按回车自动提交form的问题
                                this.getContent().find("form").on("submit", function(e) {
                                    e.preventDefault();
                                    return false;
                                });
                            },
                            button: [{
                                id: "cancel",
                                value: "取消"
                            }, {
                                id: "ok",
                                value: "确定",
                                autofocus: true,
                                callback: function() {
									var $form = this .getContent().find("form");
									var params= $form.serialize();
									var newObj=$.deParam(params);
									if(newObj.newpassword===newObj.newpassword2){
										$form.ajaxSubmit({
				                            onSuccess: function(result) {
				                                var code = result.code;
				                                idialog.remove();
				                                if (code == 200) {
				                                    Modal.tip("设置成功", Modal.MsgType.SUCCESS);
				                                } else {
				                                    var msg = result.msg || "提交失败！";
				                                    Modal.tip(msg, Modal.MsgType.ERROR);
				                                }
				                            }
				                        })	
									}else{
										App.alert("两次输入新密码不一致，请重新输入");
									}
									
	                                return false;
	                            }
                            }]
                        }).showModal();
                    },
                    savedata:function(){
						var $form = $("#updateFinanceSettingform");
						$form.ajaxSubmit({
                            onSuccess: function(result) {
                                var code = result.code;
                                if (code == 200) {
                                    Modal.tip("设置成功", Modal.MsgType.SUCCESS);
                                    
                                } else {
                                    var msg = result.msg || "提交失败！";
                                    Modal.tip(msg, Modal.MsgType.ERROR);
                                }
                            },
                            onFail:function(e){
                                Modal.tip(e, Modal.MsgType.ERROR);
                            }
                        })
                    },
                    initEventListen:function(){
                        var that=this;
                        var app = this;
						$.when(this.getAppData())
						.then(function(data) {
							app.initForm(data);
						})
						.fail(function(msg) {
							app.alert(msg)
						});
                        $("body").on("click", "[data-action]", function() {
                        	var $this=$(this);
                            var action=$this.data("action");
                            if(action==='password'){
                                App.editPassword();
                            }else if(action==='savedata'){
                            	App.savedata();
                            }

                            return false;
                        })
                    },
                    getAppData: function() {
						var dtd = $.Deferred();

						var that = this;
						var defaultData = {
						};

					
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
						
						return dtd;
					},
                	initForm: function(formData) {
						new Vue({
							el: '#app',
							data: function() {
								return {
									form:formData
								}
					
							},
						})

					},
                    init: function() {
                        App.initEventListen();
                    }
                }
                App.init();
            })
</script>
</body>
</html>