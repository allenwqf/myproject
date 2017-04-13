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
    <title>商家管理-商家账号</title>
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
<section class="container" id="app">

    <c:set var="sidebar" scope="request" value="business" />
    <c:set var="navbar" scope="request" value="data" />
    <c:import url="/public/sidebar.jsp"/>

    <div class="content">
        <div class="content-top">
            <h3 class="content-title">商家账号</h3>
            <div class="content-action">
                <a href="/car-platform/business/info/addPage" class="action-item icon-add">新增商家</a>
            </div>
        </div>
        <div class="content-main">
            <section class="content-item" data-template="item/list" id="box">
                <div class="content-item-top">
                    <form action="/car-platform/business/info/list" method="get"
                          autocomplete="off">
                        <input type="hidden" name="page" value="1" />
                        <div class="filter-item">
                        	<label>所在区域 </label>
                            <select name="county" class="select">
                        	<option value="">全部</option>
                            	<template v-for="(index, item) in form">
                            		<option value="{{item}}">{{item}}</option>
                            	</template>
                        </select>
                        </div>
                        <div class="filter-item">
                    		<label>状态 </label>
                            <select name="status" class="select">
                            <option value="">全部</option>
                            <option value="1">正常</option>
                            <option value="0">禁用</option>
                            <option value="-1">删除</option>
                        </select>
                        </div>
                        
                        <div class="filter-item">
                        	<label>搜索 </label>
							<input type="text" class="text text-150" name="like" placeholder="输入商家名称" id="search-input"/>
							<input type="submit" class="btn btn-search"  value="搜索" id="search-button"/>
						</div>
                        
                    </form>
                </div>

                <div class="content-item-block">
                    <table class="table table-middle">
                        <thead>
                        <tr>
                            <th style="width: 9%">商家编号</th>
                            <th style="width: 15%" class="align-left">商家名称</th>
                            <th style="width: 10%" class="align-left">所在区域</th>
                            <th style="width: 10%" class="align-left">管理账户</th>
                            <th style="width: 17%" class="align-left">负责人</th>
                            <th style="width: 13%" class="align-left">最后更改</th>
                            <th style="width: 10%" class="align-center">账号状态</th>
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
    {{else if !data.list || data.list.length==0}}
    <tr><td colspan="5">没有记录！</td></tr>
    {{else}}
    {{each data.list as item}}
    <tr>
        <td class="align-left">
            <p>{{item.id}}</p>
        </td>
        <td class="align-left">
            <p>{{item.companyName}}</p>
        </td>
        <td class="align-left">
            {{if item.county}}
                <p>{{item.county}}</p>
            {{else}}
                <p>暂无</p>
            {{/if}}
        </td>
        <td class="align-left">
            <p>{{item.adminAcount}}</p>
        </td>
        <td class="align-left">
        	{{if item.companyOwner}}
            	<p>姓名：{{item.companyOwner}}</p>
            {{else}}
            	<p>姓名：暂无</p>
            {{/if}}
            {{if item.companyOwnerPhone}}
            <p class="value-note">联系方式：{{item.companyOwnerPhone}}</p>
            {{else}}
            <p class="value-note">联系方式：暂无</p>
            {{/if}}
        </td>
        <td class="align-left">
        	{{if item.companyOwner}}
	            <p>{{item.updateTime | dateFormat:'yyyy-MM-dd HH:mm'}}</p>
            {{else}}
            	<p>暂无</p>
            {{/if}}
        </td>
        <td class="align-center">
            {{ if item.bstatus==1}}
            	<span class="state">正常</span>
            {{/if}}
            {{ if item.bstatus==0}}
            	<span class="state state-red">禁用</span>
            {{/if}}
            {{ if item.bstatus==-1}}
            	<span class="state state-blue">已删除</span>
            {{/if}}
        </td>
        </td>
        <td class="align-right">
            <a href="javascript:;" action="item.edit" data-params="{{item | pick:'id,bstatus' | toJSON}}"  class="action-link">设置</a>
            <a href="/car-platform/business/info/editPage?id={{item.id}}"  class="action-link">编辑</a>
            {{ if item.bstatus !==-1}}
            	<a href="javascript:;" action="item.remove" data-params="{{item | pick:'id' | toJSON}}"  class="action-link">删除</a>
            {{/if}}            

        </td>
    </tr>
    {{/each}}
    {{/if}}
</script>

<script type="text/template" id="item/edit" note="商家状态">
    <style>
        .remove-content{padding:10px;color:red;}
    </style>
    <form action="/car-platform/business/info/status/update" method="post">
        <input type="hidden" name="id" value="{{id}}" />
        <div class="form-row" >
            <span class="row-label">商家状态：</span>
            <div class="row-content">
                <select class="select select-col-1" name="status">
                    <option value="0"  {{ bstatus == '0'?'selected="selected"':''}} >禁用</option>
                    <option value="1"  {{ bstatus == '1'?'selected="selected"':''}} >正常</option>
                </select>
            </div>
        </div>
    </form>
</script>

<script type="text/template" id="item/remove" note="商家删除">
    <style>
        .remove-content{padding:10px;color:red;}
    </style>
    <form action="/car-platform/business/info/delete" method="post">
        <div class="align-center remove-content">确定要删除该商家吗？</div>
        <input type="hidden" name="bid" value="{{id}}" />
    </form>
</script>

<script src="/pages/assets/js/require.all.js?v=4293636e2ff5c4a96b189a7661023e42"></script>
<script>
    requirejs([
    			'vue',
                'artTemplate',
                'artDialog',

                'vender.actions',
                'vender.modal',
                
                'jquery.formcheck',
                'jquery.ajaxsubmit',
                'jquery.common',
                'jquery.pager'
            ],
            function(Vue, template, dialog, Action, Modal){
				Action.extend({
					'form.area': '/car-platform/business/info/allCounty/get'
				})
                var App = {

                    alert: function() {
                        alert(arguments[0]);
                    },

                    reloadItems: function() {
                        $("#box").reload();
                    },
                    getAppData: function() {
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

					initForm: function(formData) {
							new Vue({
								el: '#app',
								data: function() {
									return {
										form: formData
									}
								}
							})

						},


                    addItem: function(data) {
                        var id = "item/add";
                        var title = document.getElementById(id).title || "添加分类";
                        alert("titile:"+titile);
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
                                this
                                        .getContent()
                                        .find("form")
                                        .on(
                                                "submit",
                                                function(e) {
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
                    editItem: function(data) {
                        var id = "item/edit";
                        var title = document.getElementById(id).title || "商家状态";
                        var content = template(id, data);
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
                                                        App.alert(msg);
                                                    }
                                                }
                                            })
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
                    initDOMEvents: function() {
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
                    },
                    init: function() {
						var app = this;
						this.getAppData()
						.then(function(data) {
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