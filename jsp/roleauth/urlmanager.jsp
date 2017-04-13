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
<title>权限管理-系统管理</title>
<c:import url="/public/head-tag.jsp" />
<c:import url="/public/head-tag.jsp" />

<link rel="stylesheet" href="/pages/assets/css/user/auth.css?v=e5a1517409057e82a2d1a09ec37b0105" />
</head>
<body>

	<c:import url="/public/header.jsp" />

	<section class="container">

		<c:set var="sidebar" scope="request" value="user" />
		<c:set var="navbar" scope="request" value="auth" />
		<c:import url="/public/sidebar.jsp"/>

		<div class="content">
			<div class="content-top">
				<h3 class="content-title">权限管理</h3>
			</div>
			<div class="content-main">
				<div id="trees" class="block block-left">
				</div>
				<div class="block block-main">
					<div class="block-content" id="form"></div>
				</div>

			</div>
		</div>
	</section>

	<script type="text/template" id="form/empty" title="默认提示">
	   	<div class="node-tip">
		   	<ul>
				<li>在左侧选择节点操作</li>
				<li>节点可拖拽</li>
			</ul>
	   	</div>
   </script>

	<script type="text/template" id="form/edit" title="编辑菜单">
   	<h3 class="block-title  bread">
   		<span>编辑菜单</span>
   		<div class="fn-right">
   			
   			{{if true || level<4}}
   			<input type="button" action="node.add" value="+添加下级" class="btn btn-small btn-green" />
   			{{/if}}
   			
   			{{if true || level>1}}
    		<input type="button" action="node.delete" value="-删除菜单" class="btn btn-small btn-red" />
   			{{/if}}
	   	</div>
   	</h3>
   	<form id="form"  action="/car-platform/urlmanager/updateSave" method="post">
		<div class="form-block">
			<div class="form-row">
				<span class="row-label">父级：</span>
				<div class="row-content">
					<input type="text" class="text" name="superId" value="{{superId}}">
					<p class="row-value">{{parentName}}</p>
				</div>
			</div>
			<div class="form-row">
				<span class="row-label">ID：</span>
				<div class="row-content">
					<input name="id" value="{{id}}" type="text" class="text" ipattern="^.{1,64}$" iname="该子节点ID" readonly >
			    </div>
   
			</div>
			<div class="form-row">
				<span class="row-label">名称：</span>
				<div class="row-content">
					<input name="name" value="{{name}}" type="text" class="text" ipattern="^.{1,64}$" iname="名称">
				</div>
			</div>
			<div class="form-row">
				<span class="row-label">别名：</span>
				<div class="row-content">
					<input name="label" value="{{label}}" type="text" class="text" irequired="false" ipattern="^.{1,64}$" iname="别名">
				</div>
			</div>
			<div class="form-row">
				<span class="row-label">路径：</span>
				<div class="row-content">
					<input name="url" value="{{url}}" readonly="true" type="text" class="text" irequired="false"  ipattern="^.{1,64}$" iname="路径">
					<a href="javascript:;" action="url.select" class="action-link">查看列表</a>
				</div>
			</div>
			<div class="form-row">
				<span class="row-label">排序：</span>
				<div class="row-content">
					<input name="sort" value="{{sort}}" type="text" class="text" irequired="false" ipattern="^.{1,64}$" iname="排序">
				</div>
			</div>
			<div class="form-row">
				<span class="row-label">显示菜单：</span>
				<div class="row-content">
					<div class="row-value">
					<input id="is_menu_1" type="radio" name="isMenu" {{if isMenu}}checked="checked"{{/if}} value="1" />
					<label for="is_menu_1">是</label>
					<input id="is_menu_0" type="radio" name="isMenu" {{if !isMenu}}checked="checked"{{/if}} value="0" />
					<label for="is_menu_0">否</label>
					</div>
				</div>
			</div>
			<div class="form-row">
				<span class="row-label">状态：</span>
				<div class="row-content">
				    <select class="select select-col-1" name="status">
	                  <option value="1" {{if status==1}}selected="checked"{{/if}} >正常</option>
				      <option value="0" {{if status==0}}selected="checked"{{/if}} >禁用</option>
			        </select>
				</div>
			</div>
			<div class="form-row">
				<span class="row-label">备注：</span>
				<div class="row-content">
					<textarea name="intro" class="text textarea">{{intro}}</textarea>
				</div>
			</div>
			<div class="form-row form-row-btn">
				<div class="row-content">
					<input name="id" type="hidden" value="{{id}}">
					<input name="superId" type="hidden" value="{{parent}}">
					<input type="submit" action="form.submit" value="保存修改" class="btn btn-default btn-large">
				</div>
			</div>
		</div>
		</form>
   </script>

	<script type="text/template" id="form/add" title="添加子菜单">
	   	<h3 class="block-title bread">
	   		<a href="#" action="node.show">编辑菜单</a>
	   		<span>&gt;</span>
	   		<span>添加下级</span>
	   	</h3>
	   	<form  action="/car-platform/urlmanager/createSave" method="post">
			<div class="form-block">
				<div class="form-row">
					<span class="row-label">父级：</span>
					<div class="row-content">
						<p class="row-value">{{name}}</p>
					</div>
				</div>
				<div class="form-row">
					<span class="row-label">名称：</span>
					<div class="row-content">
						<input name="name"  type="text" class="text" ipattern="^.{1,64}$" iname="名称">
					</div>
				</div>
				<div class="form-row">
					<span class="row-label">别名：</span>
					<div class="row-content">
						<input name="label" type="text" class="text" irequired="false" ipattern="^.{1,64}$" iname="别名">
					</div>
				</div>
				
				<div class="form-row">
					<span class="row-label">路径：</span>
					<div class="row-content">
						<input name="url"  type="text" readonly="true" class="text" irequired="false"  ipattern="^.{1,64}$" iname="路径">
						<a href="javascript:;" action="url.select" class="action-link">查看列表</a>
					</div>
				</div>
				<div class="form-row">
					<span class="row-label">排序：</span>
					<div class="row-content">
						<input name="sort" value="0" type="text" class="text" irequired="false" ipattern="^.{1,64}$" iname="排序">
					</div>
				</div>
				<div class="form-row">
					<span class="row-label">显示菜单：</span>
					<div class="row-content">
						<div class="row-value">
						<input id="is_menu_1" type="radio" name="isMenu"  value="1" />
						<label for="is_menu_1">是</label>
						<input id="is_menu_0" type="radio" name="isMenu" checked="checked"  value="0" />
						<label for="is_menu_0">否</label>
						</div>
					</div>
				</div>
				<div class="form-row">
					<span class="row-label">状态：</span>
					<div class="row-content">
					    <select class="select select-col-1" name="status">
	                      <option value="1" >正常</option>
					      <option value="0" >禁用</option>
				        </select>
					</div>
				</div>
				<div class="form-row">
					<span class="row-label">备注：</span>
					<div class="row-content">
						<textarea name="intro" class="text textarea"></textarea>
					</div>
				</div>
				<div class="form-row form-row-btn">
					<div class="row-content">
						<input name="superId" type="hidden" value="{{id}}">
						<input type="submit" action="form.submit" value="确认添加" class="btn btn-default btn-large">
					</div>
				</div>
			</div>
		</form>
   </script>

	<script type="text/template" id="form/delete" title="删除菜单">
	   	<h3 class="block-title bread">
	   		<a href="#" action="node.show">编辑菜单</a>
	   		<span>&gt;</span>
	   		<span>删除菜单</span>
	   	</h3>
	   	<form  action="/Manager/web/authmanager/deleteSave" method="post">
			<div class="form-block">
				<div class="form-row">
					<span class="row-label">父级：</span>
					<div class="row-content">
						<p class="row-value">{{parentName}}</p>
					</div>
				</div>
              <div class="form-row">
					<span class="row-label">该节点ID：</span>
					<div class="row-content">
						<p class="row-value">{{id}}</p>
					</div>
				</div>
				<div class="form-row">
					<span class="row-label">名称：</span>
					<div class="row-content">
						<p class="row-value">{{name}}</p>
					</div>
				</div>
				<div class="form-row">
					<span class="row-label">层级：</span>
					<div class="row-content">
						<p class="row-value">{{level}}</p>
					</div>
				</div>
				<div class="form-row">
					<span class="row-label">路径：</span>
					<div class="row-content">
						<p class="row-value">{{url}}</p>
					</div>
				</div>
				<div class="form-row">
					<span class="row-label">状态：</span>
					<div class="row-content">
						<p class="row-value">{{status==1?'正常':'禁用'}}</p>
					</div>
				</div>
				<div class="form-row">
					<span class="row-label">备注：</span>
					<div class="row-content">
						<p class="row-value">{{intro}}</p>
					</div>
				</div>
				<div class="form-row form-row-btn">
					<div class="row-content">
						<input name="id" type="hidden" value="{{id}}">
						<input type="submit" action="form.submit" value="确认删除" class="btn btn-default btn-red">
					</div>
				</div>
			</div>
		</form>
   </script>
    
    <script type="text/template" id="content/item/select" title="选择">
        <style>
            .block-item-select .content-item-block{
                height:350px;
				width:500px;
                overflow-y:scroll;
            }
        </style>
        <section class="content-block block-item-select">
            <div class="content-item" data-template="content/list/item">
                <div class="content-item-top">
                   <input placeholder="输入URL筛选" type="text" name="sw" v-model="sw" class="text"/>
                </div>
                <div class="content-item-block scrollbar">
                    <table class="table">
                        <thead>
                            <tr>
                                <th style="width:90%" v-text="list.length + '条'"></th>
                                <th style="width:10%"></th>
                            </tr>
                        </thead>
                        <tbody>
	                        <tr v-for="item in list">
		                        <td class="align-left">
		                            <input :data-params="item | json 0" :data-disabled="!!item.name" :id="'item_' + $index"  :value="item.uri" type="radio" name="content_item" />
		                            <label :for="'item_' + $index" v-text="item.name + '-' + item.uri"></label>
		                        </td>
		                    </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </section>
    </script>
    
   <script src="/pages/assets/js/require.all.js?v=4293636e2ff5c4a96b189a7661023e42"></script>
   <script>
        requirejs([
            'vue',  
            'artDialog',  
            'artTemplate', 
            
            'utils.search', 
            'utils.converter', 
            
            'vender.actions', 
            'vender.modal', 
            'vender.actions', 
             
            'jquery.formcheck', 
            'jquery.ajaxsubmit',
            'jquery.common',
            'jquery.jstree'
        ],
        function(Vue, dialog, template,  Search, Converter, Action, Modal){
        	
        	var search = new Search().getParams();
            
            Action.extend({
//          	'auth.list' : '/Manager/web/operations',
//          	
//          	'menu.list' : '/Manager/web/authmanager/listSearch',
//          	'menu.add' : '/Manager/web/authmanager/createSave',
//          	'menu.update' : '/Manager/web/authmanager/updateSave',
//          	'menu.delete' : '/Manager/web/authmanager/createSave'
				'auth.list' : '/car-platform/operations',
				///urlmanager/listSearch
            	
//          	'menu.list' : '/car-platform/role/listQuery',
				'menu.list' : '/car-platform/urlmanager/listSearch',
            	'menu.add' : '/car-platform/urlmanager/createSave',
            	'menu.update' : '/car-platform/urlmanager/updateSave',
            	'menu.delete' : '/car-platform/urlmanager/deleteSave'
            })
            
   			var App={
   				
    			alert : function(){
    				alert(arguments[0]);
    			},
    			MAX_LEVEL:10,
    			initTrees:function(data){
    				var app=this;
    				
    				app.$tree=$('#trees');
    				app.$tree=app.$tree.jstree({
						  "core" : {
						    'check_callback' : function (operation, node, node_parent, node_position, more) {
					            // operation can be 'create_node', 'rename_node', 'delete_node', 'move_node' or 'copy_node'
					            // in case of 'rename_node' node_position is filled with the new node name
					            try{
						            return node.data.level - node_parent.data.level ==1;
//						            return ok;
					            }catch(e){return false}
					         },
					         multiple :false,
						    'expand_selected_onload':false,
						    "themes" : { "stripes" : true },
						    'data' :  function (obj, callback) {
						    	var that=this;
						    	app.getNodes(obj,function(data){
						            callback.call(that, data);
						    	})
					       }
						  },
						  'contextmenu':{
						  	'items':{
						  		'createItem':{
						  			label:'刷新',
						  			action:function(){
						  				app.refreshNode();
						  			}
						  		}
						  	}
						  },
						  "types" : {
						    "#" : {
						      "max_children" : 1, 
						      "max_depth" : 10,
						      'valid_children':['default']
						    },
						    "root" : {
						      "valid_children" : ["default",'file']
						    },
						    "file" : {
					    	  "icon" : "icon-file",
						      "valid_children" : []
						    }
						  },
						  "plugins" : [
						    "dnd", "state", "types", "wholerow","contextmenu"
						  ]
    				})
    				.on('changed.jstree', function (e, data) {
    					var currentNode=data.node;
    					if(!currentNode) return 
    					
	    				var nodeParent=app.$tree.jstree(true).get_node(currentNode.parent);
	    				
	    				currentNode.data.parent=nodeParent.text;
	    				currentNode.data.parentName=nodeParent.text;
	    				
    					app.currentNode=currentNode;
    					
    					app.showNodeView();
    				})
    				.on('move_node.jstree', function (e, data) {
    					
    					var currentNode=data.node;
    					if(!currentNode) return ;
    					
    					var instance=app.$tree.jstree(true);
    					
	    				var nodeParent=instance.get_node(currentNode.parent);
	    				var oldNodeParent=instance.get_node(data.old_parent);
	    				
	    				if(nodeParent.id==oldNodeParent.id) return false;
	    				
	    				currentNode.data.parent=nodeParent.parent;
	    				currentNode.data.parentName=nodeParent.text;
	    				
	    				currentNode.data.oldParent=data.old_parent;
	    				currentNode.data.oldParentName=oldNodeParent.text;
	    				
	    				instance.open_node(currentNode.parent)
	    				instance.select_node(currentNode.id)
	    				
    					app.currentNode=currentNode;
    					
    					app.moveNode();
    					//console.info('node moved',data)
    				})
    				.on('delete_node.jstree', function (e, data) {
    					//console.info('node deleted',data)
    				})
    				app.showNodeView();
    			},
    			
                getAuthURL :function(){
                    var app = this;
                    var dtd = $.Deferred();
                    
                    $.getJSON(Action.get('auth.list'))
                    .then(function(result){
                        if(Action.ifSucceed(result) ){
                            dtd.resolve(Action.getResultData(result))
                        }
                        else{
                        	var msg = Action.getResultError(result, '数据获取失败！');
                            dtd.reject(msg);
                        }
                    })
                    .fail(function(e, type, msg){
                        dtd.reject(type + msg)
                    })
                    
                    return dtd;
                },
                
                chooseContentItem : function(){
                    var app = this;
                    var dtd = $.Deferred();
                    
                    var id="content/item/select";
                    var tplDom = document.getElementById(id)
                    var title=tplDom.title ;
                    
                    //var content=template(id, {});
                    var content=tplDom.innerHTML;
                    var idialog=dialog({
                        id : id,
                        title:title,
                        content:content,
                        onshow:function(){
                        	var el = this.getContent()[0];
                        	var vueApp = new Vue({
                        		el:el,
                        		watch:{
                        			'sw':function(val, oldVal){
                        				this.search();
                        			}
                        		},
                        		computed:{
                        			list:function(){
                        				var that = this;
                        				if(this.store.list.length==0) {
	                        				app.getAuthURL().then(function(data){
	                        					that.store.list = data.sort(function(a, b){
	                        						return a.status - b.status
	                        					});
	                        				}).fail(function(msg){
	                        					
	                        				})
                        				}
                        				return that.store.list.filter(function(item){
                        					return item.uri.indexOf(that.store.sw)!=-1
                        				})
                        			}
                        		},
                        		filters:{
                        			search:function(sw){
                        				
                        			}
                        		},
                        		methods:{
                        			search:function(){
                        				this.store.sw = this.sw;
                        			},
                        			select:function(item){
                        				this.store.active = item;
                        			}
                        		},
                        		data:function(){
                        			return {
                        				store:{
                        					list:[],
                        					sw:''
                        				}
                        			}
                        		}
                        	})
                        	
                        },
                        onclose:function(){
                            dtd.reject();
                            this.remove();
                        },
                        zIndex: 5,
                        width:500,
                        button:[
                            {
                                id:"cancel",value:"取消"
                            },
                            {
                                id:"ok",value:"确定",
                                autofocus:true,
                                callback:function(){
                                    var $input=this.getContent().find("input:checked");
                                    if(!$input.length) {
                                        alert('请选择！')
                                        return false;
                                    }
                                    var params = $input.data('params');
                                    dtd.resolve(params)
                                }
                            }
                        ]
                    }).showModal();
                    
                    return dtd;
                },
                
                getFormData :function(){
                    
                    var dtd = $.Deferred();
                    var url = Action.get('menu.detail')
                    $.getJSON(url, function(result){
                        var code = result.code;
                        if(code==200){
                            dtd.resolve(result.data || [])
                        }else{
                            var msg = result.msg || '数据获取失败！';
                            dtd.reject(msg)
                        }
                    })
                    .fail(function(e, type, msg){
                        dtd.reject(type + msg)
                    })
                    return dtd;
                },
    			
    			getNodes:function(obj,callback){
    				
    				var app=this;
    				
    				/*var newList=[];
    				
    				$.each(app.mockData1(obj),function(i,value){
    					newList.push(app.buildJSTreeData(value))
    				})
    				
    				callback(newList);
    				return;*/
    				
    				var url=Action.get('menu.list');
    				var data={};
    				if(obj && obj.data) data.id=obj.data.id;
    				
    				$.ajax({
    					url:url,
    					data:data,
    					success:function(result){
    							
    						var code=result.code;
    						if(code==200){
    							
    							var newList=[];
    							
    							var list = result.data;
    							
			    				$.each(list,function(i,value){
			    					newList.push(app.buildJSTreeData(value))
			    				})
			    				
			    				callback(newList);
    						}
    						else{
    							var msg=result.msg||'数据获取失败！';
    							alert(msg);
    						}
    					},
    					fail:function(e,type,msg){
    						alert([type,msg].join(':'))
    					}
    				})
    			},
    			
    			// 刷新node
    			refreshNode:function(config){
    				var app=this;
    				
    				var currentNode=app.currentNode;
    				var settings=$.extend({
    					current:true,
    					parent:false,
    					oldParent:false
    				},config)
    				
    				var instance=app.$tree.jstree(true);
    				
    				if(settings.current) instance.refresh_node(currentNode.id);
    				if(settings.parent) instance.refresh_node(currentNode.parent);
    				if(settings.oldParent) instance.refresh_node(currentNode.data.oldParent);
    			},
    			
    			moveNode:function(){
    				var app=this;
    				var currentNode=app.currentNode;
    				var data=currentNode.data;
    				data.superId=data.parent;
    				
    				var url=Action.get('menu.update');
    				
    				$.ajax({
    					url:url,
    					method:'post',
    					dataTpye:'json',
    					data:data,
    					success:function(result){
    						var code=result.code;
    						if(code==200){
    							console.info('转移成功！');
    							app.$tree.jstree(true).deselect_all();
    							app.$tree.jstree(true).select_node(currentNode);
    							app.refreshNode({current:false,parent:false,oldParent:true});
    						}
    						else{
    							var msg=result.msg || '转移失败！';
								app.refreshNode({current:false,parent:true,oldParent:true});
    							alert(msg);
    						}
    					},
    					fail:function(e,type,msg){
							app.refreshNode({current:false,parent:true,oldParent:true});
    						alert([type,msg].join(':'))
    					}
    				})
    			},
    			
    			createNodeView:function(){
    				var app=this;
    				var currentNode=app.currentNode;
    				
    				var $formBlock=$('#form');
    				var data=currentNode.data;
    				
    				var html=template('form/add',data);
    				$formBlock.html(html);
    				
    				$formBlock.find('form').ajaxSubmitify({
						onSuccess:function(result){
							if(Action.ifSucceed(result)){
								Modal.tip('添加成功！', Modal.MsgType.SUCCESS);
								app.refreshNode();
								app.showNodeView();
							}else{
								var msg= Action.getResultMsg(result);
								Modal.tip(msg, Modal.MsgType.ERROR);
							}
						}
					})
    				
    			},
    			
    			deleteNodeView:function(){
    				var app=this;
    				var currentNode=app.currentNode;
    				
    				var $formBlock=$('#form');
    				var data=currentNode.data;
    				
    				var html=template('form/delete',data);
    				$formBlock.html(html);
    				
    				$formBlock.find('form').ajaxSubmitify({
						onSuccess:function(result){
							if(Action.ifSucceed(result)){
								Modal.tip('操作成功！', Modal.MsgType.SUCCESS);
		    					app.$tree.jstree(true).delete_node(currentNode)
		    					delete app.currentNode;
		    					app.showNodeView();
							}else{
								var msg= Action.getResultMsg(result);
								Modal.tip(msg, Modal.MsgType.ERROR);
							}
						}
					})
    			},
    			
    			showNodeView:function(target){
    				var app=this;
    				var currentNode=app.currentNode;
    				if(target) currentNode=target;
    				
    				var $formBlock=$('#form');
    				if(!currentNode){
	    				var html=template('form/empty');
	    				$formBlock.html(html);
    					return;
    				}
    				
    				var data=currentNode.data;
    				data.parent=currentNode.parent;
    				var html=template('form/edit',data);
    				$formBlock.html(html);
    				
    				$formBlock.find('form').ajaxSubmitify({
						onSuccess:function(result){
							if(Action.ifSucceed(result)){
								Modal.tip('操作成功！', Modal.MsgType.SUCCESS);
								app.refreshNode({parent:true,oldParent:true})
							}else{
								var msg= Action.getResultMsg(result);
								Modal.tip(msg, Modal.MsgType.ERROR);
							}
						}
					})
    			},
    			
    			buildJSTreeData:function(data){
    				var app = this;
    				return {
    					id : data.id,
    					text : data.name,
    					data:data,
    					a_attr:{
    						title:data.name
    					},
    					type:data.level==app.MAX_LEVEL?'file':'default',
    					parent : data.superId,
    					children:data.level<app.MAX_LEVEL,
    					state:{
    						opened:data.level==1
    					}
    				}
    			},
    			
    			mockData1:function(parent){
    				var app=this;
    				
    				var level=1;
    				
    				if(parent && parent.data && parent.data.level<app.MAX_LEVEL) {
    					level=parent.data.level+1;
    				}
    				
    				var list=[] , i=0,itemLength=10;
    				if(level==1) itemLength=0;
    				while(i++<=itemLength){
    					list.push({
    						createTime: new Date(),
							id: 'id_'+ new String(Math.random()*10),
							intro: "intro"+i,
							level: level,
							name: "权限菜单"+parseInt(Math.random()*100),
							status: 1,
							superId: parent.id,
							url: Action.get('menu.list')
    					})
    				}
    				return list;
    			},
    			
    			initEvents:function(){
    				var app=this;
    				$('body').on('click','[action]',function(){
    					var $this=$(this);
    					var action=$this.attr('action');
    					if(action=='node.delete'){
    						app.deleteNodeView();
    					}
    					else if(action=='node.add'){
    						app.createNodeView();
    					}
    					else if(action=='node.show'){
    						app.showNodeView();
    					}
    					else if(action=='url.select'){
    						app.chooseContentItem().then(function(data){
    							$this.prev('input').val(data.uri)
    						})
    					}
    				})
    			},
    			
    			initForm:function(){
    				
    			},
    			
    			init : function(){
    				this.initTrees();
					this.initEvents();
					this.initForm();
    			}
    		}
    		App.init();
    	})
   </script>
</body>
</html>