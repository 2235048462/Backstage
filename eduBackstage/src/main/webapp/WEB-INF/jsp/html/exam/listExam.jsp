<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
		<jsp:include page="/WEB-INF/jsp/lib.jsp" />
班级名称：<input id="ecName" >
学科名称：<input id="euName" >
考试地点：<input id="ePlace" >
<button id="btn" >查询</button>
<!-- 使用easgyUI datagrid组件表格 -->
<table id="dg"></table>

<div id="dlg">
	<form action="#" id="ff">
		<input name="id" type="hidden"><br><br>&nbsp;&nbsp; 
		班级名称：<select id="ecName">
			<option value="">--请选择--</option>
		</select><br><br>&nbsp;&nbsp; 
		学科名称：<select id="euName">
			<option value="">--请选择--</option>
		</select><br><br> &nbsp;&nbsp;
		考试地点：<input name="ePlace"><br><br>&nbsp;&nbsp;
		考试时间:&nbsp;<input id="eTime" type="datetime" class="easyui-datebox" ></input><br><br>&nbsp;&nbsp;
		考试地点：<input id="ePlaces" name="ePlace"><br><br>&nbsp;&nbsp; 
		备&nbsp;&nbsp;注：<input id="eNates" name="eNate"><br><br> &nbsp;&nbsp;
		原&nbsp;&nbsp;由：<input id="eDescribes" name="eDescribe">&nbsp;&nbsp;
	</form>
</div>
<script type="text/javascript">

//查询按钮绑定事件
	$("#btn").click(function(){
		//得到文件框输入值
		var ecName = $("#ecName").val();
		var euName = $("#euName").val();
		var ePlace = $("#ePlace").val();
		//带参数刷新表格
		$("#dg").datagrid({
			queryParams:{
				ecName:ecName,
				euName:euName,
				ePlace:ePlace
				}
		})
	})
	

//页面加载完毕调用初始化
	$(function() {
		var url="";
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
					var data = ff.serialize();
					alert(data);
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
		    url:'exam/listcl.do',  
		    //一行数据
		    //{"ceId":1,"csName":"七年级一班","cuName":"语文","ceNum":30,"ceTime":994377600000,"cePlace":"教二 D306","ceDescribe":""}
		    columns:[[    
		        {field:'ceId',title:'ID',width:100},    
		        {field:'csName',title:'班级名称',width:100},
		        {field:'cuName',title:'学科名称',width:100}, 
		        {field:'ceNum',title:'考试人数',width:100}, 
		        {field:'ceTime',title:'考试时间',width:100,formatter:function(value){
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
		        {field:'cePlace',title:'考试地点',width:100}, 
		        {field:'eNate',title:'备注',width:100},
		        {field:'ceDescribe',title:'原由',width:100},
		    ]],
		    fitColumns:true,
		    toolbar: [{
				text:"新增",		    
				iconCls: 'icon-add',
				handler: function(){
						//打开窗口
						$("#dlg").dialog("open");
						//重置标题
						$("#dlg").dialog("setTitle","新增考试"); 	
						url="exam/addcl.do";						
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
							url="exam/updatecl.do";
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
								ids.push(this.ceId);//[1,2,3]
						})
						//ids.toLocaleString()//"1,2,3"
						//发请求
						$.ajax({
							url:"exam/deletecl.do",
							data:{ids:ids.toLocaleString()},
							success:function(data){
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