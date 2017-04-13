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
    <title>角色管理</title>
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

    <c:set var="sidebar" scope="request" value="user" />
    <c:set var="navbar" scope="request" value="role" />
    <c:import url="/public/sidebar.jsp"/>

    <div class="content" >
        <div class="content-top">
        	<h3 class="content-title">
				<div class="bread">
					<span>角色管理</span>
				</div>
			</h3>
			<div class="content-action">
	            <a href="/car-platform/role/createPage" class="action-item icon-add">新增</a>
	        </div>
        </div>
        <div class="content-main">
            <section class="content-item" data-template="item/list" id="box">
                <div class="content-item-top">
                    <form action="/car-platform/role/listSearch" method="get"
                          autocomplete="off">
                      <input type="hidden" name="page" value="1" />
                        <div class="filter-item">状态 
				          <select name="status" class="select select-col-2">
			                <option value="">全部</option>
			                <option value="1">已启用</option>
			                <option value="0">已停用</option>
			              </select>
                        </div>
                        <div class="filter-item">时间
							<input type="text" class="text text-100" placeholder="开始时间" name="sdate" date-range/>
							<span>至</span>
							<input type="text" class="text text-100" placeholder="结束时间"  name="edate" date-range/>
						</div>
						
						<div class="filter-item">
								<input type="text" class="text text-150" name="sw" placeholder="输入关键字" id="search-input"/>
								
								<input type="submit" class="btn btn-search"  value="搜索" id="search-button"/>
							    <a data-href="/Manager/web/rights/excelExport?" id="exportBtn" target="_blank" class="btn btn-default">导出数据</a>
							</div>
						
						
                    </form>
                </div>

                <div class="content-item-block">
                    <table class="table table-middle">
                        <thead>
                        <tr>
                            <th style="width: 6%">序号</th>
                            <th style="width: 14%">角色ID</th>
                            <th style="width: 10%" class="align-left">角色名称</th>
                            <th style="width: 13%" class="align-left">角色描述</th>
                            <th style="width: 8%" class="align-left">状态</th>
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
            <p>{{data.paging.pageSize*(data.paging.currentPage-1)+$index+1}}</p>
        </td>
        <td class="align-left">
            <p>{{item.id}}</p>
        </td>
        <td class="align-left">
            <p>{{item.zname}}</p>
        </td>
        <td class="align-left">
            <span>{{item.intro}}</span>
        </td>
        <td class="align-left">
            {{if item.status==0}}
            	<p>已停用</p>
            {{else}}
            	<p>已启用</p>
            {{/if}}
        </td>
        <td class="align-center">
            <a href="javascript:;" action="item.edit"  data-params="{{item | pick:'id' | toJSON}}" class="action-link"> 
            {{if item.status==0}}
            	<p>启用</p>
            {{else}}
            	<p>禁用</p>
            {{/if}}</a>
            <a href="/car-platform/role/updatePage?roleId={{item.id}}" class="action-link">编辑</a>
            <a href="javascript:;" action="item.remove" data-params="{{item | pick:'id' | toJSON}}"  class="action-link">删除</a>
        </td>
    </tr>
    {{/each}}
    {{/if}}
</script>

<script type="text/template" id="item/edit" note="角色管理">
    <style>
        .remove-content{padding:10px;color:red;}
    </style>
    <form action="/car-platform/role/updateStatus" method="post">
        <input type="hidden" name="id" value="{{id}}" />
        <div class="form-row" >
            <span class="row-label">角色状态：</span>
            <div class="row-content">
                <select class="select select-col-1" name="status">
                    <option value="1"  {{ status == '0'?'selected="selected"':''}} >禁用</option>
                    <option value="0"  {{ status == '1'?'selected="selected"':''}} >正常</option>
                </select>
            </div>
        </div>
    </form>
</script>

<script type="text/template" id="item/remove" note="角色管理">
    <style>
        .remove-content{padding:10px;color:red;}
    </style>
    <form action="/car-platform/role/deleteSave" method="post">
        <div class="align-center remove-content">确定要删除该角色吗？</div>
        <input type="hidden" name="id" value="{{id}}" />
    </form>
</script>

<script src="/pages/assets/js/require.all.js?v=4293636e2ff5c4a96b189a7661023e42"></script>
<script>
    requirejs([
                'artTemplate',
                'artDialog',

                'vender.actions',
                'vender.modal',

				'jquery.daterangepicker', 
                'jquery.formcheck',
                'jquery.ajaxsubmit',
                'jquery.common',
                'jquery.pager'
            ],
            function( template, dialog, Action, Modal){
				
                var App = {

                    alert: function() {
                        alert(arguments[0]);
                    },

                    initPlugins: function() {

                    },

                    reloadItems: function() {
                        $("#box").reload();
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
                        var title = document.getElementById(id).title || "角色管理";
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
                    
                    init: function() {
                        this.initPlugins();
                        this.initDatePicker();
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