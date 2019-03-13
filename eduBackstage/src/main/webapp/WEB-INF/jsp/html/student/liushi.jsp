<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/jsp/lib.jsp" />
<!-- 使用easgyUI datagrid组件表格 -->
学生姓名:<input type="text" name="name" id="name">
<button id="btn">查询</button>
<table id="dg"></table>
<script type="text/javascript">
//页面加载完毕调用初始化
	$(function() {
		
		$("#btn").click(function(){
			var name = $("#name").val() 
			//带参数刷新表格
			//带参数刷新表格
			$("#dg").datagrid({
				queryParams:{
					name:name,
					}
			})
			
			
		})
		
		//初始化表格
		$('#dg').datagrid({    
		    url:'student/listls.do',  
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