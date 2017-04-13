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
	<title>评价管理</title>
	<c:set var="appRoot" value="../../" />
	<c:import url="/public/head-tag.jsp"/>
	<style type="text/css">
		.menustyle{
			width: 100px;
		}
		.contentstyle{
			padding-left: 50px;
		}
		.a-padding{
			padding-left: 20px;
		}
		.itemlogo{
            width: 40px;
            height: 40px;
            padding-right: 10px;
        }
        .bigImage{
            width: 300px;
        }
        p img{
            cursor:pointer
        }
	</style>
</head>
<body>

    <c:import url="/public/header.jsp"/>
    
    <section class="container" id="app">
    
		<c:set var="sidebar" scope="request" value="comment"/>
		<c:set var="navbar" scope="request" value="sellComplain"/>
		<c:import url="/public/sidebar.jsp"/>
		
    	<div class="content">
    		<div class="content-top">
    			<h3 class="content-title">
    				<div class="bread">
    					<a href="/car-platform/business/appeal/listPage">商家申诉</a>
    					<span>&gt;</span>
    					<span>详情</span>
    				</div>
    			</h3>
    		</div>
    		<div class="content-main">
    			<div class="block block-main">
					<div v-if="!editing" class="block-content loading">
						loading...
					</div>
					<template v-else>
    				<div class="block-content" >
    					 <!--goback="data.jsp"-->
						<form method="post">
							<div class="form-block">
								
								<div class="form-row">
									<span class="row-label menustyle">申诉时间：</span>
									<div class="row-content contentstyle">
	                                 	<div class="row-value">
	                                 		<p v-text="formatDate(form.t)"></p>
	                                 	</div>
	                                 </div>
								</div>

								<div class="form-row">
									<span class="row-label menustyle">申诉单号：</span>
									<div class="row-content contentstyle">
										<div class="row-value">
										<p><span v-text="form.id"></span>
										</div>
									</div>
								</div>
								
								<div class="form-row">
									<span class="row-label menustyle">申诉状态：</span>
									<div class="row-content contentstyle">
	                                 	<div class="row-value">
	                                 		<template v-if="form.status==0">
		                                 		<p>待核实</p>
	                                 		</template>
	                                 		<template v-if="form.status==1">
		                                 		<p>已通过</p>
	                                 		</template>
	                                 		<template v-if="form.status==2">
		                                 		<p>已驳回</p>
	                                 		</template>
	                                 	</div>
	                                 </div>
								</div>
								
								<div class="form-row">
									<span class="row-label  menustyle">提交商家：</span>
									<div class="row-content contentstyle">
										<div class="row-value">
	                                 		<td><span v-text="form.bname"></span></td>
	                                 		<td><a href="/car-platform/business/info/editPage?id={{form.bid}}" class="action-link a-padding" >查看详情</a></td>
	                                 	</div>
									</div>
								</div>


								 <div class="form-row">
                                 <p class="row-label">关联订单：</p>
                                 <div class="row-content contentstyle">
									
 		                            <div class="row-value">
										<p>
			                                <span>订单号码:</span>
			                                <span v-text="form.orderId"></span>
		                                </p>
                                        
                                        <table class="table table-middle">
                                            <thead>
                                            <tr>
                                                <th style="width: 13%">综合评分</th>
                                                <th style="width: 30%" class="align-left">用户评价</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                                <template v-if="length">
                                                    <tr v-for="item in order">
                                                        <td class="align-left" >
                                                           <span v-text="item.score"></span>分
                                                        </td>
                                                        <td class="align-left">
                                                            <p v-text="item.bvdesc"></p>
                                                            <p >
                                                                <template v-if="item.images">
	                                                                <template v-for="item1 in convertImage(item.images)">
	                                                                    <img :src='showSmallImage(item1)' class="itemlogo" @click="showImage(item1)" />
	                                                                </template>	
                                                                </template>
                                                                
                                                            </p>
                                                        </td>
                                                    </tr>
                                                </template>
                                                    
                                            </tbody>
                                        </table>
                                        
										<p v-if="form.orderId"><a href="/car-platform/order/washcar/detailPage?orderId={{form.orderId}}" class="action-link ">查看订单</a></p>
                                 	</div>
                             	</div>
                             </div>

								<div class="form-row">
									<span class="row-label menustyle">申诉原因：</span>
									<div class="row-content contentstyle">
										<div class="row-value">
											<p v-text="form.appealDesc"></p>
										</div>
									</div>
								</div>
								<div class="form-row">
									<span class="row-label menustyle">处理结果：</span>
									<div class="row-content contentstyle">
										<div class="row-value">
											<p v-text="form.prosdesc"></p>
										</div>
									</div>
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
            'moment',
            
            'utils.search',
            'vender.modal', 
            'vender.types', 
            'vender.actions', 
             
            'jquery.common'
        ],
        function(Vue, moment,  Search,  Modal, Field,  Action){
        	
        	var search = new Search().getParams();
            var isEdit = !!search.id;
            
            Action.extend({
                'form.detail' : '/car-platform/business/appeal/detail?id={id}',
                'order.detail': '/car-platform/user/comment/byorderid/list?orderId={orderId}'
            })
            
   			var App={
   					
    			alert : function(){
    				alert(arguments[0]);
    			},
    			cg:function(i,tmp){
    				console.log(i,"--->",JSON.stringify(tmp));
    			},

				getAppData :function(){
                    
                    var dtd = $.Deferred();
                    
                    var defaultData ={
                    }
                    if(!isEdit){
                         return dtd.resolve(defaultData);
                    }else{
	                    var url = Action.get('form.detail', search);
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
    			initForm:function(formData,orderData){
    				//test
    				var TEST=false;
    				var newArr;
    				if(TEST){
    					var images="Fls8rTqcQN76P-7b-Dirjb9MCUt_,Ftf-nUV5_lmbOSuU6wF2Yv-XK2eF";
                        
                        var newArr=orderData.map(function(item,index){
                            item.images=images;
                            return item;
                        })
    				}else{
    					newArr=orderData;
    				}
    				
    				new Vue({
    					el:'#app',
    					data:function(){
    						return {
								editing:true,
								form:formData,
								order:newArr,
								length:newArr.length
							}
    					},
						computed:{
							'isEdit':function(){
    							return isEdit;
    						},
							relate:function(){
								return this.form.relateOrder;
							}
							
						},
    					methods:{
    						createDefaultArea:function(area){
                                if(!area) return [];
                                return JSON.stringify(area)
                            },
                            convertImage:function(imageStr){
                                return imageStr.split(',');
                            },
                            formatDate :function(t){
                            	if(!t){
                            		return "-"
                            	}else{
									return moment(Number(t)).format('YYYY-MM-DD MM:HH:ss');
                            	}
    						},
    						showSmallImage:function(item){
                                return Action.get('image.small', item)
                            },
                            showImage:function(str){
                                var item=Action.get('image.medium', str);
                                App.playImage(item);
                            }
    					}
    					
    					
    				})

    			},
    			
    			playImage :function(image){
                    require(['vender/player/photo'], function(PhotoPlayer){
                        PhotoPlayer.play(image);
                    })
                },
                
    		   getOrder :function(order){
                    var dtd = $.Deferred();
                    var url = Action.get('order.detail', order);
                    $.getJSON(url, function(result){
                        var code = result.code;
                        dtd.resolve(result.data)
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
    			
    			init:function(){
    				var app = this;
    				
    				this.getAppData()
    				.then(function(data){
    				    app.getOrder(data).then(function(scoreData){
    				    	app.initForm(data,scoreData);	
    				    })
    					
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