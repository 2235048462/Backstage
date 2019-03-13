<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
		<jsp:include page="/WEB-INF/jsp/lib.jsp" /> 
课程成绩：<input id="sCourseScores" >
考核成绩：<input id="sScores" >
<button id="btn" >查询</button>
<!-- 使用easgyUI datagrid组件表格 -->
<table id="dg"></table>

<div id="dlg">
	<form action="#" id="ff">
		<font color="red"></font><br><br>
	  &nbsp;&nbsp;<input name="sId" type="hidden"><br><br>
	  &nbsp;&nbsp;课程&nbsp;名称：<select id="sName" >
		    <option value="">--请选择--</option>
	     </select><br><br> 
	   &nbsp;&nbsp;学生&nbsp;姓名：<select id="stName" >
		    <option value="">--请选择--</option>
	     </select><br><br>
       &nbsp;&nbsp;学生&nbsp;班级：<select id="sClassName" >
		    <option value="">--请选择--</option>
	      </select><br><br>
       &nbsp;&nbsp;课程&nbsp;成绩:<input name="sPractice" id="sPractices"><br><br>&nbsp;&nbsp; 
       &nbsp;&nbsp; 实践课成绩：<input name="sCourseScores" id="sCourseScoress"><br><br>&nbsp;&nbsp; 
	      考试&nbsp;成绩：<input name="sScores" id="sScoress"><br><br>&nbsp;&nbsp;
	      备&nbsp;&nbsp;&nbsp;注：<input name="commont" id="commonts">&nbsp;&nbsp;
	</form>
</div>
<script type="text/javascript">

//查询按钮绑定事件
	$("#btn").click(function(){
		//得到文件框输入值 
		var sCourseScores = $("#sCourseScores").val() 
		var sScores = $("#sScores").val()
		//带参数刷新表格
		$("#dg").datagrid({
			queryParams:{  
				sCourseScores:sCourseScores,
				sScores:sScores,
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
							$("#ff").form("clear");
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
		    url:'socres/listsl.do',  
		    //一行数据
		    //{"cssId":1,"cssClassName":"七年级","cssStuName":"张三","cssName":"语文 数学 英语","cssCourseScores":"70 60 80","cssPractice":60,"cssScores":"合格","cssNate":""}
		    columns:[[    
		        {field:'cssId',title:'ID',width:100},    
		        {field:'cssStuName',title:'学生姓名',width:100}, 
		        {field:'cssClassName',title:'学生班级',width:100},
		        {field:'cssName',title:'课程名称',width:100},  
		        {field:'cssCourseScores',title:'课程成绩',width:100},
		        {field:'cssPractice',title:'实践课成绩',width:100},
		        {field:'cssScores',title:'考试成绩',width:100},
		        {field:'cssNate',title:'备注',width:100},
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
						//重置课程名称选择框
						$("#sName").html("<option value=''>--请选择--</option>");
						//重置学生姓名选择框
						$("#stName").html("<option value=''>--请选择--</option>");
						//重置学生班级选择框
						$("#sClassName").html("<option value=''>--请选择--</option>");
						//重置课程成绩选择框
						$("#sCourseScores").html("<option value=''>--请选择--</option>");
						//查询所有部门	
						//初始化select
						//查询后端的部门列表，部门主加到select中
						$.ajax({
							url:"courses/listcu.do?rows=100",
							success:function(data){
								//遍历rows数据
								//for(i in data.rows){ data.rows[i]}
								//$(data.rows,function(value ){ })
								$.each(data.rows,function(index,course){
									//主加到select中
									$("#sName").append("<option value="+course.cuId+">"+course.cuName+"</option>")
								}),
				        $.ajax({
							   url:"user/selectuser.do?rows=100",
							   success:function(data){
							   $.each(data.rows,function(index,student){
								   	//主加到select中
								    $("#stName").append("<option value="+student.stuid+">"+student.stuname+"</option>");
								        })
							          }
								}),
						$.ajax({
							url:"classes/listcl.do?rows=100",
							success:function(data){
								$.each(data.rows,function(index,aClass){
									//主加到select中
									$("#sClassName").append("<option value="+aClass.csId+">"+aClass.csName+"</option>")
								})
							}
							
						});
						url="socres/addsl.do";	  					
				     }
			        })
				}
		      },'-',{
				text:"编辑",		    
				iconCls: 'icon-edit',
				handler: function(){
					//打开对话框、
					$("#dlg").dialog("open");
					//修改对话框标题
					$("#dlg").dialog("setTitle","编辑成绩"); 
					//回显数据
						//获取选中的第一个数据
						var depts = $("#dg").datagrid("getSelected");
						if(depts){
							$("#ff").form("load",depts)
						    //提交表单 点击保存按钮
							url="socres/update.do";
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
								ids.push(this.cssId);//[1,2,3]
						})
						//ids.toLocaleString()//"1,2,3"
						//发请求
						$.ajax({url:"socres/deletesl.do",data:{ids:ids.toLocaleString()},success:function(data){
							alert(data.msg)
							 $("#dg").datagrid("reload");
						}
						})
						
					}
				}
			} ],
			pagination:true

		}); 
	})
</script>