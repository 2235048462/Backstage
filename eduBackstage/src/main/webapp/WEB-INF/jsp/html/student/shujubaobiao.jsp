<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/jsp/lib.jsp" />
<!-- 使用easgyUI datagrid组件表格 -->
<center>
<h3>已毕业学生报表</h3>
<table id="yby"></table>
<h3>未毕业学生报表</h3>
<table id="wby"></table>
<h3>升学学生报表</h3>
<table id="sx"></table>
<h3>留学学生报表</h3>
<table id="lx"></table>
<h3>学业正常学生报表</h3>
<table id="zc"></table>
<h3>学业异常学生报表</h3>
<table id="yc"></table>
</center>
<script type="text/javascript">
//页面加载完毕调用初始化
	$(function() {
	   
		//初始化表格
		$('#yby').datagrid({    
			/* Width:500,
			height:100, */
		    url:'student/listyby.do',  
		    //一行数据
		    //{""s_nate":"升学","s_scores":"合格","ID":1,"stuName":"张三"}
		    columns:[[    
		        {field:'ID',title:'ID',width:100},    
		        {field:'stuName',title:'姓名',width:100},     
		        {field:'ZHUANGTAI',title:'状态',width:100}, 
		    ]],
		    fitColumns:true,
			pagination:true
		}); 
		
		$('#wby').datagrid({    
			//Width:2000,
		    url:'student/listwby.do',  
		    //一行数据
		    //{""s_nate":"升学","s_scores":"合格","ID":1,"stuName":"张三"}
		    columns:[[    
		        {field:'ID',title:'ID',width:100},    
		        {field:'stuName',title:'姓名',width:100},     
		        {field:'ZHUANGTAI',title:'状态',width:100}, 
		    ]],
		    fitColumns:true,
			pagination:true
		}); 
		
		$('#sx').datagrid({  
			//Width:2000,
		    url:'student/listsx.do',  
		    //一行数据
		    //{""s_nate":"升学","s_scores":"合格","ID":1,"stuName":"张三"}
		    columns:[[    
		        {field:'ID',title:'ID',width:100},    
		        {field:'stuName',title:'姓名',width:100},     
		        {field:'s_nate',title:'升/留学',width:100},
		        {field:'s_scores',title:'备注',width:100}, 
		    ]],
		    fitColumns:true,
			pagination:true
		}); 
		
		$('#lx').datagrid({ 
			//Width:2000,
		    url:'student/listlx.do',  
		    //一行数据
		    //{""s_nate":"升学","s_scores":"合格","ID":1,"stuName":"张三"}
		    columns:[[    
		        {field:'ID',title:'ID',width:100},    
		        {field:'stuName',title:'姓名',width:100},     
		        {field:'s_nate',title:'升/留学',width:100},
		        {field:'s_scores',title:'备注',width:100}, 
		    ]],
		    fitColumns:true,
			pagination:true
		}); 
		
		$('#zc').datagrid({   
			//Width:2000,
		    url:'student/listzc.do',  
		    //一行数据
		    //{""s_nate":"升学","s_scores":"合格","ID":1,"stuName":"张三"}
		    columns:[[    
		        {field:'ID',title:'ID',width:100},    
		        {field:'stuName',title:'姓名',width:100},     
		        {field:'LIUSHI',title:'正常/流失',width:100},
		    ]],
		    fitColumns:true,
			pagination:true
		}); 
		
		$('#yc').datagrid({   
			//Width:2000,
		    url:'student/listyc.do',  
		    //一行数据
		    //{""s_nate":"升学","s_scores":"合格","ID":1,"stuName":"张三"}
		    columns:[[    
		        {field:'ID',title:'ID',width:100},    
		        {field:'stuName',title:'姓名',width:100},     
		        {field:'LIUSHI',title:'正常/流失',width:100},
		    ]],
		    fitColumns:true,
			pagination:true
		}); 
	})
</script>