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
    <title>用户评价</title>
    <c:import url="/public/head-tag.jsp" />
    <style>
        .table-middle td {
            vertical-align: middle;
        }
        .select-col-2 {
            width:100px;
            margin-left: 20px;
        }
        .text-250{
        	width:250px
        }
    </style>
</head>
<body>
<c:import url="/public/header.jsp" />
<section class="container">

    <c:set var="sidebar" scope="request" value="comment" />
    <c:set var="navbar" scope="request" value="userComment" />
    <c:import url="/public/sidebar.jsp"/>

    <div class="content">
        <div class="content-top">
        	<h3 class="content-title">
        		<div class="bread">
					<span href="listPage">用户评价</span>
				</div>
    		</h3>
        </div>
        <div class="content-main">
            <section class="content-item" data-template="item/list" id="box">
                <div class="content-item-top">
                    <form action="/car-platform/user/comment/listSearch" method="get" autocomplete="off">
                        <input type="hidden" name="page" value="1" />
                        <div class="filter-item"> 
                        	<label>评分筛选</label>
				            <select name="scoreStatus" class="select">
				                <option value="">全部</option>
				                <option value="5">0-1</option>
				                <option value="4">1-2</option>
				                <option value="3">2-3</option>
				                <option value="2">3-4</option>
				                <option value="1">4-5</option>
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
							<input type="text" class="text text-250" name="like" placeholder="输入评价人或消费商家或关联订单号" id="search-input"/>
							<input type="submit" class="btn btn-search" value="搜索" id="search-button"/>
						    <a data-href="/car-platform/user/comment/export?" id="exportBtn" target="_blank" class="btn btn-default">导出数据</a>
						</div>
                    </form>
                </div>

                <div class="content-item-block">
                    <table class="table table-middle">
                        <thead>
                        <tr>
                            <th style="width: 10%">评价时间</th>
                            <th style="width: 7%" class="align-left">评价人</th>
                            <th style="width: 12%" class="align-left">消费商家</th>
                            <th style="width: 13%" class="align-left">关联订单</th>
                            <th style="width: 8%" class="align-left">综合评分</th>
                            <th style="width: 10%" class="align-left">分项评星</th>
                            <th style="width: 7%" class="align-left">状态</th>
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
            <p>{{item.uname}}</p>
        </td>
        <td class="align-left">
            <p>{{item.bname}}</p>
        </td>
        <td class="align-left">
            <p><span>订单号：</span><span>{{item.orderId}}</span></p>
            <p><span>服务项目：</span><span>{{item.serviceDesc}}</span></p>
        </td>
        <td class="align-left">
            <span>{{item.score}}</span>分
        </td>
        <td class="align-left">
           <ul>
           	<li>店面环境:{{item.score1}}星</li>
           	<li>清洁程度:{{item.score2}}星</li>
           	<li>服务态度:{{item.score3}}星</li>
           </ul>
           
        </td>
		<td class="align-left">
            {{if item.status == 1}}
            <span>正常</span>
            {{/if}}
            {{if item.status == -2}}
            <span>已被后台删除</span>
            {{/if}}
            {{if item.status == -1}}
            <span>用户删除</span>
            {{/if}}
            {{if item.status == 2}}
            <span>商家对该订单发起申诉</span>
            {{/if}}
		</td>
        </td>
        <td class="align-center">
            <a href="/car-platform/user/comment/detailPage?id={{item.id}}"  class="action-link">详情</a>
        </td>
    </tr>
    {{/each}}
    {{/if}}
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
                        var that=this;
                        this.initDatePicker();
                        $("[data-template]").ajaxLoad({
                        	beforeSubmit:function(){
                                var $extBtn=$("#exportBtn");
                                var href=$extBtn.data('href');
                                var params=$(this).find("form").serialize();
                                $extBtn.attr('href',href+params);
                            },
                            dataFilter:function(res){
                                return res;
                            }
                        });
                    }
                }
                App.init();
            })
</script>
</body>
</html>