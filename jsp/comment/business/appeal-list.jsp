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
    <title>商家申诉</title>
    <c:import url="/public/head-tag.jsp" />
    <style>
        .table-middle td {
            vertical-align: middle;
        }
        .select-col-2 {
            width:100px;
            margin-left: 20px;
        }
        .test100{
			padding: 5px 5px;
		    border: 1px solid #B8B8B8;
		    width: 300px;
		}
	    .text-200{
	       width:200px	
	    }
    </style>
</head>
<body>
<c:import url="/public/header.jsp" />
<section class="container">

    <c:set var="sidebar" scope="request" value="comment" />
    <c:set var="navbar" scope="request" value="sellComplain" />
    <c:import url="/public/sidebar.jsp"/>

    <div class="content">
        <div class="content-top">
        	<h3 class="content-title">
    				<div class="bread">
    					<span>商家申诉</span>
    				</div>
    			</h3>
        </div>
        <div class="content-main">
            <section class="content-item" data-template="item/list" id="box">
                <div class="content-item-top">
                    <form action="/car-platform/business/appeal/listSearch" method="get"
                          autocomplete="off">
                          <input type="hidden" name="page" value="1" />
                        <div class="filter-item"> 
                        	<label>评分筛选</label>
				          <select name="status" class="select">
			                <option value="">全部</option>
			                <option value="0">待核实</option>
			                <option value="1">已通过</option>
			                <option value="2">已驳回</option>
			              </select>
                        </div>
                        <div class="filter-item">
                        	<label>时间</label>
							<input type="text" class="text text-100" placeholder="开始时间" name="sdate" date-range/>
							<span>至</span>
							<input type="text" class="text text-100" placeholder="结束时间"  name="edate" date-range/>
						</div>
						
						<div class="filter-item">
							<label>搜索</label>
							<input type="text" class="text text-200" name="like" placeholder="输入提交商家或争议订单号" id="search-input"/>
							<input type="submit" class="btn btn-search"  value="搜索" id="search-button"/>
						    <a data-href="/car-platform/business/appeal/export?" id="exportBtn" target="_blank" class="btn btn-default">导出数据</a>
						</div>

                    </form>
                </div>

                <div class="content-item-block">
                    <table class="table table-middle">
                        <thead>
                        <tr>
                            <th style="width: 14%">提交时间</th>
                            <th style="width: 12%" class="align-left">提交商家</th>
                            <th style="width: 15%" class="align-left">争议订单</th>
                            <th style="width: 20%" class="align-left">申诉原因</th>
                            <th style="width: 10%" class="align-left">处理状态</th>
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
            <p>{{item.t | dateFormat:'yyyy-MM-dd HH:mm'}}</p>
        </td>
        <td class="align-left">
            <p>{{item.bname}}</p>
        </td>
        <td class="align-left">
            <span>评分：{{item.score}}分</span></br>
            <span><label>单号：</label>{{item.orderId}}</span>
        </td>
        
		<td class="align-left">
            <span>{{item.appealDesc}}</span>
        </td>

		<td class="align-left">
        	{{if item.status=="0"}}
            	<span>待核实</span>
            {{else if item.status=="1"}}
           	 	<span>已通过</span>
            {{else if item.status=="2"}}
           		<span>已驳回</span>
            {{/if}}
        </td>

        <td class="align-center">
            <a href="/car-platform/business/appeal/detailPage?id={{item.id}}"  class="action-link">详情</a>
            {{if item.status=="0"}}
	            <a href="javascript:;" action="item.edit" data-params="{{item | pick:'id' | toJSON}}" class="action-link">驳回</a>
	            <a href="javascript:;" action="item.pass" data-params="{{item | pick:'id' | toJSON}}"  class="action-link">通过</a>
            {{/if}}
        </td>
    </tr>
    {{/each}}
    {{/if}}
</script>

<script type="text/template" id="item/edit" note="驳回申诉">
    <style>
        .remove-content{padding:10px;color:red;}
    </style>
    <form action="/car-platform/business/appeal/process" method="post">
        <input type="hidden" name="id" value={{id}} />
        <input type="hidden" name="status" value="2" />
        <div class="form-row" >
     		<textarea name="prosdesc" class="test100" placeholder="驳回意见"></textarea>
        </div>
    </form>
</script>

<script type="text/template" id="item/pass" note="通过申诉">
    <style>
        .remove-content{padding:10px;color:red;}
    </style>
    <form action="/car-platform/business/appeal/process" method="post">
    	<input type="hidden" name="status" value="1" />
        <div class="align-center remove-content">通过此项申诉，将直接删除争议订单的相关差评
是否确认通过此项申诉？</div>
		<textarea name="prosdesc" class="test100" placeholder="处理意见"></textarea>
        <input type="hidden" name="id" value={{id}} />
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

                    reloadItems: function() {
                        $("#box").reload();
                    },
                    editItem: function(data) {
                        var id = "item/edit";
                        var title = document.getElementById(id).title || "驳回申诉";
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
                        var id = "item/pass";
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
                        this.initDatePicker();
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

                        $("body").on("click", "[action]:not(form)", function() {
                            var $this = $(this);
                            var action = $this.attr("action");
                            var data = $this.data("params");
                            if (action == "item.pass") {
                                App.removeItem(data);
                            } else if (action == "item.edit") {
                                App.editItem(data);
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