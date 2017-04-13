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
    <title>会员充值</title>
    <c:import url="/public/head-tag.jsp" />
    <style>
        .table-middle td {
            vertical-align: middle;
        }
        .select-col-2 {
            width:100px;
            margin-left: 20px;
        }
    </style>
</head>
<body>
<c:import url="/public/header.jsp" />
<section class="container">

    <c:set var="sidebar" scope="request" value="serviceSetting" />
    <c:set var="navbar" scope="request" value="rechargeList" />
    <c:import url="/public/sidebar.jsp"/>

    <div class="content">
    	
        <div class="content-top">
        	<h3 class="content-title">
        		<div class="bread">
					<span>会员充值</span>
				</div>
            <div class="content-action">
            	<a href="javascript:;" action="item.add" class="action-item icon-add">新增</a>
        	</div>
        </div>
        <div class="content-main">
            <section class="content-item" data-template="item/list" id="box">
                <div class="content-item-top">
                    <form action="/car-platform/user/recharge/service/list" method="get"
                          autocomplete="off">
                    </form>
                </div>

                <div class="content-item-block">
                    <table class="table table-middle">
                        <thead>
                        <tr>
                            <th style="width: 20%">业务套餐</th>
                            <th style="width: 10%" class="align-left">充值金额</th>
                            <!--<th style="width: 10%" class="align-left">赠送金额</th>-->
                            <th style="width: 10%" class="align-center">操作</th>
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
    {{else if !data || data.length==0}}
    <tr><td colspan="5">没有记录！</td></tr>
    {{else}}
    {{each data as item}}
    <tr>
        <td class="align-left">
            <p>{{item.chargeName}}</p>
        </td>
        <td class="align-left">
            <span class="rmb">{{item.realPrice}}</span>
        </td>
        <!--<td class="align-left">
            <span class="rmb">{{item.chargePrice-item.realPrice}}</span>
        </td>-->
        <td class="align-center">
            <a href="javascript:;" action="item.remove" data-params="{{item | pick:'id' | toJSON}}"  class="action-link">删除</a>
        </td>
    </tr>
    {{/each}}
    {{/if}}
</script>

<script type="text/template" id="item/add" note="新增套餐">
    <style>
        .remove-content{padding:10px;color:red;}
    </style>
    <form action="/car-platform/user/recharge/service/add" method="post">
    	<div class="form-row">
             <span class="row-label">套餐名称：</span>
             <div class="row-content contentstyle">
				<input name="chargeName" type="text" class="text"  iname="套餐名称"  placeholder="套餐名称"/>
			</div>
         </div>
    	
          <div class="form-row">
			<span class="row-label">充值金额:</span>
			<div class="row-content contentstyle">
				<input name="chargePrice" type="text" class="text"  iname="充值金额" placeholder="充值金额"/>
				<input type="hidden" name="giveMount" class="text"  value="0"/>
			</div>
		</div>
         
      	<!--<div class="form-row">
             <span class="row-label">赠送金额</span>
             <div class="row-content contentstyle">
                <input type="text" name="giveMount" class="text"  iname="赠送金额"  placeholder="赠送金额"/>
            </div>
        </div>-->
    </form>
</script>



<script type="text/template" id="item/remove" note="业务套餐">
    <style>
        .remove-content{padding:10px;color:red;}
    </style>
    <form action="/car-platform/user/recharge/service/delete" method="post">
        <div class="align-center remove-content">确定要删除该业务套餐吗？</div>
        <input type="hidden" name="id" value="{{id}}" />
    </form>
</script>

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

                var App = {

                    alert: function() {
                        alert(arguments[0]);
                    },

                    reloadItems: function() {
                        $("#box").reload();
                    },

                    addItem: function(data) {
                        var id = "item/add";
                        var title = document.getElementById(id).title || "新增套餐";
                        var content = template(id, data);
                        var idialog = dialog({
                            id: id,
                            title: title,
                            zIndex: 5,
                            width: 420,
                            padding: "0 20px",
                            content: content,
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
                                value: "添加",
                                autofocus: true,
                                callback: function() {
                                    var $form = this.getContent().find("form");
                                    $form.checkForm({promise:true}).then(function(){
                                        var actionURL = "/car-platform/user/recharge/service/add";
                                        var params= $form.serialize();
                                        var tmpPrice=$.deParam(params);
                                        var tmpRealPrice=tmpPrice.chargePrice-tmpPrice.giveMount;
                                        var newPostData={
                                       		id: tmpPrice.id,
                                       		chargeName:tmpPrice.chargeName,
                                       		chargePrice:tmpPrice.chargePrice,
                                       		realPrice:tmpRealPrice
                                        }
                                       $.post(actionURL,newPostData,function(result){
                                    	   var code = result.code;
                                    	   if (code == 200) {
                                               idialog.remove();
                                               App.reloadItems();
                                           } else {
                                               var msg = result.msg || "提交失败！";
                                               App.alert(msg);
                                           }
                                        }).fail(function(e){
                                        	App.alert("操作失败",e);
                                        });
                                    }).fail(function(e){
                                    	App.alert(e.msg)
                                    });
                                    return false;
                                }
                            }]
                        }).showModal();
                    },

                    removeItem: function(data) {
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
                                    var $form = this
                                            .getContent()
                                            .find(
                                                    "form");
                                    $form
                                            .ajaxSubmit({
                                                onSuccess: function(
                                                        result) {
                                                    var code = result.code;
                                                    if (code == 200) {
                                                        idialog
                                                                .remove();
                                                        App
                                                                .reloadItems();
                                                    } else {
                                                        var msg = result.msg || "提交失败！";
                                                        App
                                                                .alert(msg);
                                                    }
                                                }
                                            })
                                    return false;
                                }
                            }]
                        }).showModal();
                    },
                    init: function() {
                        $("[data-template]").ajaxLoad({
                            dataFilter:function(res){
                                return res}
                        });

                        $("body").on("click", "[action]:not(form)", function() {
                            var $this = $(this);
                            var action = $this.attr("action");
                            var data = $this.data("params");
                            if (action == "item.remove") {
                                App.removeItem(data);
                            } else if (action == "item.edit") {
                                App.editItem(data);
                            } else if (action == "item.add") {
                                App.addItem(data);
                            }

                            return false;
                        })
                    }
                }
                App.init();
            })
</script>
</body>
</html>