<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
		<jsp:include page="/WEB-INF/jsp/lib.jsp" />
部门名称<input id="deptName" >
<button id="btn" >查询</button>
<!-- 使用easgyUI datagrid组件表格 -->
<table id="dg"></table>

<div id="dlg">
	<form action="#" id="ff">
		<input name="id" type="hidden">
		名称<input name="deptName"><br>
		备注<input name="commont">
	</form>
</div>
<script type="text/javascript">

//查询按钮绑定事件
	$("#btn").click(function(){
		//得到文件框输入值
		var deptName = $("#deptName").val()
		//带参数刷新表格
		$("#dg").datagrid({
			queryParams:{deptName:deptName}
		})
	})
	

//页面加载完毕调用初始化
	$(function() {
		var url=""
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
		    url:'dept/list.do',  
		    //一行数据
		    //{"id":1,"deptName":"人力资源部","updateTime":null,"createTime":null,"commont":null
		    columns:[[    
		        {field:'id',title:'ID',width:100},    
		        {field:'deptName',title:'部门名称',width:100},    
		        {field:'updateTime',title:'修改时间',width:100,formatter:function(value){
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
		        {field:'createTime',title:'创建时间',width:100,formatter:function(value){
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
		        {field:'commont',title:'备注',width:100},
		    ]],
		    fitColumns:true,
		    toolbar: [{
				text:"新增",		    
				iconCls: 'icon-add',
				handler: function(){
						//打开窗口
						$("#dlg").dialog("open");
						//重置标题
						$("#dlg").dialog("setTitle","新增部门");	
						url="dept/add.do";						
				}
			},'-',{
				text:"编辑",		    
				iconCls: 'icon-edit',
				handler: function(){
					//打开对话框、
					$("#dlg").dialog("open");
					//修改对话框标题
					$("#dlg").dialog("setTitle","编辑部门");
					//回显数据
						//获取选中的第一个数据
						var depts = $("#dg").datagrid("getSelected");
						if(depts){
							$("#ff").form("load",depts)
						//提交表单 点击保存按钮
							url="dept/update.do";
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
								ids.push(this.id);//[1,2,3]
						})
						//ids.toLocaleString()//"1,2,3"
						//发请求
						$.ajax({url:"dept/delete.do",data:{ids:ids.toLocaleString()},success:function(data){
							  alert(data.msg);
							 $("#dg").datagrid("reload");
						}})
						
					}
				}
			}],
			pagination:true

		}); 
	})
</script>