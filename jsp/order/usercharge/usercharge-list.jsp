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

    <c:set var="sidebar" scope="request" value="order" />
    <c:set var="navbar" scope="request" value="userecharge" />
    <c:import url="/public/sidebar.jsp"/>

    <div class="content">
        <div class="content-top">
        	<h3 class="content-title">
    				<div class="bread">
    					<span>会员充值</span>
    				</div>
    			</h3>
        </div>
        <div class="content-main">
            <section class="content-item" data-template="item/list" id="box">
                <div class="content-item-top">
                    <form action="/car-platform/order/usercharge/listSearch" method="get"
                          autocomplete="off">
                        <div class="filter-item" id="itemlist">
                        	<label>充值项目</label> 
				          <select name="servicename" class="select">
			                <option value="">全部</option>
			                <template v-for="item in itemList">
			                	<option value={{item.chargeName}}>{{item.chargeName}}</option>
			                </template>
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
							<input type="text" class="text text-150" name="like" placeholder="输入订单号码或充值项目" id="search-input"/>
							<input type="hidden" name="page" value="1"/>
							<input type="submit" class="btn btn-search"  value="搜索" id="search-button"/>
						    <a data-href="/car-platform/order/usercharge/export?"  id="exportBtn" target="_blank" class="btn btn-default">导出数据</a>
						</div>
					
						
                    </form>
                </div>

                <div class="content-item-block">
                    <table class="table table-middle">
                        <thead>
                        <tr>
                            <th style="width: 12%">充值时间</th>
                            <th style="width: 25%" class="align-left">充值用户</th>
                            <th style="width: 10%" class="align-left">订单号码</th>
                            <th style="width: 13%" class="align-left">充值项目</th>
                            <th style="width: 12%" class="align-left">充值金额</th>
                            <th style="width: 7%" class="align-left">支付状态</th>
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
            <p>{{item.createTime | dateFormat:'yyyy-MM-dd HH:mm'}}</p>
        </td>
        <td class="align-left">
            <p>{{item.lh_uid}}</p>
            <p>{{item.name}}</p>
        </td>
        <td class="align-left">
            <p>{{item.id}}</p>
        </td>
          <td class="align-left">
            <p>{{item.serviceDesc}}</p>
        </td>
        <td class="align-left">
            {{if item.price}}
             <span class="rmb">{{item.price}}</span>
            {{else}}
                <span >-</span>
            {{/if}}
        </td>
        <td class="align-left">
            {{if item.payStatus == 1}}
				<span class="state">已支付</span>
            {{/if}}
			 {{if item.payStatus != 1}}
				<span class="state">未支付</span>
            {{/if}}
        </td>
        </td>
        <td class="align-right">
            <a href="/car-platform/order/usercharge/detailPage?id={{item.id}}"  class="action-link">详情</a>
        </td>
    </tr>
    {{/each}}
    {{/if}}
</script>

<script src="/pages/assets/js/require.all.js?v=4293636e2ff5c4a96b189a7661023e42"></script>
<script>
    requirejs([
                'vue',
                'artTemplate',

                'vender.actions',
                'vender.modal',


				'jquery.daterangepicker', 
                'jquery.common',
                'jquery.pager'
            ],
            function(Vue, template, Action, Modal){
		    	Action.extend({
		            'itemlist' : '/car-platform/user/recharge/service/list'
		        });
                var App = {

                    alert: function() {
                        alert(arguments[0]);
                    },

                    reloadItems: function() {
                        $("#box").reload();
                    },
                    getItemList:function(){
                    	  var dtd = $.Deferred();
                          
                          var url = Action.get('itemlist');
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
                    initItemList:function(formData){
                        new Vue({
                            el:'#itemlist',
                            data:function(){
                                return {
                                    itemList:formData
                                }
                            }
                        })

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
                        this.getItemList().then(function(result){
                        	that.initItemList(result);
                        	that.initDatePicker();
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
                        })
                        
                        

                    },
                }
                App.init();
            })
</script>
</body>
</html>