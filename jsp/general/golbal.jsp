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
	<title>统计总览-运营概况</title>
	<c:set var="appRoot" value="../../" />
     <c:import url="${appRoot}/public/head-tag.jsp"/>
    <style>
.overview {
    overflow: hidden;
    padding: 10px 0;
    border-bottom: 1px solid #E8E8E8;
}
.overview-item {
    float: left;
    width: 25%;
    text-align: center;
    font-size: 13px;
}

.overview-item dt {
    font-size: 14px;
}

.overview-item dd {
    margin: 5px 0;
}
    </style>
</head>
<body>
	
    <c:import url="${appRoot}/public/header.jsp"/>
    <section class="container">
		<c:set var="sidebar" scope="request" value="statistic"/>
		    <c:set var="navbar" scope="request" value="StatisticAll"/>
		    <c:import url="${appRoot}/public/sidebar.jsp"/>
    	<div class="content">
    		<div class="content-top">
    			<h3 class="content-title">运营概况</h3>
    		</div>
    		<div class="content-main">
				<section class="content-item" data-template="item/list" id="box">
					<div class="overview">
						<dl class="overview-item">
							<dt>门店总数</dt>
							<!--<dd>今日：${RegistToday}</dd>
							<dd>昨日：${RegistYesterday}</dd>
							<dd>本周：${RegistWeak}</dd>-->
						</dl>
						<dl class="overview-item">
							<dt>交易额</dt>
							<dd>昨日：123</dd>
							<dd>近日：123</dd>
							<dd>本周：123</dd>
						</dl>
						<dl class="overview-item">
							<dt>交易量</dt>
							<dd>今日：${ChatToday}</dd>
							<dd>昨日：${ChatYesterday }</dd>
							<dd>本周：${ChatWeak }</dd>
						</dl>
						<dl class="overview-item">
							<dt>会员充值</dt>
							<dd>今日：${roadToday}</dd>
							<dd>昨日：${roadYesterday}</dd>
							<dd>本周：${roadWeak}</dd>
						</dl>
					</div>
					<div class="content-item-top" style="padding-left:40px;padding-right:40px;">
						<form action="${basePath}/web/statistic/ListQueryPage" method="get" autocomplete="off">
							<select class="select fn-hide" id="indexNames" data-listify="true">
								<option value="registercount">交易额</option>
								<option value="onlinecount">交易量</option>
								<option value="interactcount">会员充值</option>
								<!--<option value="trafficcount">路况信息量3</option>-->
							</select>
							<div class="filter-item">
								<select activity-select name="type"  class="select"  ipattern="^\d+$" iname="节目类别">
											 <option value="PPPPPP">门店筛选</option>
											<c:forEach items="${selectList}" var="option">
									           <option value="${option.pid}">${option.realName}</option>
                                             </c:forEach>
										</select>			
							</div>
							<div class="filter-item">
								<label for="">时间</label>
								<input type="text" class="text text-100" placeholder="开始时间" name="sdate" date-range/>
								<span>至</span>
								<input type="text" class="text text-100" placeholder="结束时间"  name="edate" date-range  />
							</div>

							<div class="filter-item">
								<label></label>
								<input type="hidden" name="page" value="1"/>
								<a data-href="${basePath}/web/statistic/excelExport?" target="_blank"  data-export="true"  class="btn btn-default btn-medium">导出数据</a>
							</div>
						</form>
					</div>
					
					<div class="content-item-block">
							<div class="chart-box" id="charts" style="height:350px;">
								
							</div>
							<table class="table align-center">
								<thead>
								<tr>
									<th style="width:20%">日期</th>
									<th style="width:15%">发起交易</th>
									<th style="width:15%">成功交易</th>
									<th style="width:15%">交易额</th>
									<th style="width:20%">总交易量</th>
									<th style="width:15%">会员充值</th>
								</tr>
								</thead>
								<tbody id="sortable">
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
    
   <script type="text/template"  id="item/list" note="统计列表">
		{{if !list || list.length==0}}
		<tr><td colspan="5">没有记录！</td></tr>
		{{else}}
			{{each list as item}}
				<tr>
					<td>{{item.datadate}}</td>
					<td>{{item.registercount}}</td>
					<td>{{item.onlinecount}}</td>
					<td>{{item.interactcount}}</td>
					<td>{{item.trafficcount}}</td>
				</tr>
			{{/each}}
		{{/if}}
    </script>
    
   <script src="/pages/assets/js/require.all.js?v=4293636e2ff5c4a96b189a7661023e42"></script>
   <script>
        requirejs([
            'artTemplate', 
            'echarts2',
            'jquery.daterangepicker', 
            'jquery.common',
            'jquery.pager'
        ], function(template, echarts){
   			
    		var App={
    			alert : function(){
    				alert(arguments[0]);
    			},
    			initPlugins:function(){
    				
    				(function($){
    					$.extend($.fn,{
    						listifySelect:function(options){
    							
    							var settings=$.extend({
    								containerClass:'listify-select',
    								activeClass:'listify-select-active',
    								onChange:$.noop
    							},options)
    							
    							return this.each(function(){
    								var $select=$(this);
    								var $ul=$('<ul>').addClass(settings.containerClass);
    								var $options=$select.children();
    								$options.each(function(i){
    									var $self=$(this);
    									var value=$self.attr("value");
    									var text=$self.text().replace(/\s/g,"");
    									var $item=$('<li>').append($('<a>').text(text).attr('href','#').data('value',value))
    									if($self.is(":selected")) $item.addClass(settings.activeClass);
    									$ul.append($item);
    								})
    								
    								$select.hide();
    								$ul.insertBefore($select);
    								
    								$ul.on("click","a",function(e){
    									e.preventDefault();
    									var $target=$(this);
    									var value=$target.data("value");
    									$ul.find("."+settings.activeClass).removeClass(settings.activeClass);
    									$target.parent().addClass(settings.activeClass);
    									$select.val(value).trigger("change");
    									settings.onChange.call($select);
    								})
    							})
    						}
    					})
    				}(jQuery))
    				
    			},
    			initCharts:function(callback){
    						echarts = echarts || window.echarts;
				            //--- 折柱 ---
				            var chart = echarts.init(document.getElementById('charts'));
				            var options={
				                tooltip : {
				                    trigger: 'axis',
							        formatter:function(params){
							        	var str=params[0].name;
							        	str+="<br/>";
							        	for(var i in params){
							        		var param=params[i];
							        		str+=param.seriesName+"："+param.data+"<br/>";
							        	}
							        	return str;
							        },
							        axisPointer:{
									    type: 'line',
									    lineStyle: {
									        width: 1,
									        type: 'dashed'
									    }
									}      
				                },
							    legend: {
							    	show:false,
							        data:['data']
							    },
							    grid:{
							    	x:40,x2:40,y:5
							    },
							    toolbox: {
							        show : false,
							        feature : {
							            mark : {show: true},
							            dataView : {show: true, readOnly: false},
							            magicType : {show: true, type: ['line', 'bar']},
							            restore : {show: true},
							            saveAsImage : {show: true}
							        }
							    },
							    calculable : false,
							    xAxis : [
							        {
							            type : 'category',
							            axisLine:{lineStyle:{width:1,color:'#F5F5F5'}},
							            axisTick:{lineStyle:{width:1,color:'#F5F5F5'}},
							            splitLine:{lineStyle:{width:1,color:'#E8E8E8'}},
							            axisLabel:{
							            	formatter:function(v){
							            		return v;
							            		return new Date(v).format("yyyy-MM-dd")
							            	}
							            },
							            boundaryGap : false,
							            data : [0]
							        }
							    ],
							    yAxis : [
							        {
							            type : 'value',
							            splitLine:{lineStyle:{width:1,color:'#E8E8E8'}},
							            axisLine:{lineStyle:{width:1,color:'#F5F5F5'}}
							        }
							    ],
							    series : [{type:'bar',data:[0]}]
							};
				            chart.setOption(options);
				            App.chart=chart;
				            if(typeof callback=="function") callback.call(this);
    			},
    			
    			// 渲染 图表
    			renderChart:function(data){
    				
    				// 有数据时，用传入的数据，没有数据时用缓存的数据
    				if(!data) data=App._chartData;
    				App._chartData=data;
    				
    				var chart=App.chart;
    				var options=chart.getOption();
    				
    				var $nameSelect=$("#indexNames");
    				var theNameKey=$nameSelect.val();
    				var theName=$nameSelect.find("option:selected").text().replace(/\s/g,"");
    				
    				var dateName='datadate';
    				var obj=App.extractData([theNameKey,dateName],data)
    				
    				options.xAxis[0].data=obj[dateName].reverse();
    				options.series[0]=App.buildSeriesData(theName,obj[theNameKey].reverse());
    				
    				chart.setOption(options,true);
    			},
    			//构造echart series数据
    			buildSeriesData:function(name,data){
    				return {
			            name:name,
			            type:'line',
			            data:data,
			            smooth:true,
			            symbol:"none",
			            itemStyle:{normal:{borderWidth:1,lineStyle:{width:2},label:{show:false}}}
			           /* markPoint : {
			            	symbolSize:1,
			                data : [
			                    {type : 'max', name: '最高'},
			                    {type : 'min', name: '最低'}
			                ]
			            }*/
			        }
    			},
    			// 根据key提取数据
    			extractData:function(key,array){
    				var result={};
    				if(!(key instanceof Array)) key=[key];
    				key.forEach(function(theKey){
    					var list=result[theKey]=[];
    					$.each(array,function(i,v){
    						list.push(v[theKey])
    					})
    				})
    				return result;
    			},
    			
    			//生成测试数据
    			testCreateData:function(){
    				var list=[];
    				var days=Math.floor(Math.random()*30+5);
    				
    				var now=new Date().getTime();
    				var oneDay=1000*60*60*24;
    				
    				while(days-->0){
    					list.push({
    						date:now-oneDay*days,
    						reg:parseInt(Math.random()*1000),
    						realtime:parseInt(Math.random()*1000),
    						interaction:parseInt(Math.random()*1000),
    						road:parseInt(Math.random()*1000)
    					})
    				}
    				
    				return {
    					code:200,
    					msg:"",
    					data:{
    						list:list,
	    					paging:{total:60,currentPage:2,pageSize:10}
    					}
    				};
    			},
    			initDatePicker:function(){
    				var $dates=$("[date-range]").dateRangePicker({
						separator : '至',
						getValue: function(){
							return '';
						},
						setValue: function(s,s1,s2){
							return false;
						}
					})
					.on("datepicker-apply",function(e,date){
						$dates.eq(0).val(date.date1.format('yyyy-MM-dd'));
						$dates.eq(1).val(date.date2.format('yyyy-MM-dd'));
						$(this).parents("form:first").submit()
					})
    			},
    			initEvents:function(){
					$("body").on("click","[action]:not(form)",function(){
						var $this=$(this);
						var action=$this.attr("action");
						var data=$this.data("params");
						return false;
					})
					
					// 统计指标改变时，重新渲染图表
					$("#indexNames").on("change",function(){
						App.renderChart();
					})
					$('select[data-listify]').listifySelect();
    			},
    			init : function(){
					this.initPlugins();
					this.initDatePicker();
					this.initEvents();
					this.initCharts(function(){
						$("[data-template]").ajaxLoad({
							beforeSubmit:function(){
								var $form=$(this).find('form');
								var $export=$form.find('[data-export=true]');
								$export.attr('href',$export.data('href')+$form.serialize())
							},
							onSuccess:function(result){
								if(result.data.listall&&result.data.listall.length>0)
									App.renderChart(result.data.listall);
								//App.renderChart(result.data.list);
							}
						});
					});
    			}
    		}
    		App.init();
   		})
   </script>
    </body>
</html>