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
    <title>养车用户</title>
     
    <c:import url="/public/head-tag.jsp" />
    <style>
        .table-middle td {
            vertical-align: middle;
        }
        .select-col-2 {
            width:100px;
            margin-left: 20px;
        }
        .subnum{
        	display: flex;
        }
        .subnum-content{
        	flex: 1;
        }
        
    </style>
</head>
<body>
<c:import url="/public/header.jsp" />
<section class="container">

    <c:set var="sidebar" scope="request" value="user" />
    <c:set var="navbar" scope="request" value="keepcarlist" />
    <c:import url="/public/sidebar.jsp"/>

    <div class="content">
        <div class="content-top">
        	<h3 class="content-title">
    				<div class="bread">
    					<span>养车用户</span>
    				</div>
    			</h3>
        </div>
        <div class="content-main">
            <section class="content-item" data-template="item/list" id="box">
                <div class="content-item-top">
                    <form action="/car-platform/user/keepcar/listSearch" method="get">
                        <input type="hidden" name="page" value="1" />
                        <!--<div class="filter-item"> 
                        	<label>会员级别</label>
				          <select name="status" class="select">
			                <option value="">全部</option>
			                <option value="0">普通用户</option>
			                <option value="1">vip用户</option>
			              </select>
                        </div>-->
						
						<!--<div class="filter-item">
							
								<input type="text" class="text text-150" name="like" placeholder="输入用户昵称" id="search-input"/>
								<input type="submit" class="btn btn-search"  value="搜索" id="search-button"/>
							    <a data-href="/car-platform/user/keepcar/export?" id="exportBtn" target="_blank" class="btn btn-default">导出数据</a>
							</div>-->
                    </form>
                </div>

                <div class="content-item-block">
                    <table class="table table-middle">
                        <thead>
                        <tr>
                            <th style="width: 20%" class="align-left">用户ID</th>
                           <!-- <th style="width: 10%" class="align-left">用户昵称</th>
                            <th style="width: 10%" class="align-left">登录手机号</th>-->
                            <!--<th style="width: 8%" class="align-left">会员级别</th>-->
                            <th style="width: 10%" class="align-left">最后消费</th>
                            <th style="width: 10%" class="align-left">累积次数</th>
                            <th style="width: 10%" class="align-left">累积消费</th>
                            <th style="width: 10%" class="align-left">会员余额</th>
                            <!--<th style="width: 6%" class="align-center">操作</th>-->
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
            <p>{{item.uid}}</p>
        </td>
        <!--<td class="align-left">
            <p>{{item.uname}}</p>
        </td>
        <td class="align-left">
            <p>{{item.phone}}</p>
        </td>-->
        <!--<td class="align-left">
            <p>{{item.vipLevel==0?'普通会员':'vip'}}</p>
        </td>-->
        <td class="align-left">
            {{if item.lastPayTime}}
                <p>{{item.lastPayTime | dateFormat:'yyyy-MM-dd HH:mm'}}</p>
            {{else}}
                <p>-</p>
            {{/if}}
        </td>
        <td class="align-left">
            {{if item.payTimes}}
                 <span>{{item.payTimes}}</span>次
            {{else}}
	             <span>-</span>
            {{/if}}
        </td>
        <td class="align-left">
            <span class="rmb">{{item.consumAmount}}</span>
        </td>
        <td class="align-left">
            <span class="rmb">{{item.balance}}</span>
        </td>
        
        <!--<td class="align-center">
        	<a href="javascript:;" action="item.edit" data-params="{{item | pick:'uid,uname,vipLevel' | toJSON}}"  class="action-link">修改级别</a>
        </td>-->
    </tr>
    {{/each}}
    {{/if}}
</script>

<script type="text/template" id="item/edit" note="修改级别">
    <style>
        .remove-content{padding:10px;color:red;}
    </style>
    <form action="/car-platform/user/keepcar/update" method="post">
        <input type="hidden" name="uid" value="{{uid}}" />
    	<div class="form-row">
			<span class="row-label menustyle">用户：</span>
			<div class="row-content contentstyle">
             	<div class="row-value">
             		<p >{{uname}}</p>
             	</div>
             </div>
		</div>
        <div class="form-row">
			<span class="row-label menustyle">级别：</span>
            <div class="row-content">
                <select class="select select-col-1" name="level">
                    <option value="0"  {{ vipLevel == '0'?'selected="selected"':''}} >普通会员</option>
                    <option value="1"  {{ vipLevel == '1'?'selected="selected"':''}} >vip会员</option>
                </select>
            </div>
        </div>
    </form>
</script>

<script src="/pages/assets/js/require.all.js?v=4293636e2ff5c4a96b189a7661023e42"></script>
<script>
    requirejs([
                'artTemplate',
                'artDialog',

                'vender.actions',
                'vender.modal',


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
                        var title = document.getElementById(id).title || "修改级别";
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
                    init: function() {
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
                            if (action == "item.edit") {
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