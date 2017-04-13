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
    <title>访问日志</title>
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
    </style>
</head>
<body>
<c:import url="/public/header.jsp" />
<section class="container">

    <c:set var="sidebar" scope="request" value="accesslog" />
    <c:set var="navbar" scope="request" value="sellComplain" />
    <c:import url="/public/sidebar.jsp"/>

    <div class="content">
        <div class="content-top">
        	<h3 class="content-title">
    				<div class="bread">
    					<span>访问日志</span>
    				</div>
    			</h3>
        </div>
        <div class="content-main">
            <section class="content-item" data-template="item/list" id="box">
                <div class="content-item-top">
                    <form action="/car-platform/log/listSearch" method="get"
                          autocomplete="off">
                         <div class="filter-item" id="itemlist">用户名查询 
				          <select name="username" class="select select-col-2">
			                <option value="">全部</option>
			                <template v-for="item in itemList">
			                	<option value={{item.name}}>{{item.name}}</option>
			                </template>
			              </select>
                        </div>
                        <div class="filter-item">时间
							<input type="text" class="text text-100" placeholder="开始时间" name="sdate" date-range/>
							<span>至</span>
							<input type="text" class="text text-100" placeholder="结束时间"  name="edate" date-range/>
						</div>
						
						<div class="filter-item">
								<input type="hidden" name="page" value="1"/>
								<input type="text" class="text text-150" name="like" placeholder="输入关键字" id="search-input"/>
								<input type="submit" class="btn btn-search"  value="搜索" id="search-button"/>
							    <a data-href="/car-platform/log/export?" id="exportBtn" target="_blank" class="btn btn-default">导出数据</a>
							</div>

                    </form>
                </div>

                <div class="content-item-block">
                    <table class="table table-middle">
                        <thead>
                        <tr>
                            <th style="width: 14%">访问时间</th>
                            <th style="width: 13%" class="align-left">访问人用户名</th>
                            <th style="width: 20%" class="align-left">操作动作</th>
                            <th style="width: 17%" class="align-left">操作方法</th>
                            <th style="width: 10%" class="align-left">访问IP</th>
                            <th style="width: 25%" class="align-center">访问浏览器信息</th>
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
            <p>{{item.createDate | dateFormat:'yyyy-MM-dd HH:mm'}}</p>
        </td>
        <td class="align-left">
            <p>{{item.userName}}</p>
        </td>
        <td class="align-left">
            <span>{{item.description}}</span>
        </td>
        
		<td class="align-left">
            <span>{{item.method}}</span>
        </td>
        <td class="align-left">
            <span>{{item.requestIp}}</span>
        </td>
		 <td class="align-left">
            <span>{{item.userAgent}}</span>
        </td>

        <td class="align-center">
            <a href="/car-platform/log/detailPage?id={{item.id}}"  class="action-link">详情</a>
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
                'artDialog',
                'vender.actions',
                'vender.modal',
				'jquery.daterangepicker', 
                'jquery.formcheck',
                'jquery.ajaxsubmit',
                'jquery.common',
                'jquery.pager'
            ],
            function(Vue, template, dialog, Action, Modal){

    	       Action.extend({
                  'itemlist' : '/car-platform/web/sysuser/listSearch'
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
                                dtd.resolve(result.data.list)
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
                        
                    }
                }
                App.init();
            })
</script>
</body>
</html>