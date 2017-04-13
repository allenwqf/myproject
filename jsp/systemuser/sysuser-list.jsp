<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="basePath" scope="request" value="<%=request.getContextPath()%>"/>
<!DOCTYPE html>
<!--[if lt IE 7 ]><html class="ie ie6"><![endif]-->
<!--[if IE 7 ]><html class="ie ie7"><![endif]-->
<!--[if IE 8 ]><html class="ie ie8"><![endif]-->
<!--[if IE 9 ]><html class="ie ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--><html><!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
    <meta name="viewport" content="initial-scale=1,minimum-scale=1" />
    <title>后台用户</title>
    <c:import url="/public/head-tag.jsp" />
    <style>
        .title{line-height:2;}
        .tip{
                text-align:center;
                padding:10px;
                width:200px;
                height:200px;
            }
          .tip_p{
              padding-left: 40px
          }
    </style>
</head>
<body>
    <c:import url="/public/header.jsp"/>
    <section class="container">
        
        <c:set var="sidebar" scope="request" value="user"/>
            <c:set var="navbar" scope="request" value="sysuser"/>
            <c:import url="/public/sidebar.jsp"/>
        
        <div class="content">
            <div class="content-top">
                <h3 class="content-title">后台用户</h3>
                <div class="content-action">
                    <a href="/car-platform/web/sysuser/createPage" class="action-item icon-add" title="添加用户">添加用户</a>
                </div>
            </div>
            <div class="content-main">
                <section class="content-item" data-template="item/list" id="box">
                    <div class="content-item-top" id="app">
                        <form action="/car-platform/web/sysuser/listSearch" method="get" autocomplete="off">
                            <input type ="hidden" name="page" value="1" >                           
                            <div class="filter-item">
                                <label for="">用户角色</label>
                                <select name="type" class="select" id="roles">
                                    <option value="">所有</option>
                                    <option v-for="item in roleList" value={{item.id}}>{{item.zname}}</option>
                                </select>
                            </div>
                            
                            <div class="filter-item">
                                <label for="">注册时间</label>
                                <input type="text" class="text text-100" placeholder="开始时间" name="sdate" date-range/>
                                <span>至</span>
                                <input type="text" class="text text-100" placeholder="结束时间"  name="edate" date-range/>
                            </div>              
                            <div class="filter-item">
                                <label for="">检索</label>
                                <input type="search" class="text text-150" name="quicksearch" placeholder="输入关键字" id="search-input"/>
                                <input type="submit" class="btn btn-search"  value="搜索" id="search-button"/>
                            </div>
                        </form>
                    </div>
                    
                    <div class="content-item-block">
                        <table class="table">
                            <thead>
                            <tr>
                                <th style="width:5%"></th>
                                <th style="width:15%">注册时间</th>
                                <th style="width:20%">账户名</th>
                                <th style="width:15%">昵称</th>
                                <th style="width:15%">角色</th>
                                <th style="width:10%" class="align-center">状态</th>
                                <th style="width:20%" class="align-right">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="align-center" colspan="7">
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
            <tr><td colspan="7" class="color-red">查询错误！</td></tr>
        {{else if code!=200}}
            <tr><td colspan="7" class="color-red">{{msg || '查询错误！'}}</td></tr>
        {{else if !data.list || data.list.length==0}}
            <tr><td colspan="7">没有记录！</td></tr>
        {{else}}
            {{each data.list as item}}
                <tr>
                    <td>
                        <p>{{data.paging.pageSize*(data.paging.currentPage-1)+$index+1}}</p>
                    </td>
                    <td>
                        <p>{{ item.t | dateFormat:'yyyy-MM-dd' }}</p>
                        <p class="value-note">{{ item.t | dateFormat:'HH:mm' }}</p>
                    </td>
                    <td>
                        <p title="{{item.label}}">
                            {{if item.name}}<span>{{ item.name}}</span>
                            {{else}} <span class="color-blue">未设置</span>
                            {{/if}}
                        </p>
                    </td>
                    <td>
                        <p title="{{item.label}}">
                            {{if item.nick}}<span>{{ item.nick}}</span>
                            {{else}} <span class="color-blue">未设置</span>
                            {{/if}}
                        </p>
                    </td>
                    <td>
                        {{if item.superManager=="0"}}
                            <p>非管理员</p>
							<a href="javascript:;" data-action="item.role.edit" data-params="{{item | pick:'id:userId,id,status' | toJSON}}"   class="action-link">查看角色</a>
                        {{else if item.superManager=="1"}}                          
                            <p>管理员</p>
                        {{/if}}
                    </td>
                    <td class="align-center">
                       {{ if item.status==0}}
                        <span class="state color-red">禁用</span>
                        {{else}}
                        <span class="state">正常</span>
                        {{/if}}
                    </td>
                    <td class="align-right">
                         <a href="javascript:;" data-action="item.status.edit" data-params="{{item | pick:'id:userId,id,status' | toJSON}}"   class="action-link">修改状态</a>
                         <a href="javascript:;" data-action="item.role.edit" data-params="{{item | pick:'id:userId,id,status' | toJSON}}"   class="action-link">设置角色</a>
                         <a href="/car-platform/web/sysuser/createPage?id={{item.id}}"  class="action-link">编辑</a>
                         <a href="javascript:;" data-action="item.remove" data-params="{{item | pick:'id' | toJSON}}"  class="action-link">删除</a>                                        
                    </td>
                </tr>
            {{/each}}
        {{/if}}
    </script>
    
     <script type="text/template" id="item/status/edit" title="修改状态">
            <form action="/car-platform/web/sysuser/updateStatus" method="post">
                <input type="hidden" name="id" value="{{id}}" />
                <div class="form-row" >
                    <span class="row-label">状态：</span>
                    <div class="row-content">
                        <div class="row-value">
                            <input type="radio" id="radio_status_1" value="1" name="status" {{if status==1}}checked="checked"{{/if}} />
                            <label for="radio_status_1">启用</label>
                            <input type="radio" id="radio_status_0" value="0" name="status" {{if status==0}}checked="checked"{{/if}} />
                            <label for="radio_status_0">禁用</label>
                        </div>
                    </div>
                </div>      
            </form>
    </script>
    
     <script type="text/template" id="item/role/edit" title="修改角色">
        {{if !code || code!=200}}
            <div class="error-tip">{{msg || '请求错误！'}}</div>
        {{else}}
            <form action="/car-platform/web/sysuser/updateRole" method="post">
                <input type="hidden" name="id" value="{{data.id}}" />
                <div class="form-row" >
                    <span class="row-label">角色：</span>
                    <div class="row-content">
                        <ul class="roles">
                            {{each data.roles as item}}
                                <li>
                                    <input {{if item.flag == 1}}checked="checked"{{/if}} id="u_{{item.id}}" type="checkbox" name="role" value="{{item.id}}" />
                                    <label for="u_{{item.id}}">{{item.zname}}</label>
                                </li>
                            {{/each}}
                            <li><a class="action-link" href="/car-platform/role/createPage">添加新角色</a></li>
                        </ul>
                    </div>
                </div>          
            </form>
        {{/if}}
    </script>
    
    <script type="text/template" id="item/remove" note="删除">
        <style>
            .remove-content{padding:10px;color:red;}
        </style>
        <form action="/car-platform/web/sysuser/delete" method="post">
            <div class="align-center remove-content">确定要删除该账号吗？</div>
            <input type="hidden" name="id" value="{{ id }}" />
        </form>
    </script>
   
    <script type="text/template" id="user/detail" title="关联用户信息">
        
            <div class="form-block">
                {{if !code}}
                    <div class="form-row">
                      <div class="row-content">
                            <p class="tip_p" >
                                正在获取...
                            </p>
                      </div>
                    </div>
                {{else if code!=200}}
                    <div class="form-row">
                        <div class="row-content">
                            <p class="tip_p" >
                                {{msg || '获取失败'}}
                            </p>
                        </div>
                    </div>
                {{else if code==200}}
                  <div class="form-row">
                    <span class="row-label">头像：</span>
                    <div class="row-content">
                        <p class="row-value">
                            <img width=50 height=50 src="{{getImage(data.portrait)}}" alt="{{data.username}}" />
                        </p>
                    </div>
                </div>
                <div class="form-row">
                    <span class="row-label">用户名：</span>
                    <div class="row-content">
                        <p class="row-value">{{data.username}}</p>
                    </div>
                </div>
                <div class="form-row">
                    <span class="row-label">手机号：</span>
                    <div class="row-content">
                        <p class="row-value">{{data.phone}}</p>
                    </div>
                </div>
                <div class="form-row">
                    <span class="row-label">签名：</span>
                    <div class="row-content">
                        <p class="row-value">{{data.label}}</p>
                    </div>
                </div>
                <div class="form-row">
                    <span class="row-label">注册时间：</span>
                    <div class="row-content">
                        <p class="row-value">{{data.registtime | dateFormat}}</p>
                    </div>
                </div>
           
             {{else}}
                <div class="form-row">
                  <div class="row-content">
                      <p class="tip_p" >
                        {{msg || '获取失败'}}
                    </p>
                  </div>
                </div>
             {{/if}}
        </div>
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
                'roleDetail' : '/car-platform/web/sysuser/listRole',
                'showImage':'http://radio.iwxlh.com/Radio/resource/{data}',
                'roleList':'/car-platform/role/listSearch'
            })
            
            template.helper('getImage', function (img) {
                return Action.get('showImage',img)
            });
            
            var App={
                alert : function(){
                    alert(arguments[0]);
                },
                initPlugins:function(){
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
                
                reloadItems:function(){
                    $("#box").reload();
                },
                
                getRoleList:function(){
                    var dtd = $.Deferred();
                    var url = Action.get('roleList');
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
                                roleList: formData.list
                            }
                        },
                        methods: {
                        }
                    })
                },
                
                editItemStatus :function(data){
                    var app = this;
                    var id="item/status/edit";
                    var title=document.getElementById(id).title;
                    var content=template(id, data);
                    
                    var idialog=dialog({
                        id : id,
                        zIndex: 5,width:420,
                        padding:"0 20px",
                        title:title,
                        content :content,
                        button:[
                            {
                                id:"cancel",value:"取消"
                            },
                            {
                                id:"ok",value:"提交修改",
                                autofocus:true,
                                callback:function(){
                                    var $form=this.getContent().find("form");
                                    
                                    $form.ajaxSubmit({
                                        beforeSubmit:function(){
                                            idialog.setButton('ok',{
                                                disabled:true
                                            });
                                        },
                                        complete:function(){
                                            idialog.setButton('ok',{
                                                disabled:false
                                            });
                                        },
                                        onFail:function(msg){
                                            alert(msg)
                                        },
                                        onSuccess :function(result){
                                            var code=result.code;
                                            if(code==200){
                                                idialog.remove();
                                                app.reloadItems();
                                            }
                                            else{
                                                var msg=result.msg || "提交失败！";
                                                app.alert(msg);
                                            }
                                        }
                                    })
                                    return false;
                                }
                            }
                        ]
                    }).showModal();
                },
                
                editItemRole :function(data){
                    var app = this;
                    var id="item/role/edit";
                    var title=document.getElementById(id).title;
                    var content=template(id);
                    
                    var idialog=dialog({
                        id : id,
                        zIndex: 5,width:420,
                        padding:"0 20px",
                        title:title,
                        content:content
                    }).showModal();
                    $.getJSON(Action.get('roleDetail'), data)
                    .success(function(result){
                        var code=result.code;
                        var roles=result.data;
                        data.roles=roles;
                        result.data=data;
                        var content = template(id, result);
                        idialog.content(content).reset()
                        if(code==200){
                            idialog.button([
                                {
                                    id:"cancel",value:"取消"
                                },
                                {
                                    id:"ok",value:"提交修改",
                                    autofocus:true,
                                    callback:function(){
                                        var $form=this.getContent().find("form");
                                        
                                        $form.ajaxSubmit({
                                            beforeSubmit:function(){
                                                idialog.setButton('ok',{
                                                    disabled:true
                                                });
                                            },
                                            complete:function(){
                                                idialog.setButton('ok',{
                                                    disabled:false
                                                });
                                            },
                                            onFail:function(msg){
                                                alert(msg)
                                            },
                                            onSuccess :function(result){
                                                var code=result.code;
                                                if(code==200){
                                                    idialog.remove();
                                                    app.reloadItems();
                                                }
                                                else{
                                                    var msg=result.msg || "提交失败！";
                                                    app.alert(msg);
                                                }
                                            }
                                        })
                                        return false;
                                    }
                                }
                            ])
                        }
                        
                    })
                    .error(function(e,type,msg){
                        var content = template(id, {
                            code:500,
                            msg:type+':'+msg
                        });
                        idialog.content(content).reset()
                    })
                },
                
                removeItem:function(data){
                    var id="item/remove";
                    var title="警告";
                    var content=template(id,data);
                    var idialog=dialog({
                        id : id,
                        zIndex: 5,width:300,
                        padding:"40px 20px",
                        title:title,
                        content:content,
                        button:[
                            {
                                id:"cancel",value:"取消"
                            },
                            {
                                id:"ok",value:"确定删除",
                                autofocus:true,
                                callback:function(){
                                    var $form=this.getContent().find("form");
                                    $form.ajaxSubmit({
                                        onSuccess :function(result){
                                            var code=result.code;
                                            if(code==200){
                                                idialog.remove();
                                                App.reloadItems();
                                            }
                                            else{
                                                var msg=result.msg || "提交失败！";
                                                App.alert(msg);
                                            }
                                        }
                                    })
                                    return false;
                                }
                            }
                        ]
                    });
                    idialog.showModal();
                },
                
                changeItemState:function(data){
                    var id="item/changeItemState";
                    var title="警告";
                    var content=template(id,data);
                    var idialog=dialog({
                        id : id,
                        zIndex: 5,width:300,
                        padding:"40px 20px",
                        title:title,
                        content:content,
                        button:[
                            {
                                id:"cancel",value:"取消"
                            },
                            {
                                id:"ok",value:"提交修改",
                                autofocus:true,
                                callback:function(){
                                    var $form=this.getContent().find("form");
                                    $form.ajaxSubmit({
                                        onSuccess:function(result){
                                            var code=result.code;
                                            if(code==200){
                                                idialog.remove();
                                                App.reloadItems();
                                            }
                                            else{
                                                var msg=result.msg || "提交失败！";
                                                App.alert(msg);
                                            }
                                        }
                                    })
                                    return false;
                                }
                            }
                        ]
                    })
                    idialog.showModal();
                },
                
                init : function(){
                    var that=this;
                    App.getRoleList().then(function(result){
                        that. initForm(result);
                    })
                    
                    App.initPlugins();
                    App.initDatePicker();
                    $("[data-template]").ajaxLoad({
                        dataFilter:function(result){return result}
                    });
                    
                    $("body").on("click","[data-action]",function(){
                        var $this=$(this);
                        var action=$this.data("action");
                        var data=$this.data("params");
                        if(action=="item.remove"){
                            App.removeItem(data);
                        }
                        else if(action=="item.role.edit"){
                            App.editItemRole(data);
                        }
                        else if(action=="item.status.edit"){
                            App.editItemStatus(data);
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