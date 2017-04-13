<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	<title>个人设置</title>
	
    <c:import url="/public/head-tag.jsp"/>
    <style>
        /* 必需 */
	    .xiuxiu-upload-container,div.xiuxiu-upload{
			width:160px;
			height:160px;
		}
		.row-label-content{
    		width:100px
    	}
		.text-100{
    		width:200px;
    	}
    	
    	.text-150{
    		width:150px;
    	}
    	
    	.row-content-container{
    		padding-left:20px;
    	}
    </style>
</head>
<body>
	
    <c:import url="/public/header.jsp"/>
    <section class="container">
    	
	    <c:set var="sidebar" scope="request" value="setting"/>
	    <c:set var="navbar" scope="request" value="setting"/>
	    <c:import url="/public/sidebar.jsp"/>
		
    	<div class="content" id="app">
    		<div class="content-top">
                <h3 class="content-title">
                    <div class="bread">
                    	<span>个人设置</span>
                    </div>
                </h3>
    		</div>
    		<div class="content-main">
    			<div class="block-content">
                     <div class="form-block" >
     			        <form id="form1" data-form="one" method="post" goback=" action="/Manager/web/sysuser/listSearch">
                              <div class="form-row">
								<span class="row-label">头&nbsp;&nbsp;像:</span>
								<div class="row-content">
									<div  xx-upload class="xiuxiu-upload-container">
										<textarea type="config" style="display:none;" v-text="getImageConfig(program.avatar) | json"></textarea>
									</div>
									<p class="value-note">图片规格：160x160</p>
								</div>
							</div>
                             <div class="form-row">
                                 <input name="id" type="hidden" v-model="program.id">	
                                 <span class="row-label">昵&nbsp;&nbsp;称：</span>
                                 <div class="row-content">
                                     <input name="nick" type="text" class="text text-150" v-model="program.nick" iname="昵称" itip="昵称"/>
                                 </div>
                             </div>
				        	
				        	
                             <div class="form-row">
                                 <span class="row-label">账&nbsp;&nbsp;号：</span>
                                 <div class="row-content">
                                 	<div class="row-value">
                                 		<p  v-text="program.name"></p>
                                 	</div>
                                 </div>
                             </div>
                          	<div class="form-row">
                                 <span class="row-label">角&nbsp;&nbsp;色：</span>
                                 <div class="row-content">
                                 	<div class="row-value">
                                 		<template  v-if="program.superManager==1">
	                                 		<p>管理员</p>
                                 		</template>
                                 		<template v-else>
                                 			<p>暂无</p>
                                 		</template>
                                 	</div>
                                 </div>
                             </div>
                             <div class="form-row">
                                 <span class="row-label">密&nbsp;&nbsp;码：</span>
                                 <div class="row-content">
                                 	<div class="row-value">
                                 		<input type="hidden" name="password" v-model="program.password" />
                                 		<p>******</p>
		                            	<a href="javascript:;" @click="updatepw" class="action-link">修改密码</a>
		                            </div>
                                 </div>
                             </div>
                     </form>
                     <div class="form-row form-row-btn">
                         <button class="btn btn-default btn-large" @click="save()" >保存</button>
                     </div>
                </div>
    		</div>
    	</div>
    </section>
    
     <script type="text/template" id="item/update" note="密码修改">
		<form  method="post">
            <div class="form-row">
                <span class="row-label row-label-content" >旧密码：</span>
            	<div class="row-content row-content-container">
                    <input type="password" class="text text-100" name="source"  placeholder="输入旧密码"  itip="旧密码" iname="旧密码"/>
            	</div>
        	</div>
            <div class="form-row">
                <span class="row-label row-label-content" >新密码：</span>
                <div class="row-content row-content-container">
                    <input type="password" class="text text-100" name="target"   placeholder="输入新密码"  itip="新密码" iname="新密码"/>
                </div>
            </div>
            <div class="form-row">
                <span class="row-label row-label-content">新密码：</span>
                <div class="row-content row-content-container">
                    <input type="password" class="text text-100" name="target2"  placeholder="再次输入新密码" irequired="true" itip="再次输入新密码"  iname="再次输入新密码"/>
                </div>
            </div>
		</form>
    </script>
    
    
   <script src="/pages/assets/js/require.all.js?v=4293636e2ff5c4a96b189a7661023e42"></script>
   <script type="text/javascript">
        requirejs([
            'vue',
            'artTemplate', 
            'artDialog',  
            'vender.modal',
            
            'vender.actions',
            'utils.search', 
            'vender.xxupload',
            
            'jquery.formcheck', 
            'jquery.ajaxsubmit',
            'jquery.common'
        ], 
        function(Vue, template, dialog, Modal, Action, Search, XXUpload){
    		
            var relateUid;
            Action.extend({
            	'form.detail':'/car-platform/web/sysuser/myselfinfo',
            	'form.save':'/car-platform/web/sysuser/myselfinfo/save',
            	'form.password':'/car-platform/web/sysuser/updatepwd'
            	
            })
            var App={
            	alert : function(tip, type){
                       	return Modal.alert.apply(this, [tip, null, type]);
                    },
                tip:function(msg,type){
                	return Modal.tip(msg,type)
                },
                getFormData :function(){
                    var dtd = $.Deferred();
                    var action = Action.get('form.detail');
                    $.getJSON(action)
                    .success(function(result){
	                    dtd.resolve(result.data);
                    }).fail(function(e){
                    	app.tip("关联失败",Modal.MsgType.ERROR);
                    	dtd.reject('null')	;
                    });
                    
                    return dtd;
                },
                initForm:function(formData){
                    var app = this;
                    
                    var vueApp = new Vue({
                        el:'#app',
                        data :function(){
                        	return {
                        		program :formData,
                        	}
                        },
                        methods:{
                        	getImageConfig:function(value){
    							return {
									name:'avatar',
									checker:{
										iname:'头像',
										itip:'请上传头像'
									},
									value:value
								}
    						},
                            save:function(){
                                var that = this;
								var $form1 = $('form[data-form=one]');
                                var actionURL=Action.get('form.save',that.program);
								
								$form1.checkForm({
									onSuccess:function(){
	                                    var params= $form1.serialize();
	                                    $.post(actionURL,$.deParam(params),function(result){
		                                    var code=result.code;
		                                	if(code==200){
		                                    	app.tip("修改成功",Modal.MsgType.SUCCESS);
		                                	}else{
		                                		var msg=result.msg || "提交失败！";
												app.tip(msg,Modal.MsgType.ERROR);
		                                	}
		                                })
		                                .fail(function(e){
		                                	app.alert(e.msg)
		                                });
			                        },
		                            onFail:function(e){
		                                alert(e);
		                                e.target.focus();
		                            }
								
								})
								
                            },
                            updatepw:function(data){
		        				var id="item/update";
		   	    				var title="密码修改";
		   	    				var content=template(id,data);
		   						var idialog=dialog({
		   							id : id,
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
		   										var params=$.deParam($form.serialize());
		   										if(params.target!=params.target2){
		   				        					app.alert("两次输入新密码不一样，请重新输入");
		   				        				}else{
		   				        					$form.checkForm({
			   				        					onSuccess:function(){
						                                    var data={
			   				        							"oldPwd":params.source,
			   				        							"newPwd":params.target
			   				        						}
			   				        						var actionURL=Action.get("form.password");
				   		                                    $.post(actionURL,data,function(result){
				   		                                    	var code=result.code;
				   		                                    	if(code==200){
					   		                                    	app.tip("修改成功",Modal.MsgType.SUCCESS);
				   		                                    	}else{
				   		                                    		var msg=result.msg || "提交失败！";
																	app.tip(msg,Modal.MsgType.ERROR);
				   		                                    	}
				   		                                    }).fail(function(e){
				   		                                    	app.tip("操作失败",Modal.MsgType.ERROR);
				   		                                    });
				   		                                 idialog.close();
								                        },
							                            onFail:function(e){
							                                alert(e);
							                                e.target.focus();
							                            }
		   				        					})
	   				        					}
		   										return false;
		   									}
		   								}
		   							]
		   						})
		   						idialog.showModal();
		        			}
						},
                    })
                },
                init : function(){
                    var app = this;
                    app.getFormData()
                    .then(function(data){
                        app.initForm(data);
                        XXUpload('[xx-upload]',{size:'160:160'});
                    })
                    .fail(function(e){
                    	app.alert(e)
                    })
                }
            }
            App.init();
        })
   </script>
    </body>
</html>