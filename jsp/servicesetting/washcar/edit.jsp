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
		<title>车辆清洗</title>
		<c:import url="/public/head-tag.jsp" />
		<style>
			/* 必需 */
			
			.textarea {
				width: 60%;
				height: 300px;
				max-height: 300px;
				border: 0px solid #B8B8B8;
			}
			
			.xiuxiu-upload-container,
			div.xiuxiu-upload {
				width: 100px;
				height: 100px;
			}
			
			.test100 {
				padding: 5px 5px;
				border: 1px solid #B8B8B8;
				width: 360px;
			}
			
			.tab_bar {
				width: 20%;
				min-width: 200px;
				border: 1px solid #5BAFBF;
			}
			
			.logo-letter {
				letter-spacing: 7px
			}
			
			.wangEditor-txt {
				height: auto!important;
			}
			
			.row-label-100 {
				width: 100px;
			}
			
			.row-content-30 {
				padding-left: 30px;
			}
			
			.text-80 {
				width: 80px;
			}
			
			.unit {
				padding-left: 10px;
			}
		</style>
	</head>

	<body>

		<c:import url="/public/header.jsp" />

		<section class="container">

			<c:set var="sidebar" scope="request" value="serviceSetting" />
			<c:set var="navbar" scope="request" value="washCar" />
			<c:import url="/public/sidebar.jsp" />
			<div class="content" id="app">
				<div class="content-top">
					<h3 class="content-title">
                    <div class="bread">
                        <a href="/car-platform/business/service/searchPage">车辆清洗</a>
                        <span>&gt;</span>
                        <template v-if="flag==0">
	                        <span>编辑描述</span>
                        </template>
                        <template v-if="flag==1">
	                        <span>修改设置</span>
                        </template>
                    </div>
                </h3>
				</div>
				<template v-if="flag==0">
					<div class="content-main">
						<div class="block-content">
							<div class="form-block">
								<form id="form1" action="/car-platform/business/service/update"  method="post" goback="/car-platform/business/service/searchPage">
									<div class="form-row">
										<input name="id" type="hidden" v-model="program.id">
										<input type="hidden" name="title" v-model="program.title" />
										<span class="row-label">业务名称：</span>
										<div class="row-content">
											<div class="row-value">
												<span v-text="program.title"></span>
											</div>
										</div>
									</div>

									<div class="form-row">
										<span class="row-label logo-letter">logo:</span>
										<div class="row-content">
											<div xx-upload class="xiuxiu-upload-container">
												<textarea type="config" style="display:none;" v-text="getImageConfig(program.icon) | json"></textarea>
											</div>
											<p class="value-note">图片规格：100x100</p>
										</div>
									</div>

									<div class="form-row">
										<span class="row-label">业务描述：</span>
										<div class="row-content">
											<div class="row-value">
												<textarea name="brief" class="test100" v-text="program.brief"></textarea>
											</div>
										</div>
									</div>

									<div class="form-row">
										<span class="row-label">业务详情：</span>
										<div class="row-content">
											<ul class="tab-labels tab_bar">
												<li :class="getActiveClass(1)" @click="setDetail(1)">
													<a href="javascript:">业务详情</a>
												</li>
												<li :class="getActiveClass(2)" @click="setDetail(2)">
													<a href="javascript:">平台保障</a>
												</li>
											</ul>

											<div v-show="currentFlag==1">
												<textarea name="contentStandard" rteditor class="textarea" iname="业务详情" v-model="program.contentStandard"></textarea>
											</div>
											<div v-show="currentFlag==2">
												<textarea name="contentFlow" rteditor class="textarea" iname="平台保障" v-model="program.contentFlow"></textarea>
											</div>
										</div>
									</div>

									<div class="form-row">
										<div class="row-content">
											<button class="btn btn-default btn-large" @click="save()">保存</button>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</template>
				<template v-if="flag==1">
					<div class="content-main">
						<section class="content-item" data-template="item/list" id="box">
							<div class="content-item-top">
								<div class="form-block">
									<form id="form1" action="/car-platform/business/service/update" method="post" goback="/car-platform/business/service/searchPage" >
										<div class="form-row">
											<span class="row-label row-label-100">业务名称：</span>
											<div class="row-content row-content-30">
												<input name="id" type="hidden" v-model="program.id">
												<p class="row-value" v-text="program.title"></p>
											</div>
										</div>
										<div class="form-row">
											<span class="row-label row-label-100">业务保证金：</span>
											<div class="row-content row-content-30">
												<input name="deposit" type="text" class="text text-80" v-model="program.deposit" iname="业务保证金" itip="业务保证金" /><span class="unit">元</span>
											</div>
										</div>
										<div class="form-row">
											<span class="row-label row-label-100">开通协议：</span>
											<div class="row-content contentstyle">
												<div class="row-content row-content-30">
													<textarea name="protocol" rteditor v-model="program.opendProtocol" iname="开通协议" itip="开通协议"></textarea>
												</div>
											</div>
										</div>
										<div class="form-row">
											<div class="row-content row-content-30">
												<button class="btn btn-default btn-large" @click="save()">保存</button>
											</div>
										</div>
									</form>

								</div>
						</section>
						</div>
					</div>
				</template>
		</section>

		<script src="/pages/assets/js/require.all.js?v=4293636e2ff5c4a96b189a7661023e42"></script>
		<script>
			requirejs([
					'vue',
					'vender.modal',

					'vender.actions',
					'vender.xxupload',
					'vender.wangeditor',
					'utils.search',

					'jquery.formcheck',
					'jquery.ajaxsubmit',
					'jquery.common',
				],
				function(Vue, Modal, Action, XXUpload, RichTextEditor, Search) {

					Action.extend({
						'form.detail': '/car-platform/business/service/search?id={id}&mode={mode}',
						'form.save': '/car-platform/business/service/update'
					})

					var search = new Search().getParams();
					var isEdit = search.mode;
					var App = {
						alert: function(tip, type) {
							return Modal.alert.apply(this, [tip, null, type]);
						},
						tip: function(msg, type) {
							return Modal.tip(msg, type)
						},
						getFormData: function(data) {
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
							var app = this;
							var vueApp = new Vue({
								el: '#app',
								data: function() {
									return {
										program: formData,
										currentFlag: 1,
										flag: isEdit
									}
								},
								methods: {
									getImageConfig: function(value) {
										return {
											name: 'icon',
											value: value
										}
									},
									save: function() {
										var that = this;
										var $form1 = $('#form1');

										$form1.ajaxSubmitify({
											beforeSubmit: function() {

												//检查图片是否已上传
												// TODO
											}
										})
									},
									setDetail: function(tmp) {
										this.currentFlag = tmp;
									},
									getActiveClass: function(t) {
										if(t == this.currentFlag) return 'current';
										return '';
									}
								},
							})
						},
						init: function() {
							var app = this;
							app.getFormData()
								.then(function(data) {
									app.initForm(data);
									XXUpload('[xx-upload]', { size: '100:100' });
									RichTextEditor('[rteditor]');
								})
								.fail(function(e) {
									App.alert(e)
								})
						}
					}
					App.init();
				})
		</script>
	</body>

</html>