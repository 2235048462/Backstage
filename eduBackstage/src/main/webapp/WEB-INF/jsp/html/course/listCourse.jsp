<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
		<jsp:include page="/WEB-INF/jsp/lib.jsp" />
课程编号:<input id="cuCode" >
课程名称:<input id="cuName" >
代课老师:<input id="cuTeacher">
<button id="btn" >查询</button>
<!-- 使用easgyUI datagrid组件表格 -->
<table id="dg"></table>

<div id="dlg">
	<form action="#" id="ff">
	    <font color="red"></font><br><br>
		 &nbsp;<input name="cuId" type="hidden"><br><br>&nbsp;&nbsp;
		 &nbsp;课程编号：<input name="cuCode" id="cuCodes"><br><br>&nbsp;&nbsp;
		 &nbsp;课程名称：<input name="cuName" id="cuNames"><br><br>&nbsp;&nbsp;
		 &nbsp;上课地点：<input name="cuPlace" id="cuPlaces"><br><br>&nbsp;&nbsp;
		 &nbsp;代课教师：<input name="cuTeacher" id="cuTeachers"><br><br>&nbsp;&nbsp;
		 &nbsp;开课时间:&nbsp;<input id="cuStartDates" name="cuStartDate" class="easyui-datebox" ></input><br><br>&nbsp;&nbsp;
		 &nbsp;课&nbsp;&nbsp;时：<input name="cuClassTime" id="cuClassTimes"><br><br>&nbsp;&nbsp;
	</form>
</div>
<script type="text/javascript">

//查询按钮绑定事件
	$("#btn").click(function(){
		//得到文件框输入值
		var cuCode=$("#cuCode").val();
		var cuName = $("#cuName").val();
		var cuTeacher=$("#cuTeacher").val();
		//带参数刷新表格
		$("#dg").datagrid({
			queryParams:{
				cuCode:cuCode,
				cuName:cuName,
				cuTeacher:cuTeacher
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
					//var id=$("#ids").val();
					var cuCode=$("#cuCodes").val();
					var cuName = $("#cuNames").val();
					var cuPlace = $("#cuPlaces").val();
					var cuTeacher=$("#cuTeachers").val(); 
					var cuStartDate=$("#cuStartDates").datebox("getValue")
					if(cuStartDate!=""&&cuStartDate){
						cuStartDate=cuStartDate+" 00:00:00"
					} 
					
					var cuClassTime =$("#cuClassTimes").val();
					
					var data=/* "id="+id+ */
					         "&cuCode="+cuCode+
					         "&cuName="+cuName+
					         "&cuPlace="+cuPlace+
					         "&cuTeacher="+cuTeacher+
					         "&cuStartDate="+cuStartDate+
					         "&cuClassTime="+cuClassTime; 
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
		    url:'courses/listcu.do',  
		    //一行数据
		    //{"cuId":1,"cuCode":"1002","cuName":"语文","cuStartDate":1577635200000,"cuClassTime":20,"cuPlace":"逸夫楼","cuTeacher":"苗泽"}
		    columns:[[    
		        {field:'cuId',title:'ID',width:100},    
		        {field:'cuCode',title:'课程编号',width:100}, 
		        {field:'cuName',title:'课程名称',width:100},
		        {field:'cuPlace',title:'上课地点',width:100},
		        {field:'cuTeacher',title:'代课教师',width:100},
		        {field:'cuStartDate',title:'开课时间',width:100,formatter:function(value){
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
		      {field:'cuClassTime',title:'课时',width:100},
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
							url="courses/addcl.do";						
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
							url="course/updatecu.do";
						}		
					}
			},'-',{
				text:"删除",	
				iconCls: 'icon-remove',
				handler: function(){
					//先拿到被选中的部门id [{id},{},{}]
					var id = $("#dg").datagrid("getSelections");
					if(id){
						//迭代循环那好每一个id
						//for(Dept dept : dpets)
						/* for(id in depts){
							console.log(depts[id])
						} */
						var ids = [] //定义空数组
						$(id).each(function(index){
								//console.log(this) //this每一个dept对象
								//this.id//每一个dept对象的id
								ids.push(this.cuId);//[1,2,3]
						})
						//ids.toLocaleString()//"1,2,3"
						//发请求
						$.ajax({
							url:"courses/deletecu.do",
							data:{ids:ids.toLocaleString()},success:function(data){
							alert(data.msg)
							 $("#dg").datagrid("reload");
						}})
						
					}
				}
			}],
			pagination:true,
			pagelist:[5,10]

		}); 
	})
</script>