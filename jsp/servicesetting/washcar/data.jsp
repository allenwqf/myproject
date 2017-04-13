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
    <title>业务设置-车辆清洗</title>
    <c:import url="/public/head-tag.jsp" />
    <style>
        .table-middle td {
            vertical-align: middle;
        }
        .select-col-2 {
            width:100px;
            margin-left: 20px;
        }
        .text-100{
        	width: 130px;
        }
        .text1000{
            width: 600px;
        }
        .itemtitle{
            display: flex;
            /*height: 100px;
            padding-left: 50px;*/
        }
        .title-breif{
        	width: 500px;
		    line-height: 20px;
        }
        .itemmodify{
            margin-top: 35px;
        }
        .itemdeposit{
		    margin-left: 50px;
		    margin-top: 15px;
            line-height: 30px;
        }
        .itemlogo{
            width: 60px;
		    height: 60px;
		    padding-top: 20px;
		    padding-left: 20px;
        }
        .title-h3 {
            font-size: 160%;
            font-weight: 500;
        }
        .dialog-overflw{
        	overflow: auto;
        }
    </style>
</head>
<body>
<c:import url="/public/header.jsp" />
<section class="container">

    <c:set var="sidebar" scope="request" value="serviceSetting" />
    <c:set var="navbar" scope="request" value="washCar" />
    <c:import url="/public/sidebar.jsp"/>

    <div class="content" >
        <div class="content-top">
            <h3 class="content-title">
                <div class="bread">
                    <span>车辆清洗</span>
                </div>
            </h3>
        </div>
        <div class="content-main">
                <div class="content-item-top" id="app">
                    <form action="/car-platform/business/service/search?id=0" method="get"
                          autocomplete="off">
                        <input type="hidden" name="id" v-text="form.id"/>
                        <div class="itemtitle">
                            <template v-if="form.icon">
                                <img :src="showImage(form.icon)" class="itemlogo" />
                            </template>
                            <template v-else>
                                <img src="/assets/car/wash/logo.png"  class="itemlogo" />
                            </template>
                            <div class="itemdeposit">
                                <div class="title-h3" v-text="form.title"></div>
                                <div class="title-breif" v-text="form.brief" ></div>
                                <p style="letter-spacing: 5px">保证金：<b class="rmb" v-text="form.deposit"></b></p>
                            </div>
                            
                            <div class="content-action itemmodify">
                                <a href="javascript:" @click="edit(form.id,0)" class="action-item">编辑描述</a>
                                <a href="javascript:" @click="edit(form.id,1)" class="action-item">修改设置</a>
                            </div>
                        </div>
                    </form>
                </div>
                
             <section class="content-item" data-template="item/list" id="box">
                
                <div class="content-item-top">
                    <form action="/car-platform/order/business/listSearch" method="get" autocomplete="off">
                    <input type="hidden" name="page" value="1" />
                        <div class="filter-item">
                        	<label >业务状态</label> 
                          <select name="status" class="select text-100">
                            <option value="">全部</option>
                            <option value="0">未支付</option>
                            <option value="7">商家提交审核</option>
                            <option value="1">开通</option>
                            <option value="9">审核未通过</option>
                            <option value="2">暂停</option>
                            <option value="4">申请关闭</option>
                            <option value="5">关闭已退款</option>
                            <option value="6">支付成功</option>
                          </select>
                        </div>
                        <div class="filter-item" id="appArea">
                        	<label>所在区域</label>
                            <select name="county" class="select">
	                        	<option value="">全部</option>
                            	<template v-for="(index, item) in area">
                            		<option :value="index">{{index}}</option>
                            	</template>
	                        </select>
                        </div>
                        <div class="filter-item">
                        	<label>支付方式</label>
                            <select name="channel" class="select">
                            	<option value="">全部</option>
	                            <option value="alipay_pc_direct">支付宝</option>
	                            <option value="offline">对公转账</option>
	                        </select>
                        </div>
                        <div class="filter-item"><label>时间</label>
                            <input type="text" class="text text-100" placeholder="开始时间" name="sdate" date-range/>
                            <span>至</span>
                            <input type="text" class="text text-100" placeholder="结束时间"  name="edate" date-range/>
                        </div>
                        <div class="filter-item">
                        	<label>搜索</label>
                            <input type="text" class="text text-100" name="like" placeholder="商家名称 " id="search-input"/>
                            <input type="submit" class="btn btn-search"  value="搜索" id="search-button"/>
                            <a data-href="/car-platform/order/business/export?" id="exportBtn" target="_blank" class="btn btn-default">导出数据</a>
                        </div>
                    </form>
                </div>

                <div class="content-item-block">
                    <table class="table table-middle">
                        <thead>
                        <tr>
                            <th style="width: 10%">更新时间</th>
                            <th style="width: 10%" class="align-left">商家名称</th>
                            <th style="width: 10%" class="align-left">所在区域</th>
                            <th style="width: 8%" class="align-left">状态</th>
                            <th style="width: 8%" class="align-left">支付方式</th>
                            <th style="width: 5%" class="align-center">操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td class="align-center" colspan="5">
                                <div class="loading">加载中...</div>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>

            </section>
        </div>
    </div>
</section>
<script id="item/list" type="text/template">
    {{if  !code }}
    <tr><td colspan="5" class="color-red">查询错误！</td></tr>
    {{else if code!=200}}
    <tr><td colspan="5" class="color-red">{{msg || '查询错误！'}}</td></tr>
    {{else if !data.list || data.list.length==0}}
    <tr><td colspan="5">没有记录！</td></tr>
    {{else}}
    {{each data.list as item}}
    <tr>
        <td class="align-left">
        	{{if item.createTime}}
	            <p>{{item.createTime | dateFormat:'yyyy-MM-dd HH:mm'}}</p>
            {{else}}
        		<p>-</p>
    		{{/if}}
        </td>
        <td class="align-left">
            <p>{{item.businessName}}</p>
        </td>
        <td class="align-left">
            <p>{{item.businessCounty}}</p>
        </td>
        <td class="align-left">
            {{ if item.status==0}}
                <span class="state">未支付</span>
            {{/if}}
            {{ if item.status==7}}
                 <span class="state">未审核</span>
            {{/if}}
            {{ if item.status==1}}
                 <span class="state">开通</span>
            {{/if}}
            {{ if item.status==3}}
                <span class="state">审核未通过</span>
            {{/if}}
            {{ if item.status==2}}
                <span class="state-red">暂停</span>
            {{/if}}
            {{ if item.status==4}}
                <span class="state-red">申请关闭</span>
            {{/if}}
            {{ if item.status==5}}
                <span class="state-red">关闭已退款</span>
            {{/if}}
            {{ if item.status==6}}
                <span class="state">支付成功</span>
            {{/if}}
            {{ if item.status==9}}
                <span class="state-red">审核未通过</span>
            {{/if}}
        </td>
        <td class="align-left">
        	{{if item.channel=="alipay_pc_direct"}}
        		<p>支付宝</p>
        	{{else if item.channel=="offline"}}
        		<p>对公转账</p>
        	{{else}}
        		<p>-</p>
        	{{/if}}
        </td>
        
        </td>
        <td class="align-center">
        	{{if item.status != 0}}
	            <a href="javascript:;" data-action="item.preview" data-params="{{item | pick:'id' | toJSON}}" class="action-link">预览</a>
	        {{/if}}
            {{ if item.status == 7}} 
                <a href="javascript:;" data-action="item.pass" data-params="{{item | pick:'id' | toJSON}}" class="action-link">通过</a>
                <a href="javascript:;" data-action="item.reject" data-params="{{item | pick:'id,status' | toJSON}}"  class="action-link">驳回</a>
            {{/if}}
            {{if item.status == 1}}
        		<a href="javascript:;" data-action="item.pause" data-params="{{item | pick:'id' | toJSON}}" class="action-link">暂停</a>
        	{{/if}}
		    {{if item.status == 2}}
	        	<a href="javascript:;" data-action="item.recover" data-params="{{item | pick:'id,status' | toJSON}}"  class="action-link">恢复</a>
            {{/if}}
            {{if item.status == 4}}
                <a href="javascript:;" data-action="item.closed" data-params="{{item | pick:'id,status' | toJSON}}"  class="action-link">关闭</a>
            {{/if}}
            {{if item.status == 0}}
	            {{if item.channel == "offline" }}
	        		<a href="javascript:;" data-action="item.channel" data-params="{{item | pick:'id' | toJSON}}" class="action-link">确认收款</a>
	        	{{else}}
	            	<p>-</p>
	        	{{/if}}
	        {{/if}}
	        
        </td>
    </tr>
    {{/each}}
    {{/if}}
</script>

<script type="text/template" id="order/refund" title="订单退款">
    <style>
        .refound-tip a{
            text-decoration: underline;
        }
    </style>
    <form action="/car-platform/order/refund" method="post" @submit.prevent="submit($event)">
        <div class="form-block form-block-refund">
            <div class="form-row">
                <span class="row-label">订单号：</span>
                <div class="row-content">
                    <p class="row-value" v-text="data.id"></p>
                </div>
            </div>
            <div class="form-row">
                <span class="row-label">退款金额：</span>
                <div class="row-content">
                    <p class="value-note"><b class="rmb" v-text="data.payAmount"></b></p>
                </div>
            </div>
            <div class="form-row form-theme2">
                <span class="row-label">退款备注：</span>
                <div class="row-content">
                    <textarea name="description" v-model="note" class="textarea" irequired="false" iname="退款备注" placeholder="请输入退款备注" style="height:100px;width:100%;"></textarea>
                </div>
            </div>

            <div v-if="refound_url" class="form-row form-theme2">
                <span class="row-label">退款提示：</span>
                <div class="row-content">
                    <div class="row-value">
                        <p class="refound-tip">请点击<a href="{{refound_url}}" @click="go2refound" class="action-link" target="_blank">退款链接</a>，按流程操作成功后再回来 </p>
                    </div>
                </div>
            </div>
            <div class="form-row form-theme2 form-row-btn">
                <div class="row-content">
                    <button v-if="mstatus==AppStatus.READY || mstatus==AppStatus.PENDING" class="btn btn-large btn-default" :class="mstatus==AppStatus.PENDING?'btn-loading':''">确认退款</button>
                    <template v-if="mstatus==AppStatus.REFOUNDING">
                        <button  class="btn btn-large btn-default" @click="refoundSuccess">已退款</button>
                        <button  class="btn btn-large" @click="refoundFail">未退款</button>
                    </template>
                </div>
            </div>
        </div>
        <input type="hidden" v-model="data.id" name="orderId"/>
        <input type="hidden" v-model="data.chargeId" name="chargeId"/>
    </form>
</script>


<script type="text/template" id="item/reject" note="是否驳回">
    <style>
        .remove-content{padding:10px;color:red;}
        .text106{width:80%}
    </style>
    <form action="/car-platform/order/business/status/reject" method="post">
        <input type="hidden" name="id" value="{{id}}" />
            <p class="remove-content">驳回原因：</p>
        <div class="form-row" >
            <div class="row-content">
                <textarea name="checkResult" class="text106"></textarea>
            </div>
        </div>
    </form>
</script>

<script type="text/template" id="item/channel" note="确认收款">
    <style>
        .msg-tip{margin: 30px;}
    </style>
    <form action="/car-platform/order/business/status/paid" method="post">
        <input type="hidden" name="id" value="{{id}}" />
        <div class="msg-tip">请确定保证金是否到账；确定到账后，才可点击确认按钮</div>
    </form>
</script>

<script type="text/template" id="item/pause" note="是否暂停">
    <style>
        .remove-content{padding:10px;color:red;}
    </style>
    <form action="/car-platform/order/business/status/update" method="post">
        <input type="hidden" name="id" value="{{id}}" />
        <div class="form-row" >
            <span class="row-label">商家状态：</span>
            <div class="row-content">
                <select class="select select-col-1" name="status">
                    <option value="2"  {{ status == '2'?'selected="selected"':''}} >暂停</option>
                    <option value="1"  {{ status == '1'?'selected="selected"':''}} >正常</option>
                </select>
            </div>
        </div>
    </form>
</script>

<script type="text/template" id="item/pass" note="是否通过">
    <style>
        .remove-content{padding:10px;color:red;}
        .text106{width:80%}
    </style>
    <form action="/car-platform/order/business/status/adopt" method="post">
        <input type="hidden" name="id" value="{{id}}" />
            <p class="remove-content">重要提示：</p>
            <blockquote style="padding:10px">
                <p>通过业务审核，商家的此项业务将直接上线</p>
                <!--<p>是否确认通过审核？如果确认通过请输入管理员密码</p>-->
            </blockquote>
        <!--<div class="form-row" >
            <div class="row-content">
                <input type="password" class="text106" name="password" />
            </div>
        </div>-->
    </form>
</script>

<script type="text/template" id="item/colse" note="是否关闭">
    <style>
        .remove-content{padding:10px;color:red;}
        .text106{width:80%}
    </style>
    <form action="/car-platform/order/business/status/close" method="post">
        <input type="hidden" name="id" value="{{id}}" />
            <p class="remove-content">重要提示：</p>
            <blockquote style="padding:10px">
                <p>该操作将关闭门店的业务资质，门店将不可再开展该业务。</p>
                <p>如果你确定要这样做，请在下面输入支付密码确认。</p>
            </blockquote>
        <div class="form-row" >
            <div class="row-content">
                <input type="password" class="text106" name="password" />
            </div>
        </div>
    </form>
</script>


<script type="text/template" id="item/preview" note="预览">
	<style type="text/css">
		.preDiv{height:700px;overflow: auto;}
	</style>
	{{if serviceContent!=null}}
		<div class="preDiv">{{#serviceContent}}</div>
	{{else}}
		<div style="text-align: center;line-height: 50px;">商家还未提交详细的服务标准。</div>
	{{/if}}
</script>



<script src="/pages/assets/js/require.all.js?v=4293636e2ff5c4a96b189a7661023e42"></script>
<script>
    require.config({
           paths:{
               vue:'libs/vue/2.0.0/vue'
           }
       })
    requirejs([
                'vue',
                'artTemplate',
                'artDialog',

                'vender.actions',
                'vender.modal',
                'utils.search',
                
                
                'jquery.daterangepicker',
                
                'jquery.formcheck',
                'jquery.ajaxsubmit',
                'jquery.common',
                'jquery.pager'
            ],
            function(Vue, template, dialog, Action, Modal,Search){
                Action.extend({
                    'form.detail' : '/car-platform/business/service/search?id={id}',
                    'form.url':'/car-platform/business/service/editPage?id={id}&mode={mode}',
                    'form.preview':'/car-platform/order/business/service/standards/detail?id={id}',
                    'form.area': '/car-platform/business/info/allCounty/get'
                })
                var search = new Search().getParams();
                var isEdit = !!search.id;
                
                var totalItem;
                
            	var Bstatus={
            		NOPAY : 0,
            		NOCHECK : 1,
            		OPEN : 2,
            		REJECT : 3,
            		PAUSE : 4,
            		CLOSE : 5,
            		REFUND : 6
            	}
                
                var App = {
                    alert: function() {
                        alert(arguments[0]);
                    },
                    
                    reloadItems: function() {
                        $("#box").reload();
                    },
                    getArea: function() {
						var dtd = $.Deferred();

						var url = Action.get('form.area');
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
                    getAppData :function(){
                        var dtd = $.Deferred();
                        
                        var that=this;
                        var defaultData ={
                            
                        };
                        
                        var tmp={
                            id:"0"
                        }
                        var url = Action.get('form.detail',tmp);
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
                        return dtd;
                    },
                    /*tmpObj={
                    	"id":"item/reject"	,
                    	"data":"data",
                    	"titile":"驳回业务：车辆清洗"
                    }*/
                   
                   getPreview :function(data){
                        var dtd = $.Deferred();
                        var url = Action.get('form.preview',data);
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
                        return dtd;
                    },
                    
                    dialogContent:function(tmpObj){
                        var content = template(tmpObj.id, tmpObj.data);
                        var idialog = dialog({
                            id: tmpObj.id,
                            zIndex: 5,
                            width: 460,
                            padding: "10px 20px",
                            title: tmpObj.title,
                            content: content,
                            button: [{
                                id: "cancel",
                                value: "取消"
                            }, {
                                id: "ok",
                                value: "确定",
                                autofocus: true,
                                callback: function() {
                                    var $form = this.getContent().find("form");
                                    $form.ajaxSubmit({
                                        onSuccess: function(result) {
                                            var code = result.code;
                                            if (code == 200) {
                                                idialog.remove();
                                                App.reloadItems();
                                            } else {
                                                var msg = result.msg || "提交失败！";
                                                App.alert(msg);
                                            }
                                        }
                                    })
                                    return false;
                                }
                            }]
                        }).showModal();
                    },
                    
                    rejectItem: function(data) {
                        var tmpObj={
                       		"id":"item/reject" ,
                            "data":data,
                            "titile":"驳回业务：车辆清洗"	
                        }
                        App.dialogContent(tmpObj);
                    },
                
                    passItem: function(data) {
                    	var tmpObj={
                            "id":"item/pass" ,
                            "data":data,
                            "titile":"通过业务：车辆清洗"    
                        }
                        App.dialogContent(tmpObj);
                    },
                    closeItem: function(data) {
                        var tmpObj={
                            "id":"item/colse" ,
                            "data":data,
                            "titile":"关闭业务：车辆清洗"    
                        }
//                      App.dialogContent(tmpObj);
                        
                        var content = template(tmpObj.id, tmpObj.data);
                        var idialog = dialog({
                            id: tmpObj.id,
                            zIndex: 5,
                            width: 460,
                            padding: "10px 20px",
                            title: tmpObj.title,
                            content: content,
                            button: [{
                                id: "cancel",
                                value: "取消"
                            }, {
                                id: "ok",
                                value: "确定",
                                autofocus: true,
                                callback: function() {
                                    var $form = this.getContent().find("form");
                                    $form.ajaxSubmit({
                                        onSuccess: function(result) {
                                            var code = result.code;
                                            if (code == 200) {
                                            	Modal.alert(result.data, Modal.MsgType.SUCCESS);
                                                idialog.remove();
                                                App.reloadItems();
                                            } else {
                                                var msg = result.msg || "提交失败！";
                                                Modal.alert(msg, Modal.MsgType.ERROR);
                                                App.alert(msg);
                                            }
                                        }
                                    })
                                    return false;
                                }
                            }]
                        }).showModal();
                        
                        
                    },
                    setChannel:function(data){
                    	var tmpObj={
                           "id":"item/channel" ,
                           "data":data,
                           "title":"确认收款"    
                       }
                       App.dialogContent(tmpObj);
                    },
                    
                    pauseItem: function(data) {
                        var tmpObj={
                           "id":"item/pause" ,
                           "data":data,
                           "title":"是否暂停：车辆清洗"    
                       }
                       App.dialogContent(tmpObj);
                    },
					previewPage: function(url) {
                        var settings = 'toolbar=yes, location=yes, directories=no, status=no, menubar=yes, scrollbars=yes, resizable=no, copyhistory=yes, width=414, height=736'
                        var windowWidth = $(window).width();
                        var left = windowWidth / 2 - 160;
                        settings += ',top=100,left=' + left;
                        var opener = window.open(url, "_blank", settings)
                    },
                    initDatePicker:function(){
                        var $dates=$("[date-range]").dateRangePicker({
                            separator : '至',
                            getValue: function(){
                                return '';
                            },
                            setValue: function(s,s1,s2){
                                return false;
                            },
                            endDate:new Date(),
                            shortcuts: {
                                'prev-days': [1,3,5,7],
                                'prev' : ['week','month','year'],
                                'next-days': null,
                                'next': null
                            }
                        })
                        .on("datepicker-apply",function(e,date){
                            $dates.eq(0).val(date.date1.format('yyyy-MM-dd'));
                            $dates.eq(1).val(date.date2.format('yyyy-MM-dd'));
                            $(this).parents("form:first").submit()
                        })
                    },
                    showPreview:function(data){
                    	var tmpObj={
                            "id":"item/preview" ,
                            "data":data,
                            "titile":"预览"  
                        }
                    	
                    	var content = template(tmpObj.id, tmpObj.data);
                        var idialog = dialog({
                            id: tmpObj.id,
                            zIndex: 5,
                            width: 460,
                            padding: "10px 20px",
                            title: tmpObj.title,
                            content: content,
                            button: [{
                                id: "ok",
                                value: "关闭",
                                autofocus: true,
                                callback: function() {
                                    idialog.remove();
                                }
                            }]
                        }).showModal().reset();
                    	
                    },
                    initForm:function(formData){
                        var that=this;
                        new Vue({
                            el:'#app',
                            data:{
                                form:formData
                            },
                            computed:{
                            },
                            methods:{
                                showImage:function(img){
                                    if(/^(http(s)?|\/\/)/.test(img)) return img;
                                    return Action.get('image.logo', img)
                                },
                                edit:function(data,flag){
                                	var tmp={
			                            id:data,
			                            mode:flag,
			                            Bstatus:Bstatus
			                        }
                                    var url=Action.get('form.url',tmp)
                                    location.href=url;
                                }
                            }
                        })
                    },
                    
                    initArea:function(tmpArea){
                        var that=this;
                        new Vue({
                            el:'#appArea',
                            data:{
                                area:tmpArea
                            }
                        })
                    },
                    
                    
                    initEvent:function(){
                    	
                    	$("body").on("click", "[data-action]", function() {
                            var $this = $(this);
                            var action=$this.data("action");
                            var data=$this.data("params");
                            if(action==='item.reject'){
                                App.rejectItem(data);
                            }else if(action==='item.pause'){
                                App.pauseItem(data);
                            }else if(action==='item.closed'){
                                App.closeItem(data);
                            }else if(action==='item.pass'){
                            	App.passItem(data);
                            }else if(action==='item.preview'){
                            	App.getPreview(data).then(function(value){
                            		App.showPreview(value);
                            	});
                            }else if(action==='item.recover'){
                            	App.pauseItem(data);
                            }else if(action==='item.channel'){
                            	App.setChannel(data);
                            }

                            return false;
                        })
                    },
                    
                    init: function() {
                        var app = this;
                       $.when(app.getAppData(),app.getArea() )
                        
                        .then(function(data,dataArea){
                            
                            app.initForm(data);
                            app.initArea(dataArea);
                            
                            $("[data-template]").ajaxLoad({
	                            beforeSubmit:function(){
	                                var $extBtn=$("#exportBtn");
	                                var href=$extBtn.data('href');
	                                var params=$(this).find("form").serialize();
	                                $extBtn.attr('href',href+params);
	                            },
	                            dataFilter:function(res){
	                                return res}
	                        });
	                        app.initDatePicker();
	                        app.initEvent();
                            
                        })
                        .fail(function(msg){
                            app.alert(msg)
                        })

                       
                        
                   },
               }
                App.init();
            })
</script>
</body>
</html>