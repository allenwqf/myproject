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
    <title>订单管理-车辆清洗</title>
    <c:import url="/public/head-tag.jsp" />
    <style>
        .table-middle td {
            vertical-align: middle;
        }
        .select-2 {
            width:80px;
        }
        .select-1 {
            width:150px;
        }
        .text-search{
            width: 260px;
        }
        .text-search1{
            width: 170px;
        }
        #selectChannel{
        	display: inline-block;
        }
    </style>
</head>
<body>
<c:import url="/public/header.jsp" />
<section class="container">

    <c:set var="sidebar" scope="request" value="order" />
    <c:set var="navbar" scope="request" value="wash" />
    <c:import url="/public/sidebar.jsp"/>

    <div class="content">
        <div class="content-top">
        	<h3 class="content-title">
    				<div class="bread">
    					<span >车辆清洗</span>
    				</div>
    			</h3>
        </div>
        <div class="content-main">
            <section class="content-item" data-template="item/list" id="box">
                <div class="content-item-top">
                 <form action="/car-platform/order/washcar/listSearch" method="get"
                          autocomplete="off">
                        <input type="hidden" name="page" value="1" />
                        <div class="filter-item">
                        	<label>订单状态</label> 
				            <select name="status" class="select select-2">
				                <option value="">全部</option>
				                <option value="0">未付款</option>
				                <option value="1">未消费</option>
				                <option value="2">未评价</option>
				                <option value="3">已评价</option>
				                <option value="8">待退款</option>
				                <option value="4">退款中</option>
				                <option value="5">已退款</option>
				                <option value="6">已过期</option>
				                <!--<option value="7">已失效</option>-->
				            </select>
                        </div>
                        
                        <div class="filter-item">
                        	<label>服务项目</label>
	                      <select name="serviceFlag" class="select select-2"  id="statusSelect">
			                <option value="">全部</option>
			                <template v-for="item in data">
			                	<option  :value="item.flag" v-text="item.name"></option>	
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
							<label>订单搜索</label>
							<input type="text"  name="like" class="text text-search1" placeholder="输入订单号码或下单用户搜索"/>
						</div>
						<div class="filter-item">
                        	<label>门店搜索</label>
							<input type="text" id="bname" data-autocomplete="/car-platform/business/info/likequery/list" class="text text-search1" placeholder="输入服务门店搜索"/>
							<input type="hidden" name="like" />
							<input type="submit" class="btn btn-search" value="搜索" id="search-button"/>
							<a data-href="/car-platform/order/washcar/export?" id="exportBtn" target="_blank" class="btn btn-default">导出数据</a>
						</div>
						
                    </form>
                </div>

                <div class="content-item-block">
                    <table class="table table-middle">
                        <thead>
                        <tr>
                            <th style="width: 15%">下单时间</th>
                            <th style="width: 12%" class="align-left">下单用户</th>
                            <th style="width: 17%" class="align-left">订单号码</th>
                            <th style="width: 20%" class="align-left">服务项目</th>
                            <th style="width: 17%" class="align-center">服务门店</th>
                            <th style="width: 7%" class="align-left">金额</th>
                            <th style="width: 10%" class="align-center">状态</th>
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
            <p>{{item.name}}</p>
        </td>
        <td class="align-left">
            <p>{{item.id}}</p>
        </td>
        <td class="align-left">
            <p>{{item.serviceDesc}}</p>
        </td>
        <td class="align-center">
            {{if item.bname}}
                <p>{{item.bname}}</p>
            {{else}}
                <p>-</p>
            {{/if}}
        </td>
        <td class="align-left">
            {{if item.price}}
                 <span class="rmb">{{item.price}}</span>
            {{else}}
                 <span class="rmb">0</span>
            {{/if}}
        </td>
        
        <td class="align-center">
            {{ if item.payStatus==0}}
                 <p>{{#isInvalid(item.unpayExpireTime,item.createTime)}}</p>
            {{/if}}
            {{ if item.payStatus==1}}
            	<span class="state">未消费</span>
            {{/if}}
            {{ if item.payStatus==2}}
           		<span class="state">未评价</span>
            {{/if}}
            {{ if item.payStatus==3}}
            	<span class="state">已评价</span>
            {{/if}}
            {{ if item.payStatus==4}}
            	<span class="state">退款中</span>
            {{/if}}
            {{ if item.payStatus==5}}
            	<span class="state">已退款</span>
            {{/if}}
            {{ if item.payStatus==6}}
            	<span class="state">已过期</span>
            {{/if}}
            {{ if item.payStatus==7}}
            	<p>未付款</p>
            	<p>订单已失效</p>
            {{/if}}
            {{ if item.payStatus==8}}
            	<span class="state">待退款</span>
            {{/if}}
        </td>
        <td class="align-right">
            <a href="/car-platform/order/washcar/detailPage?orderId={{item.id}}"  class="action-link">详情</a>
            {{if item.payStatus==8}}
                <a href="#" data-action="refuse" data-params="{{item | pick:'id,price' | toJSON}}" class="action-link">退款</a>
            {{/if}}
        </td>
    </tr>
    {{/each}}
    {{/if}}
</script>

<script type="text/template" id="item/pass" note="是否通过">
    <style>
        .remove-content{padding:10px;color:red;}
        .text106{width: 260px;height: 60px;}
        .text30{width:100px}
        .msg{font-size: 20px;padding: 0 5px;}
    </style>
    <form action="/car-platform/order/refund" method="post">
        <input type="hidden" name="orderId" value="{{id}}" />
        <input type="hidden" name="amount" value="{{price}}" />
            <p class="remove-content">重要提示：</p>
            <blockquote style="padding:10px">
                <p>该操作属于敏感操作，请输入<span class="msg">支付密码</span>以确认操作</p>
            </blockquote>
        <div class="form-row" >
            <div class="row-content">
                <span class="row-label row-label-100">支付密码：</span>
                <div class="row-value">
                    <input type="password" class="text30" name="password" />	
                </div>
            </div>
        </div>
        <div class="form-row" >
            <div class="row-content">
                <span class="row-label row-label-100">退款备注：</span>
                <div class="row-value">
                    <textarea name="description" class="text106"></textarea>
                </div>
            </div>
        </div>
    </form>
</script>

<script src="/pages/assets/js/require.all.js?v=4293636e2ff5c4a96b189a7661023e42"></script>
<script>
    requirejs([
    			'vue',
                'artTemplate',

                'vender.modal',
                
                'jquery.ajaxsubmit',
                'jquery.formcheck',
				'jquery.daterangepicker', 
				'jquery.autocomplete',
                'jquery.common',
                'jquery.pager'
            ],
            function(Vue, template,  Modal){
    	
		    	template.helper('isInvalid', function (unpayExpireTime, createTime) {
		    	    var isInvalid;
		    	    var myDate=new Date().getTime();
		    	    var time=myDate-unpayExpireTime;
		    	    if (time>0){
		    	    	isInvalid="未付款<br>订单已失效";
		    	    }else{
		    	    	isInvalid="未付款";
		    	    }
		    	    return isInvalid;
		    	});

                var App = {

                    alert: function() {
                        alert(arguments[0]);
                    },

                    reloadItems: function() {
                        $("#box").reload();
                    },
                    tip:function(msg,type){
                        return Modal.tip(msg,type)
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
							$(this).parents("form:first").submit();
						})
	    			},
                    getData:function(){
						var dtd = $.Deferred();
						var url="/car-platform/business/goods/list?serviceId=0";
						$.getJSON(url, function(result) {
							dtd.resolve(result.data)
						})
						.fail(function(e, type, msg) {
							dtd.reject(type + msg)
						})
						return dtd;
					},
                    initSelect:function(data){
                    	new Vue({
								el: '#statusSelect',
								data: function() {
									return {
										data:data
									}
								}
							})
                    
                    },
                    
	    			refuse:function(data){
	    				var id="item/pass";
	    				var title = "退款";
                        var content = template(id, data);
                        
                        var idialog = dialog({
                            id: id,
                            zIndex: 5,
                            width: 460,
                            padding: "10px 20px",
                            title: title,
                            content: content,
                            button: [{
                                id: "cancel",
                                value: "取消",
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
                                               	App.tip("设置成功", Modal.MsgType.SUCCESS);
                                               	App.reloadItems();
                                            } else {
                                                idialog.remove();
                                                var msg = result.msg || "提交失败！";
                                                App.tip(msg, Modal.MsgType.ERROR);
                                            }
                                        }
                                    })
                                    return false;
                                }
                            }]
                        }).showModal();
	    			},
	    			
	    			initEventListen:function(){
                        var that=this;
                        $("body").on("click", "[data-action]", function() {
                            var $this = $(this);
                            var action=$this.data("action");
                            var data=$this.data("params");
                            if(action==='refuse'){
                                App.refuse(data);
                            }
                            return false;
                        })
                    },
                    
                    initEvents:function(){
    				
	    				$('[data-autocomplete]').each(function(){
	                        var $this=$(this);
	                        var url=$this.data('autocomplete');
	                        var $parent=$this.parents(':first');
	                        $this.autocomplete({
	                            serviceUrl: url,
	                            minChars:0,
	                            deferRequestBy:150,
	                            lookupLimit:15,
	                            paramName:'businessName',
	                            dataType:'json',
	                            autoSelectFirst:true,
	                            onSearchStart :function(){
	                            	$parent.addClass('input-loading');
	                            },
	                            onSearchComplete :function(){
	                            	$parent.removeClass('input-loading');
	                            },
	                            transformResult: function(response) {
	                                return {
	                                    suggestions: $.map(response.data, function(item) {
	                                    	if(item.businessName){
		                                    	var username = item.businessName;
		                                        return {
		                                        	bid:item.bid,
		                                        	value: username 
		                                        };
	                                    	}
	                                    })
	                                };
	                            },
	                            onSelect: function(s) {
	                            	var $this=$(this);
	                            	if(s.bid){
		                            	$this.next('input:hidden').val(s.bid);
	                            	}
	                            },
	                            onHide: function(s) {
	                                var $this=$(this);
	                                $this.next('input:hidden').val(s.bid);
									$('#search-button').click();
	                            },
	                        }).on('blur',function(){
//	                            $('#search-button').click();
	                        })
	                    })
	    			},
                    
                    init: function() {
                    	var that = this;
                    	that.getData().then(function(result){
                    		that.initSelect(result);
                    	})
                        that.initDatePicker();
                        that.initEvents();
                        that.initEventListen();
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
                    }
                }
                App.init();
            })
</script>
</body>
</html>