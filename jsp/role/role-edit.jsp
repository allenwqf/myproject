<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<title>编辑角色-角色管理</title>
<c:import url="/public/head-tag.jsp" />
 <link rel="stylesheet" href="/pages/assets/css/user/role.css?v=9384a3671c9338380522cac2556c4636" />
   <style>
   	.tab-labels li{
   		flex:none;
   	}
   	.sitem1 dt {
	    width: 260px;
	}
   </style>
</head>
<body>

	<c:import url="/public/header.jsp" />

	<section class="container">

		<c:set var="sidebar" scope="request" value="user" />
		<c:set var="navbar" scope="request" value="role" />
			<c:import url="/public/sidebar.jsp"/>
			<div class="content" id="mainContainer">
				
			</div>
	</section>

		<script type="text/template" id="item/content">
			
			<div class="content-top">
				<h3 class="content-title">
					<div class="bread">
						<a href="/car-platform/role/listPage">角色管理</a> <span>&gt;</span> <span>编辑角色</span>
					</div>
				</h3>
			</div>
			<div class="content-main">
				<div class="block block-main">
					<ul class="tab-labels" id="tab-labels">
						<li><a href="#block_info">基本信息</a></li>
						<li><a href="#block_auth">权限配置</a></li>
					</ul>
					<div class="block-content">
						<form class="fn-hide" action="/car-platform/role/updateSave" method="post" goback="/car-platform/role/listPage">
							<div class="form-block">

								<div class="form-row">
									<span class="row-label">英文名称：</span>
									<div class="row-content">
										<input name="ename" type="text" class="text"
											ipattern="^.{1,20}$" iname="英文名称" value = {{role.ename}} />
									</div>
								</div>

								<div class="form-row">
									<span class="row-label">中文名称：</span>
									<div class="row-content">
										<input name="zname" type="text" class="text"
											ipattern="^.{1,20}$" iname="中文名称"  value = {{role.zname}} />
									</div>
								</div>

								<div class="form-row">
									<span class="row-label">角色状态：</span>
									<div class="row-content">
										<select class="select select-col-1" name="status">
											<option value="0" {{if role.status ==0}} selected="selected" {{/if}}> 禁用</option>
                      						<option value="1" {{if role.status ==1}} selected="selected" {{/if}}>正常</option>
										</select>
									</div>
								</div>
								<div class="form-row">
									<span class="row-label">角色介绍：</span>
									<div class="row-content">
										<textarea name="intro" class="text textarea" >{{role.intro}}</textarea>
									</div>
								</div>

								<div class="form-row form-row-btn">
									<div class="row-content">
										<input type="hidden" name="id" value={{role.id }} />
										<input type="submit" value="保存修改" class="btn btn-default" />
									</div>
								</div>
							</div>
						</form>
						<form  class="fn-hide"  id="block_auth" action="/car-platform/role/authupdateSave" method="post">
							<div class="form-block">

								<div class="form-row">
									<span class="row-label">角色：</span>
									<div class="row-content">
										<p class="row-value">{{role.zname}}</p>
									</div>
								</div>

								<div class="form-row">
									<span class="row-label">权限配置：</span>
									<div class="row-content">
										<table class="table table-role">
											<thead>
												<tr>
													<th style="width: 15%;">模块</th>
													<th style="width: 85%;">功能权限</th>
												</tr>
											</thead>
											<tbody>
												{{each rootList as itemroot}}
													<input id="itemRoot" style="display:none;" type="checkbox" name="${itemroot.id }" value="on"  ${itemroot.flag==1?'checked="true"':'' }/>
														<!--从2级菜单遍历嵌套的tr结构-->
														{{each itemroot.subItemList as itemlevel2}}
															<tr data-group>
																<td>
																<input type="checkbox" id={{itemlevel2.id}} name={{itemlevel2.id}}
																	value="on" {{if itemlevel2.flag==1}} checked="true" {{/if}}
																	  action="select-all-toggle" /> 
																	<label 	for={{itemlevel2.id}}>{{itemlevel2.name}}</label></td>
																<td>
																	<!--遍历dl结构-->
																	{{each itemlevel2.subItemList as itemlevel3}}
																		<dl class="sitem sitem1" data-group>
																			<dt>
																				<input type="checkbox" id={{itemlevel3.id}} name={{itemlevel3.id}} value="on" {{if itemlevel3.flag==1}} checked="true" {{/if}} action="select-all-toggle" /> 
																				<label for={{itemlevel3.id}}>{{itemlevel3.name}}</label>
																			</dt>
																			{{each itemlevel3.subItemList as itemlevel4}}
																				<dd>
																					<input type="checkbox" id={{itemlevel4.id}} name={{itemlevel4.id}} value="on" {{if itemlevel4.flag==1}} checked="true" {{/if}}/>
																					<label for={{itemlevel4.id}}>{{itemlevel4.name}}</label>
																				</dd>
																			{{/each}}
																		</dl>
																	{{/each}}
																		
																</td>
															</tr>
														{{/each}}
													{{/each}}
												
											</tbody>
										</table>
									</div>
								</div>

								<div class="form-row form-row-btn">
									<div class="row-content">
									    <input type="hidden" name="roleid" value={{role.id}} />
										<input type="submit" value="保存修改" class="btn btn-default btn-large" />
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>

			</div>
			
		</script>
		

	
	 <script src="/pages/assets/js/require.all.js?v=4293636e2ff5c4a96b189a7661023e42"></script>
     <script>
        requirejs([
        	'vue',  
            'artDialog',  
            'artTemplate', 
        	'vender.actions', 
        	'utils.search',
        	
            'jquery.formcheck', 
            'jquery.ajaxsubmit',
            'jquery.common',
            'jquery.pager'
        ], 
        function(Vue, dialog, template,Action,Search){
        	Action.extend({
				'form.detail':'/car-platform/role/detail?roleId={roleId}',
				'form.add:':'/car-platform/role/createSave',
				'form.edit:':'/car-platform/role/updateSave',
				'form.status:':'/car-platform/role/updateStatus'
       		})
        	var search = new Search().getParams();
            var isEdit = !!search.roleId;
            
   			var App={
   				
   				initDev:(function($){
   					$.extend($.fn,{
   						checkLink:function(options){
   							
							var settings=$.extend({
								toggleAll:"[action='select-all-toggle']",
								group:function(){
									return $(this).parents('[data-group]:first')
								}
							},options)
							
							return this.each(function(){
								var $this=$(this);
								var $toggleAll=$this.find(settings.toggleAll);
								$this.on("click","input:checkbox",function(){
									var $target=$(this);
									if($target.is(settings.toggleAll)){
										var $group=settings.group.apply($target);
										$group.find("input:checkbox").prop("checked",$target.is(":checked"))
									}
									else{
										$toggleAll.prop("checked",$this.find("input:checkbox:not(:checked)").filter(":not("+settings.toggleAll+")").length==0)
									}
								})
							})
						},
   						checkLink:function(options){
   							
							var settings=$.extend({
								toggleAll:"[action='select-all-toggle']",
								group:function(){
									return $(this).parents('[data-group]:first')
								}
							},options)
							
							return this.each(function(){
								var $this=$(this);
								var $toggleAll=$this.find(settings.toggleAll);
								$this.on("click","input:checkbox",function(){
									var $target=$(this);
									if($target.is(settings.toggleAll)){
										var $group=settings.group.apply($target);
										$group.find("input:checkbox").prop("checked",$target.is(":checked"))
										$group.parents('[data-group]:first').find(settings.toggleAll+':first').prop('checked', true)
									}
									else{
										if($target.prop('checked')){
											$target.parents('[data-group]:first').find(settings.toggleAll+':first').prop('checked', true).end().parents('[data-group]:first').find(settings.toggleAll+':first').prop('checked', true)
										}
										//$toggleAll.prop("checked",$this.find("input:checkbox:not(:checked)").filter(":not("+settings.toggleAll+")").length==0)
									}
								})
							})
						}
   					})
   				}(jQuery)),
   				
   				
   				
   				getAppData :function(){
                    
                    var dtd = $.Deferred();
                    
                    var defaultData ={
                    }
                    if(!isEdit){
                         return dtd.resolve(defaultData);
                    }else{
	                    var url = Action.get('form.detail',search);
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
                    }
                    return dtd;
                },
                
                initForm:function(formData){
                	var mainHtml=template("item/content",formData)
					$("#mainContainer").html(mainHtml);
    				
				},
    			
   				
    			initEvents:function(){
    				
    				$(".table-role").checkLink()
    				
    				$("#tab-labels").tabs({
						tabContent : function(t){
							return $(this).next().children().hide();
						}
					})
    				
					$("form").ajaxSubmitify({
						beforeSubmit:function(){
							 $('#itemRoot').prop('checked', $('tr[data-group]').not(':last').find(':checked').length>0)
						},
						onSuccess:function(result){
							var $this=$(this);
							var code=result.code;
							if(code==200){
								alert('修改成功！');
							}
							else{
								var msg=result.msg || "提交失败！";
								App.alert(msg);
							}
						}
					})
    			},
    			
    			init : function(){
					var app = this;
    				
    				this.getAppData()
    				.then(function(data){
    					app.initForm(data);
    					app.initEvents();
    				})
    				.fail(function(msg){
    					app.alert(msg)
    				})
    			}
    		}
    		App.init();
    	})
   </script>
    </body>
</html>