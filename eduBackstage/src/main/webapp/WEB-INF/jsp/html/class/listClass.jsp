<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/jsp/lib.jsp" />
班级编号：<input id="csCode" >
班级名称：<input id="csName" >
<button id="btn" >查询</button>
<!-- 使用easgyUI datagrid组件表格 -->
<table id="dg"></table>
<!-- 学生列表 -->
<div id="tbl">
 <table id="stutbl"></table>
</div>
<!-- 学生信息列表 -->
<div id="tbe">
 <table id="stumess"></table>
</div>
<!-- 课程名称列表 -->
<div id="tab">
 <table id="table"></table>
</div> 
<!-- 搜索查询 -->
<div id="dlg">
	<form action="#" id="ff" method="get">
		 &nbsp;<input name="csId" type="hidden"><br><br>&nbsp;&nbsp;
		 &nbsp;班级编号：<input name="csCode"><br><br>&nbsp;&nbsp;
		 &nbsp;班级名称：<input name="csName"><br><br>&nbsp;&nbsp;
		 &nbsp;班级简介：<input name="csIntroduce"><br><br>&nbsp;&nbsp;
		 &nbsp;班级人数：<input name="csNum"><br><br>&nbsp;&nbsp;
		 &nbsp;备&nbsp;&nbsp;注：<input name="csDescribe">&nbsp;&nbsp;
	</form>
</div> 
<script type="text/javascript"> 
//课程函数
function go(csid){
	$("#tab").dialog("open");
	  //发送ajax
	  //初始化表格
			$('#table').datagrid({ 
				url:"classes/selectcl.do?csId="+csid,
				//一行数据00
			    //{"cu_name":"英语","cu_class_time":"30","cu_code":1001,"cu_teacher":"苗泽","cu_place":"教一 D308"}
			    columns:[[    
	                {field:'cu_code',title:'课程编号',width:100}, 
			        {field:'cu_name',title:'课程名称',width:100}, 
			        {field:'cu_place',title:'上课地点',width:100},
			        {field:'cu_teacher',title:'代课教师',width:100},
			        {field:'cu_class_time',title:'课时',width:100}
			    ]],
			    fitColumns:true,
              }); 
			//刷新表格
			$("#table").datagrid("reload");
	       
	  }  
//学生函数 
function goStu(){  
	$("#tbl").dialog("open"); 
	  //发送ajax
	  //初始化表格
			$('#stutbl').datagrid({   
				url:"classes/selectuser.do",
			    //一行数据00
			    //{"stuId":1,"cs_num":20,"cs_name":"djshfd","cs_code":1001,"stuName":"李四","cs_id":1}
			    columns:[[
			        {field:'cs_code',title:'班级编号',width:100},
			        {field:'cs_name',title:'班级名称',width:100},    
	                {field:'stuName',title:'学生名称',width:100},   
			        {field:'cs_num',title:'班级人数',width:100}, 
			        {field:'stuView',title:'学生信息查看',width:100,formatter:function(value,row,index){
			        	  return "<a href='javascript:goStuMess("+row.stuId+");'><img src='../../images/button/modify.gif'></a>";
			           }},  
			    ]],
			    fitColumns:true,
            }); 
			//刷新表格
			$("#stutbl").datagrid("reload");
		
	   
	  }
//学生信息函数 
function goStuMess(stuid){ 
	   $("#tbe").dialog("open");
	  //发送ajax
	  //初始化表格
			$('#stumess').datagrid({ 
				url:"user/selectuser.do?stuId="+stuid,
			    //一行数据00
			    //{"cu_name":"英语","cu_class_time":"30","cu_code":1001,"cu_teacher":"苗泽","cu_place":"教一 D308"}
			    columns:[[    
	                {field:'cu_code',title:'课程编号',width:100}, 
			        {field:'cu_name',title:'课程名称',width:100}, 
			        {field:'cu_place',title:'上课地点',width:100},
			        {field:'cu_teacher',title:'代课教师',width:100},
			        {field:'cu_class_time',title:'课时',width:100}
			    ]],
			    fitColumns:true,
            }); 
			//刷新表格
			$("#stumess").datagrid("reload"); 
	  }
    //查询按钮绑定事件
	$("#btn").click(function(){
		var csCode=$("#csCode").val();
		//得到文件框输入值
		var csName = $("#csName").val();
		//带参数刷新表格
		$("#dg").datagrid({
			queryParams:{
				csCode:csCode,
		        csName:csName
			}
		})
	})
    //页面加载完毕调用初始化
	$(function(){
		var url="";
		    //课程名称列表 
			//初始化对话框
			$("#tab").dialog({
				width:500,
				height:300,
			    closed: true,    
			    modal: true,   //遮罩 
		        title: "开设课程信息"  
		        
			})
		    
			//学生信息列表
			//初始化对话框
			$("#tbe").dialog({
				width:700,
				height:400,
			    closed: true,    
			    modal: true,   //遮罩 
		        title: "班级学生信息" 
		        
			})
			
			//学生列表
			//初始化对话框
			$("#tbl").dialog({
				width:300,
				height:200,
			    closed: true,    
			    modal: true,   //遮罩 
		        title: "班级学生"    
			})
			
		//初始化对话框
		$("#dlg").dialog({
		    closed: true,    
		    modal: true,   //遮罩
		    buttons:[{
				text:"保存",
				iconCls:"icon-save",
				handler:function(){
					//获取表单的数据
					var ff = $("#ff").form();
					var data = ff.serialize()
					//发送ajax
					$.ajax({
						url:url,
						data:data,
						success:function(data){
							//刷新表格
							$("#dg").datagrid("reload");
							//关闭窗口
							$("#dlg").dialog("close");
							$("#ff").form("clear")
						}
						})
				}
		    },{
				text:"取消",
				iconCls:"icon-cancel",
				handler:function(){
					//关闭窗口
					$("#dlg").dialog("close");
				}
		    }]
		})
		
		//初始化表格
		$('#dg').datagrid({    
		    url:'classes/listcl.do',  
		    //一行数据
		    //{row；{"csId":1,"csCode":1001,"csName":"javaEE班","csIntroduce":"dgfghjsgfudyvbjd","csNum":20,"csView":null,"ccView":null,"csCreateTime":1525536000000,"csUpdateTime":1567267200000,"csDescribe":""}
		    columns:[[    
		        {field:'csId',title:'ID',width:100},    
		        {field:'csCode',title:'班级编号',width:100}, 
		        {field:'csName',title:'班级名称',width:100},
		        {field:'csIntroduce',title:'班级简介',width:100},
		        {field:'csNum',title:'班级人数',width:100},
		        {field:'csview',title:'班级学生',width:100,formatter:function(){
		        	  return "<a href='javascript:goStu();'><img src='../../images/button/modify.gif'></a>";
		           }},
		        {field:'ccview',title:'班级课程',width:100,formatter:function(value,row,index){
		        	  return "<a href='javascript:go("+row.csId+");'><img src='../../images/button/modify.gif'></a>"; 
                  } },
		        {field:'csUpdateTime',title:'修改时间',width:100,formatter:function(value){
		        	if(value){
		        		//时间戳转化为date类型
			        	var date = new Date(value)
			        	//小时
			        	var hours =date.getHours() //getHours()
			        	//分钟
			        	var min = date.getMinutes();
			        	//秒
			        	var sec = date.getSeconds(); 
			        	
			        	//获取年
			        	var year = date.getFullYear()
			        	//获取月份
			        	var month = date.getMonth()+1
			        	//日期
			        	var date = date.getDate()

			        	
			        	return year+"-"+month+"-"+date+" "+hours+":"+min+":"+sec;
		        	}
		        }},
		        {field:'csCreateTime',title:'创建时间',width:100,formatter:function(value){
		        	if(value){
		        		//时间戳转化为date类型
			        	var date = new Date(value)
		        		
		        		//js分毫可以写也可以不写
		        		//代码不压缩就可以不写
			          	var hours =date.getHours() //getHours()
			        	//分钟
			        	var min = date.getMinutes();
			        	//秒
			        	var sec = date.getSeconds(); 
			        	
			        	//获取年
			        	var year = date.getFullYear()
			        	//获取月份
			        	var month = date.getMonth()+1
			        	//日期
			        	var date = date.getDate()
			      
			        	
			        	return year+"-"+month+"-"+date+" "+hours+":"+min+":"+sec;
		        	}
		        }},
		        {field:'csDescribe',title:'备注',width:100},
		    ]],
		    fitColumns:true, 
		    toolbar: [{
				text:"新增",		    
				iconCls: 'icon-add',
				handler: function(){
						//打开窗口
						$("#dlg").dialog("open");
						//重置标题
						$("#dlg").dialog("setTitle","新增班级");	
						url="classes/addcl.do";	 					
				}
			},'-',{
				text:"编辑",		    
				iconCls: 'icon-edit',
				handler: function(){
					//打开对话框、
					$("#dlg").dialog("open");
					//修改对话框标题
					$("#dlg").dialog("setTitle","编辑班级");
					    //回显数据
						//获取选中的第一个数据
						var depts = $("#dg").datagrid("getSelected");
						if(depts){
							$("#ff").form("load",depts) 
						    //提交表单 点击保存按钮
							url="classes/updatecl.do";
						}		
					}
			},'-',{
				text:"删除",	
				iconCls: 'icon-remove',
				handler: function(){
					//先拿到被选中的部门id [{id},{},{}]
					var depts = $("#dg").datagrid("getSelections");
					if(depts){
						//迭代循环那好每一个id
						//for(Dept dept : dpets)
						/* for(id in depts){
							console.log(depts[id])
						} */
						var ids = [] //定义空数组
						$(depts).each(function(index){
								//console.log(this) //this每一个dept对象
								//this.id//每一个dept对象的id
								ids.push(this.csId);//[1,2,3]
						})
						//ids.toLocaleString()//"1,2,3"
						//发请求
						$.ajax({url:"classes/deletecl.do",data:{ids:ids.toLocaleString()},success:function(data){
							alert(data.msg)
							 $("#dg").datagrid("reload");
						}})
						
					}
				}
			}],
			pagination:true 

		});
  })
</script>