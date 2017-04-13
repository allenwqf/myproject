<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <!--[if lt IE 7 ]><html class="ie6"><![endif]-->
        <!--[if IE 7 ]><html class="ie7"><![endif]-->
        <!--[if IE 8 ]><html class="ie8"><![endif]-->
        <!--[if IE 9 ]><html class="ie9"><![endif]-->
        <!--[if (gt IE 9)|!(IE)]><!-->
        <html>
        <!--<![endif]-->

        <head>
            <meta charset="utf-8">
            <meta name="renderer" content="webkit">
            <meta name="viewport" content="initial-scale=1,minimum-scale=1" />
            <title>商家提现</title>
            <c:import url="${approot}/public/head-tag.jsp" />
            <style>
                .table-middle td {
                    vertical-align: middle;
                }
                
                .select-col-2 {
                    width: 100px;
                    margin-left: 20px;
                }
                .row-label-100{
                    width: 100px;	
                }
                .row-content-30{
                    padding-left: 30px;	
                }
                .format-text{
                    letter-spacing: 10px;
                }
                .row-content-100{
                    padding-left: 100px;
                    margin-top: -17px;
                }
                .table-detail {
				    width: 90%;
				    margin: 5px 0;
				    text-align: left;
				}
            </style>
        </head>

        <body>
            <c:import url="${approot}/public/header.jsp" />
            <section class="container">

                <c:set var="sidebar" scope="request" value="business" />
                <c:set var="navbar" scope="request" value="withdraw" />
                <c:import url="${approot}/public/sidebar.jsp" />

                <div class="content">
                    <div class="content-top">
                        <h3 class="content-title">
                            <div class="bread">
                                <span>商家提现</span>
                            </div>
                        </h3>
                    </div>
                    <div class="content-main">
                        <section class="content-item" data-template="item/list" id="box">
                            <div class="content-item-top">
                                <form action="/car-platform/finance/withdrawa/listSearch" method="get" autocomplete="off">
                                    <input type="hidden" name="page" value="1" />
                                    <div class="filter-item">
                                    	<label>状态</label>
                                        <select name="status" class="select">
						                <option value="">全部</option>
						                <option value="0">处理中</option>
						                <option value="1">处理成功</option>
						                <!-- <option value="-1">处理失败</option> -->
						              </select>
                                    </div>
                                    <div class="filter-item">
                                    	<label>时间</label>
                                        <input type="text" class="text text-100" placeholder="开始时间" name="sdate" date-range/>
                                        <span>至</span>
                                        <input type="text" class="text text-100" placeholder="结束时间" name="edate" date-range/>
                                    </div>

                                    <div class="filter-item">
                                    	<label>搜索</label>
                                        <input type="text" class="text text-150" name="like" placeholder="输入关键字" id="search-input" />
                                        <input type="submit" class="btn btn-search" value="搜索" id="search-button" />
                                        <a data-href="/car-platform/finance/withdrawa/export?" id="exportBtn" target="_blank" class="btn btn-default">导出数据</a>
                                    </div>

                                </form>
                            </div>

                            <div class="content-item-block">
                                <table class="table table-middle">
                                    <thead>
                                        <tr>
                                            <th style="width: 14%">申请时间</th>
                                            <th style="width: 14%">提现单号</th>
                                            <th style="width: 14%">申请商家</th>
                                            <th style="width: 10%">提现金额</th>
                                            <th style="width: 10%">商家余额</th>
                                            <th style="width: 13%" class="align-left">状态</th>
                                            <th style="width: 13%" class="align-left">操作</th>
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
                {{if !code }}
                <tr>
                    <td colspan="5" class="color-red">查询错误！</td>
                </tr>
                {{else if code!=200}}
                <tr>
                    <td colspan="5" class="color-red">{{msg || '查询错误！'}}</td>
                </tr>
                {{else if !data.list || data.list.length==0}}
                <tr>
                    <td colspan="5">没有记录！</td>
                </tr>
                {{else}} {{each data.list as item}}
                <tr>
                    <td class="align-left">
                        {{if item.t}}
                            <p>{{item.t | dateFormat:'yyyy-MM-dd'}}</p>
                            <p class="value-note">{{item.t | dateFormat:'HH:mm'}}</p>
                        {{else}}
                            <p>-</p>
                        {{/if}}
                    </td>
                    <td class="align-left">
                        <p>{{item.id}}</p>
                    </td>
                    <td class="align-left">
                        <p>{{item.bname}}</p>
                    </td>
                    <td class="align-left">
                    	{{if item.amount}}
	                        <p class="rmb">{{item.amount}}</p>
                    	{{else}}
                    		<p>-</p>
                    	{{/if}}
                    </td>
                    <td class="align-left">
                    	{{if item.availableBalance}}
                        	<p class="rmb">{{item.availableBalance}}</p>
                        {{else}}
                        	<p>-</p>
                        {{/if}}
                    </td>
                    <td class="align-left">
                        {{if item.status=="0"}}
                        <p>处理中</p>
                        {{else if item.status=="1"}}
                        <p>处理成功</p>
                        {{if item.updatorTime}}
                        <p class="value-note"><span>{{item.updatorTime | dateFormat:'yyyy-MM-dd HH:mm'}}</span></p>
                        {{else}}
                        <p class="value-note"><span>-</span></p>
                        {{/if}} {{/if}}
                    </td>
                    <td class="align-left">
                        <a href="javascript:" action="item.detail" data-params="{{item | pick:'id' | toJSON}}" class="action-link">详情</a>
                        {{if item.status=="0"}}
	                        <!--<a href="javascript:;" action="item.edit" data-params="{{item | pick:'id' | toJSON}}"  class="action-link">标记为已处理</a>-->
	                        <a href="javascript:" action="item.pay" data-params="{{item | pick:'id' | toJSON}}" class="action-link">付款</a>                   
                        {{/if}}
                    </td>
                </tr>
                {{/each}} {{/if}}
            </script>

            <script type="text/template" id="order/detail" title="订单详情">
                <style>
                    .refound-tip a {
                        text-decoration: underline;
                    }
                </style>
                <div class="form-block form-block-refund">
                    <div class="form-row">
                        <span class="row-label row-label-100">提现单号：</span>
                        <div class="row-content row-content-30">
                            <p class="row-value">{{id}}</p>
                        </div>
                    </div>
                    <div class="form-row">
                        <span class="row-label row-label-100">订单金额：</span>
                        <div class="row-content row-content-30">
                            <p class="row-value"><b class="rmb">{{amount}}</b></p>
                        </div>
                    </div>
                    <div class="form-row">
                        <span class="row-label row-label-100">申请商家：</span>
                        <div class="row-content row-content-30">
                            <p class="row-value">{{bname}}</p>
                        </div>
                    </div>
                    <div class="form-row">
                        <span class="row-label row-label-100">商家余额：</span>
                        <div class="row-content row-content-30">
                            <p class="row-value">{{availableBalance}}</p>
                        </div>
                    </div>
                    <div class="form-row">
                        <span class="row-label row-label-100">提现户名：</span>
                        <div class="row-content row-content-30">
                            {{if businessBankName}}
	                            <p class="row-value">{{businessBankName}}</p>
                            {{/if}}
                        </div>
                    </div>

                    <div class="form-row">
                        <span class="row-label row-label-100">提现卡号：</span>
                        <div class="row-content row-content-30">
                            <div class="row-value">
                            	{{if openBankName}}
	                                <p>{{openBankName}}</p>
	                                <p class="value-note">{{businessBankCardId}}</p>
                                {{/if}}
                            </div>
                        </div>
                    </div>
                    <div class="form-row">
                        <span class="row-label row-label-100">状态记录：</span>
                        <div class="row-content row-content-30">
	                        <table class="table-detail">
	                        	<tr>
		                            <td>发起申请：</td>
		                            <td>{{t | dateFormat:'yyyy-MM-dd HH:mm'}}</td>
		                        </tr>
		                        {{if updatorTime}}
			                        <tr>
			                            <td>发起付款：</td>
			                            
			                            <td>
			                            	{{updatorTime | dateFormat:'yyyy-MM-dd HH:mm'}}
			                            </td>
			                        </tr>
                            	{{/if}}
		                        {{if failTime}}
			                        <tr>
			                            <td>付款失败：</td>
			                            <td>{{failTime | dateFormat:'yyyy-MM-dd HH:mm'}}</td>
			                        </tr>
			                        <tr>
			                            <td>失败原因：</td>
			                            <td>{{if reason}}{{reason}}{{/if}}</td>
			                        </tr>
		                        {{/if}}
	                        </table>
                        </div>
                        <!--<ul style="padding-left: 100px;">
                        	<li><span>发起申请：</span><span class="row-content-30">{{t | dateFormat:'yyyy-MM-dd HH:mm'}}</span></li>
                            <li><span>发起付款：</span><span class="row-content-30">{{updatorTime | dateFormat:'yyyy-MM-dd HH:mm'}}</span></li>
                            {{each payStatus as value}} {{if value.start}}
                            <li><span>发起申请：</span><span class="row-content-30">{{value.start | dateFormat:'yyyy-MM-dd HH:mm'}}</span></li>
                            {{/if}}
                            <li><span>发起付款：</span><span class="row-content-30">{{value.pay | dateFormat:'yyyy-MM-dd HH:mm'}}</span></li>
                            <li><span>付款失败：</span><span class="row-content-30">{{value.payfail | dateFormat:'yyyy-MM-dd HH:mm'}}</span></li>
                            </li>
                            <li><span class="format-text">原因：</span><div class="row-content-100">{{value.info}}</div></li>
                            </li>
                            <li>&nbsp;</li>
                            {{/each}}-->
                        </ul>
                    </div>

                </div>
            </script>

            <script type="text/template" id="order/pay" title="输入密码">
                <style>
                    .refund-div {
                        text-align: center;
                    }
                    
                    .p-50 {
                        line-height: 50px;
                    }
                </style>
                <form action="/car-platform/finance/withdrawa/update" method="post">
                    <div class="refund-div">
                        <p class="p-50">输入密码以便完成退款操作</p>
                        <input type="password" name="password" iname="密码" itip="密码">
                        <input type="hidden" name="id" value={{id}} />
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

                    'jquery.daterangepicker',
                    'jquery.formcheck',
                    'jquery.ajaxsubmit',
                    'jquery.common',
                    'jquery.pager'
                ],

                    function (template, dialog, Action, Modal) {

                        Action.extend({
                            'item.update': '/car-platform/finance/withdrawa/update',
                            'item.detail': '/car-platform/finance/withdrawa/detail?id={id}'
                        })
                        var PAYCHANNEL = [
                            {
                                "type": "alipayAPP",
                                "desc": "支付宝APP"
                            },
                            {
                                "type": "wxAPP",
                                "desc": "微信APP"
                            },
                            {
                                "type": "alipayPC",
                                "desc": "支付宝PC"
                            }
                        ];
                        var STATUS = [
                            {
                                "type": "alipayAPP",
                                "desc": "未付款"
                            },
                            {
                                "type": "alipayAPP",
                                "desc": "付款中"
                            },
                            {
                                "type": "wxAPP",
                                "desc": "付款完成"
                            },
                            {
                                "type": "alipayPC",
                                "desc": "付款失败"
                            }
                        ];
                        var App = {

                            alert: function () {
                                alert(arguments[0]);
                            },
                            confirm: function () {
                                return Modal.confirm.apply(this, arguments)
                            },
                            reloadItems: function () {
                                $("#box").reload();
                            },

                            initDatePicker: function () {
                                var $dates = $("[date-range]").dateRangePicker({
                                    separator: '至',
                                    getValue: function () {
                                        return '';
                                    },
                                    setValue: function (s, s1, s2) {
                                        return false;
                                    },
                                    endDate: new Date(),
                                    shortcuts: {
                                        'prev-days': [1, 3, 5, 7],
                                        'prev': ['week', 'month', 'year'],
                                        'next-days': null,
                                        'next': null
                                    }
                                })
                                    .on("datepicker-apply", function (e, date) {
                                        $dates.eq(0).val(date.date1.format('yyyy-MM-dd'));
                                        $dates.eq(1).val(date.date2.format('yyyy-MM-dd'));
                                        $(this).parents("form:first").submit()
                                    })
                            },
                            operate: function (url) {
                                var dtd = $.Deferred();

                                $.post(url, function (res) {
                                    var result = Action.transformResponse(res);
                                    var code = result.code;
                                    if (code == 200) {
                                        dtd.resolve(result.data)
                                    } else {
                                        var msg = result.msg || '数据获取失败！';
                                        dtd.reject(msg)
                                    }
                                })
                                    .fail(function (e, type, msg) {
                                        dtd.reject(type + msg)
                                    })

                                return dtd;
                            },

                            editItem: function (data) {
                                var id = "order/detail";
                                data.payChannel = PAYCHANNEL;
                                var title = document.getElementById(id).title || "订单详情";
                                var content = template(id, data);
                                var idialog = dialog({
                                    id: id,
                                    title: title,
                                    content: content,
                                    zIndex: 5,
                                    width: 420,
                                    padding: "0 20px",
                                    button: [{
                                        id: "cancel",
                                        value: "取消"
                                    }, {
                                        id: "ok",
                                        value: "确定",
                                        autofocus: true,
                                    }]
                                }).showModal();
                            },
                            inputPassword: function (data) {
                                var id = "order/pay";
                                var title = document.getElementById(id).title || "输入密码";
                                var content = template(id, data);
                                var d = dialog();
                                var idialog = dialog({
                                    id: id,
                                    title: title,
                                    content: content,
                                    zIndex: 5,
                                    width: 420,
                                    height:100,
                                    padding: "0 20px",
                                    onshow: function () {
                                        //解决当表单中只有一个input:text时按回车自动提交form的问题
                                        this.getContent().find("form").on("submit", function (e) {
                                            e.preventDefault();
                                            return false;
                                        });
                                    },
                                    button: [{
                                        id: "cancel",
                                        value: "取消",
                                        callback: function () {d.remove();}
                                    }, {
                                        id: "ok",
                                        value: "确定",
                                        autofocus: true,
                                        callback: function () {
                                            var $form = this.getContent().find("form");
											d.show();
                                            $form.ajaxSubmit({
                                            	checkForm:function(){
                                                    return $form.checkForm({
                                                         onFail:function(e){
                                                             d.remove();
                                                             alert(e);
                                                         }
                                                     })
                                                },
                                                onSuccess: function (result) {
                                                    d.remove();
                                                    var msgData;
                                                    var code = result.code;
                                                    if (code == 200) {
                                                    	idialog.remove();
                                                        Modal.alert(result.data, Modal.MsgType.SUCCESS);
                                                        App.reloadItems();
                                                    } else {
                                                    	idialog.remove();
                                                        var msg = result.msg || "提交失败！";
                                                        Modal.alert(msg, Modal.MsgType.ERROR);
                                                    }
                                                }
                                            })
                                            return false;
                                        }
                                    }]
                                }).showModal();
                            },
                            init: function () {
                                this.initDatePicker();
                                $("[data-template]").ajaxLoad({
                                    beforeSubmit: function () {
                                        var $extBtn = $("#exportBtn");
                                        var href = $extBtn.data('href');
                                        var params = $(this).find("form").serialize();
                                        $extBtn.attr('href', href + params);
                                    },
                                    dataFilter: function (res) {
                                        return res
                                    }
                                });

                                $("body").on("click", "[action]:not(form)", function () {
                                    var $this = $(this);
                                    var action = $this.attr("action");
                                    var data = $this.data("params");
                                    if (action == "item.detail") {
                                        var api = Action.get("item.detail", data);
                                        App.operate(api).then(function (res) {
                                            App.editItem(res)
                                        })
                                    } else if (action == "item.pay") {
                                        App.inputPassword(data);
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