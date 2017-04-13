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
    <title>商家业务</title>
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
    <c:set var="navbar" scope="request" value="sellservice" />
    <c:import url="/public/sidebar.jsp"/>

    <div class="content">
        <div class="content-top">
            <h3 class="content-title">
                    <div class="bread">
                        <span>商家业务</span>
                    </div>
                </h3>
        </div>
        <div class="content-main">
            <section class="content-item" data-template="item/list" id="box">
                <div class="content-item-top">
                    <form action="/car-platform/order/business/listSearch" method="get" autocomplete="off">
                    <input type="hidden" name="page" value="1" />
                        <div class="filter-item"> 
                        	<label>业务状态</label>
                          <select name="status" class="select">
                            <option value="">全部</option>
                            <option value="0">未支付</option>
                            <option value="1">已支付</option>
                            <option value="2">暂停</option>
                            <option value="4">待退款</option>
                            <option value="5">已退款</option>
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
                            <input type="text" class="text text-150" name="like" placeholder="输入业务识别码 " id="search-input"/>
                            <input type="submit" class="btn btn-search"  value="搜索" id="search-button"/>
                            <a data-href="/car-platform/order/business/export?" id="exportBtn" target="_blank" class="btn btn-default">导出数据</a>
                        </div>
                        
                    </form>
                </div>

                <div class="content-item-block">
                    <table class="table table-middle">
                        <thead>
                        <tr>
                            <th style="width: 14%">下单时间</th>
                            <th style="width: 10%" class="align-left">下单商家</th>
                            <th style="width: 15%" class="align-left">业务识别码</th>
                            <th style="width: 15%" class="align-left">业务项目</th>
                            <th style="width: 8%" class="align-left">金额</th>
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
            <p>{{item.createTime | dateFormat:'yyyy-MM-dd HH:mm'}}</p>
        </td>
        <td class="align-left">
            <p>{{item.businessName}}</p>
        </td>
        <td class="align-left">
            <p>{{item.id}}</p>
        </td>
        <td class="align-left">
            <p>{{item.goodsName}}</p>
        </td>
        <td class="align-left">
                {{if item.needPayAmount}}
                    <span class="rmb">{{item.needPayAmount}}</span>	
                {{else}}
                    <span>-</span>
                {{/if}}
        </td>
        <td class="align-left">
            {{ if item.status==0}}
                <span class="state">未支付</span>
            {{/if}}
            {{ if item.status==1}}
                 <span class="state">已开通</span>
            {{/if}}
            {{ if item.status==2}}
                 <span class="state">暂停</span>
            {{/if}}
            {{ if item.status==4}}
                <span class="state">申请关闭</span>
            {{/if}}
            {{ if item.status==5}}
                <span class="state-red">关闭已退款</span>
            {{/if}}
        </td>
        </td>
        <td class="align-center">
            {{ if item.status==1}}
                <a href="javascript:;" data-action="item.closed" data-params="{{item | pick:'id' | toJSON}}" class="action-link">关闭</a>
                <a href="javascript:;" data-action="item.edit" data-params="{{item | pick:'id,status' | toJSON}}"  class="action-link">暂停</a>
            {{else}}
                <p  class="action-link">-</p>                
            {{/if}}
        </td>
    </tr>
    {{/each}}
    {{/if}}
</script>

<script type="text/template" id="order/refund" title="订单退款">
    <style>
        .refound-tip a{
            text-decoration: underline;
        }
    </style>
    <form action="/car-platform/order/refund" method="post" @submit.prevent="submit($event)">
        <div class="form-block form-block-refund">
            <div class="form-row">
                <span class="row-label">订单号：</span>
                <div class="row-content">
                    <p class="row-value" v-text="data.id"></p>
                </div>
            </div>
            <div class="form-row">
                <span class="row-label">退款金额：</span>
                <div class="row-content">
                    <p class="value-note"><b class="rmb" v-text="data.payAmount"></b></p>
                </div>
            </div>
            <div class="form-row form-theme2">
                <span class="row-label">退款备注：</span>
                <div class="row-content">
                    <textarea name="description" v-model="note" class="textarea" irequired="false" iname="退款备注" placeholder="请输入退款备注" style="height:100px;width:100%;"></textarea>
                </div>
            </div>

            <div v-if="refound_url" class="form-row form-theme2">
                <span class="row-label">退款提示：</span>
                <div class="row-content">
                    <div class="row-value">
                        <p class="refound-tip">请点击<a href="{{refound_url}}" @click="go2refound" class="action-link" target="_blank">退款链接</a>，按流程操作成功后再回来 </p>
                    </div>
                </div>
            </div>
            <div class="form-row form-theme2 form-row-btn">
                <div class="row-content">
                    <button v-if="mstatus==AppStatus.READY || mstatus==AppStatus.PENDING" class="btn btn-large btn-default" :class="mstatus==AppStatus.PENDING?'btn-loading':''">确认退款</button>
                    <template v-if="mstatus==AppStatus.REFOUNDING">
                        <button  class="btn btn-large btn-default" @click="refoundSuccess">已退款</button>
                        <button  class="btn btn-large" @click="refoundFail">未退款</button>
                    </template>
                </div>
            </div>
        </div>
        <input type="hidden" v-model="data.id" name="orderId"/>
        <input type="hidden" v-model="data.chargeId" name="chargeId"/>
    </form>
</script>

<script type="text/template" id="item/edit" note="是否暂停">
    <style>
        .remove-content{padding:10px;color:red;}
    </style>
    <form action="/car-platform/order/business/status/update" method="post">
        <input type="hidden" name="id" value="{{id}}" />
        <div class="form-row" >
            <span class="row-label">商家状态：</span>
            <div class="row-content">
                <select class="select select-col-1" name="status">
                    <option value="2"  {{ status == '2'?'selected="selected"':''}} >暂停</option>
                    <option value="1"  {{ status == '1'?'selected="selected"':''}} >正常</option>
                </select>
            </div>
        </div>
    </form>
</script>

<script type="text/template" id="item/colse" note="是否关闭">
    <style>
        .remove-content{padding:10px;color:red;}
        .text106{width:80%}
    </style>
    <form action="/car-platform/order/business/status/close" method="post">
        <input type="hidden" name="id" value="{{id}}" />
            <p class="remove-content">重要提示：</p>
            <blockquote style="padding:10px">
                <p>该操作将关闭门店的业务资质，门店将不可再开展该业务。</p>
                <p>如果你确定要这样做，请在下面输入登录密码确认。</p>
            </blockquote>
        <div class="form-row" >
            <div class="row-content">
                <input type="password" class="text106" name="password" />
            </div>
        </div>
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


                'jquery.daterangepicker', 
                'jquery.formcheck',
                'jquery.ajaxsubmit',
                'jquery.common',
                'jquery.pager'
            ],
            function(Vue, template, dialog, Action, Modal){

                var App = {

                    alert: function() {
                        alert(arguments[0]);
                    },

                    reloadItems: function() {
                        $("#box").reload();
                    },


                    closeItem: function(data) {
                        var id = "item/colse";
                        var title = "关闭业务：车辆清洗";
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
                                value: "取消"
                            }, {
                                id: "ok",
                                value: "确定关闭",
                                autofocus: true,
                                callback: function() {
                                    var $form = this.getContent().find("form");
                                    $form.ajaxSubmit({
                                        onSuccess: function(result) {
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
                        var title = document.getElementById(id).title || "是否暂停";
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
                    showRefund : function(data){
                        var app = this;
                        var id="order/refund";
                        var title=document.getElementById(id).title;
                        var content=template(id, data);
                        var idialog=dialog({
                            id : id,
                            title:title,
                            zIndex: 5,width:420,
                            padding:"0 20px",
                            content:content,
                            onshow:function(){

                                var el = this.getContent().get(0);

                                var MyAppStatus = {
                                    READY:1,
                                    PENDING:2,
                                    GO2REFOUND:0,
                                    REFOUNDING:3,
                                    FINISHED:4
                                };

                                var vm = new Vue({
                                    el:el,
                                    computed:{
                                        AppStatus:function(){
                                            return MyAppStatus
                                        }
                                    },
                                    data:function(){
                                        return {
                                            data:data,
                                            mstatus:MyAppStatus.READY
                                        };
                                    },
                                    methods:{
                                        go2refound:function(){
                                            vm.mstatus = MyAppStatus.REFOUNDING;
                                        },
                                        refoundSuccess:function(){
                                            idialog.remove();
                                            app.reload();
                                        },
                                        refoundFail:function(){
                                            this.refound_url = null;
                                            vm.mstatus = MyAppStatus.READY;
                                        },
                                        submit:function(e){
                                            var that = this;
                                            that.mstatus = MyAppStatus.PENDING;
                                            $(e.target).ajaxSubmit({
                                                onFail:function(e){
                                                    vm.mstatus = MyAppStatus.READY;
                                                    var type = e.target?Modal.MsgType.WARN:Modal.MsgType.ERROR;
                                                    Modal.alert(e.msg, null, type).then(function(){
                                                        e.target.focus();
                                                    });
                                                },

                                                onSuccess :function(result){
                                                    var status = MyAppStatus.READY;
                                                    var code=result.code;
                                                    if(code==200){
                                                        idialog.remove();
                                                        app.reload();
                                                        Modal.tip('退款成功', Modal.MsgType.SUCCESS);
                                                    } else if(code==202){
                                                        status = MyAppStatus.GO2REFOUND;
                                                        vm.$set('refound_url', result.data || '#') ;
                                                    }
                                                    else{
                                                        var msg=Action.getResultMsg(result);
                                                        Modal.tip(msg, Modal.MsgType.ERROR);
                                                    }
                                                    vm.mstatus = status;
                                                }
                                            })
                                        }
                                    }
                                })
                            }
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

                        $("body").on("click", "[data-action]", function() {
                            var $this = $(this);
                            var action=$this.data("action");
                            var data=$this.data("params");
                            if(action==='order.refund'){
                                App.showRefund(data);
                            }else if(action==='item.edit'){
                            	App.editItem(data);
                            }else if(action==='item.closed'){
                            	App.closeItem(data);
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