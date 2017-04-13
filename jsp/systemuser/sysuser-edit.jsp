<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<!--[if lt IE 7 ]><html class="ie ie6"><![endif]-->
<!--[if IE 7 ]><html class="ie ie7"><![endif]-->
<!--[if IE 8 ]><html class="ie ie8"><![endif]-->
<!--[if IE 9 ]><html class="ie ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html>
    <!--<![endif]-->

    <head>
        <meta charset="utf-8">
        <meta name="renderer" content="webkit">
        
        <meta name="viewport" content="initial-scale=1,minimum-scale=1" />
        <title>账号管理</title>
        <c:import url="/public/head-tag.jsp" />
        <style type="text/css">
            .menustyle {
                width: 100px;
            }
            
            .contentstyle {
                padding-left: 50px;
            }
        </style>
    </head>

    <body>

        <c:import url="/public/header.jsp" />

        <section class="container" id="app">

            <c:set var="sidebar" scope="request" value="user" />
            <c:set var="navbar" scope="request" value="sysuser" />
            <c:import url="/public/sidebar.jsp" />

            <div class="content">
                <div class="content-top">
                    <h3 class="content-title">
                    <div class="bread">
                        <a href="/car-platform/web/sysuser/listPage">账号管理</a>
                        <span>&gt;</span>
                        
                        <template v-if="isEdit">
                            <span >编辑</span>
                        </template>
                        
                        <template v-else>
                            <span >添加</span>
                        </template>
                    </div>
                </h3>
                </div>
                <div class="content-main">
                    <div class="block block-main">
                        <div v-if="!editing" class="block-content loading">
                            loading...
                        </div>
                        <template v-else>
                            <div class="block-content">
                                <form action="/car-platform/sysuser/saveorupdate" method="post" goback="/car-platform/web/sysuser/listPage">
                                    <div class="form-block">
                                        
                                        <div class="form-row">
                                            <span class="row-label menustyle">账&nbsp;&nbsp;号：</span>
                                            <div class="row-content contentstyle">
                                                <input name="username" type="text" class="text" iname="登录用户名" v-model="form.name" placeholder="登录用户名" />
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <span class="row-label menustyle">昵&nbsp;&nbsp;称：</span>
                                            <div class="row-content contentstyle">
                                                <input name="nick" type="text" class="text" iname="用户昵称" autocomplete="off"  v-model="form.nick" placeholder="用户昵称" />
                                            </div>
                                        </div>
                                         <div class="form-row">
                                            <span class="row-label menustyle">密&nbsp; &nbsp; 码：</span>
                                            <div class="row-content contentstyle">
                                                <input type="password" name="password" class="text" iname="密码" v-model="form.password" autocomplete="off"  placeholder="密码"  />
                                            </div>
                                        </div> 
                                        
                                        <div class="form-row">
                                            <span class="row-label menustyle">状&nbsp;&nbsp;态：</span>
                                            <div class="row-content contentstyle">
                                                <input type="radio" name="status" value="1" id="status_1"  checked="checked"  />
                                                <label for="status_1">启用</label>
                                                <input type="radio" name="status" value="0"  id="status_0"/>
                                                <label for="status_0">禁用</label>
                                            </div>
                                        </div>
                                        

                                        <div class="form-row">
                                            <span class="row-label  menustyle">邮&nbsp;&nbsp;箱：</span>
                                            <div class="row-content contentstyle">
                                                <input name="email" type="text" class="text" v-model="form.email"   /> 
                                            </div>
                                        </div>
                                        
                                        <div class="form-row">
                                            <div class="form-row form-row-btn">
                                                <template v-if="form.id" >
	                                                <input type="hidden" name="id" v-model="form.id" />
	                                            </template>
                                                <input type="submit" value="保存修改" class="btn btn-default btn-large"  style=" margin-left: -26px;" />
                                            </div>
                                        </div>
                                </form>
                            </div>

                        </template>
                    </div>

                </div>
            </div>
        </section>
        

        <script src="/pages/assets/js/require.all.js?v=4293636e2ff5c4a96b189a7661023e42"></script>
        <script>
            requirejs([
                    'vue',
                    'artDialog',
                    'artTemplate',
                    'moment',
                    'select.linkage',

                    'utils.search',
                    'vender.modal',
                    'vender.types',
                    'vender.actions',

                    'jquery.formcheck',
                    'jquery.ajaxsubmit',
                    'jquery.common'
                ],
                function(Vue, dialog, template, moment, selectLinkage, Search, Modal, Field, Action) {

                    var search = new Search().getParams();
                    var isEdit = !!search.id;

                    Action.extend({
                        'form.detail': '/car-platform/sysuser/detail?id={id}',
                        'form.save': '/car-platform/sysuser/saveorupdate'
                    })
                    
                    var App = {

                        alert: function() {
                            alert(arguments[0]);
                        },
                        reloadItems: function() {
                            $("#box").reload();
                        },
                        
                        
                        getAppData: function() {
                            var dtd = $.Deferred();

                            var that = this;
                            var defaultData = {
                                "id":"",
                                "name":"",
                                "nick":"",
                                "password":"",
                            };

                            if(!isEdit) {
                                return dtd.resolve(defaultData);
                            } else {
                                var url = Action.get('form.detail', search);
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
                            }
                            return dtd;
                        },
                        
                        initForm: function(formData) {
                            new Vue({
                                el: '#app',
                                data: function() {
                                    return {
                                        editing: true,
                                        form: formData
                                    }
                                },
                                computed: {
                                    'isEdit': function() {
                                        return isEdit;
                                    }
                                },
                                methods: {
                                }

                            })

                        },
                        

                        initDOMEvents: function() {
                            $("form").ajaxSubmitify({
                                onFail: function(e) {
                                    var type = e.target ? Modal.MsgType.WARN : Modal.MsgType.ERROR;
                                    var msg = e.target ? e.msg : e;
                                    Modal.alert(msg, null, type).then(function() {
                                        setTimeout(function() {
                                            e.target && e.target.focus();
                                        }, 0)
                                    });
                                },
                                afterSuccess: function() {
                                    Modal.tip('提交成功', Modal.MsgType.SUCCESS);
                                    //window.close();
                                }
                            });
                        },

                        init: function() {
                            var app = this;
                            app.getAppData()
                            .then(function(data) {
                                app.initForm(data);
                                app.initDOMEvents();
                                
                            })
                            .fail(function(msg) {
                                app.alert(msg)
                            })

                        }
                    }

                    App.init();
                })
        </script>
    </body>

</html>