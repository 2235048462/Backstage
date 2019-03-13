<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
		<jsp:include page="/WEB-INF/jsp/lib.jsp" />

<!-- 网页加载完毕，初始化select -->		
部门<select id="deptId" >
	<option value="">--请选择--</option>
	<!-- <option value="deptId">deptName</option> -->
</select>
职位<input id="positionName" >
<button id="btn">查询</button>
<!-- 使用easgyUI datagrid组件表格 -->
<table id="dg"></table>
<div id="div1">
<form id="FF" action="#" method="get">
      <font color="red"></font><br><br>
&nbsp;&nbsp;职位编号:<input type="text" name="id" id="postid"><br><br>
&nbsp;&nbsp;部门名称:<select id="deptIds">
                       <option value="">--请选择--</option>
                   </select><br><br>
&nbsp;&nbsp;职位名称:<input id="postName" type="text" name="positionName"><!-- <br><br>
&nbsp;&nbsp;修改时间:<input id="text3" type="text" name="updateTime"><br><br>
&nbsp;&nbsp;创建时间:<input id="text4" type="text" name="createTime"> -->
</form>
</div>
<script type="text/javascript">
//页面加载完毕调用初始化
	$(function() {
		//初始化select
		//查询后端的部门列表，部门主加到select中
		$.ajax({
			url:"dept/list.do?rows=100",
			success:function(data){
				//遍历rows部门数据
				//for(i in data.rows){ data.rows[i]}
				//$(data.rows,function(value ){ })
				$.each(data.rows,function(index,dept){
					//主加到select中
					$("#deptId").append("<option value="+dept.id+" name=deptId>"+dept.deptName+"</option>")
				})
				
			}
			
		})
		
		
		$("#btn").click(function(){
			//获取查询参数
			var deptId = $("#deptId").val()
			var positionName = $("#positionName").val()
			  
			//带参数刷新表格
			//带参数刷新表格
			$("#dg").datagrid({
				queryParams:{
					positionName:positionName,
					deptId:deptId,
					}
			})
			
			
		})
		
		//初始化对话框
		$("#div1").dialog({
			width : 300,
			height : 400,
		    closed: true,    
		    modal: true, //遮罩
		    buttons:[{
				text:"保存",
				iconCls:"icon-save",
				handler:function(){
					var id=$("input[name='id']").val();
					var deptId = $("#deptIds").val()
					var positionName = $("input[name='positionName']").val()
					var data="id="+id+"&deptId="+deptId+"&positionName="+positionName;	
					//发送ajax
					$.ajax({
						url:url,
						data:data,
						success:function(data){
							//刷新表格
							$("#dg").datagrid("reload");
							//关闭窗口
							$("#div1").dialog("close");
							$("#FF").form("clear")
						}
						})
				}
		    },{
				text:"取消",
				iconCls:"icon-cancel",
				handler:function(){
					//关闭窗口
					$("#div1").dialog("close");
				}
		    }]
		    
		})
		
		//初始化表格
		$('#dg').datagrid({    
		    url:'position/list.do',  
		    //一行数据
		    //{"id":1,"deptId":1,"deptName":"人力资源部","positionName":"人力资源主管","updateTime":null,"createTime":null}
		    columns:[[    
		        {field:'id',title:'ID',width:100},    
		        {field:'deptId',title:'部门ID',width:100},    
		        {field:'deptName',title:'部门名称',width:100},    
		        {field:'positionName',title:'职位名称',width:100},    
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
		    ]],
		    fitColumns:true,
		    toolbar: [{
				text:"新增",		    
				iconCls: 'icon-add',
				handler: function(){
					//清除表单残留内容
					$("#FF").form("clear");
					//打开对话框
					$("#div1").dialog("open");
					//修改对话框的标题
					$("#div1").dialog("setTitle", "新增职务");
					//重置部门选择框
					$("#deptIds").html("<option value=''>--请选择--</option>");
					//查询所有部门
					$.ajax({
						url:"dept/list.do?rows=100",
						success:function(data){
							//遍历rows部门数据
							//for(i in data.rows){ data.rows[i]}
							//$(data.rows,function(value ){ })
							$.each(data.rows,function(index,dept){
								//主加到select中
								$("#deptIds").append("<option value="+dept.id+" name='deptId'>"+dept.deptName+"</option>");
							})
							
						}
					});
					//获取添加参数
					//var id=$("input[name='postiid']").attr("value");
					//var id = $("#postid").val()
					url="position/add.do?";
				}
			},'-',{
				text:"编辑",		    
				iconCls: 'icon-edit',
				handler: function(){
					
					//打开对话框
					$("#div1").dialog("open");
					//修改对话框标题
					$("#div1").dialog("setTitle","编辑职务");
					$("#deptIds").html("<option value=''>--请选择--</option>");
					$.ajax({
						url:"dept/list.do?rows=100",
						success:function(data){
							//遍历rows部门数据
							//for(i in data.rows){ data.rows[i]}
							//$(data.rows,function(value ){ })
							$.each(data.rows,function(index,dept){
								//主加到select中
								$("#deptIds").append("<option value="+dept.id+" name='deptId'>"+dept.deptName+"</option>");
							})
							
						}
					});
					//回显数据
						//获取选中的第一个数据
						var posts = $("#dg").datagrid("getSelected");
						if(posts){
							$("#FF").form("load",posts)
						//提交表单 点击保存按钮
							url="position/update.do";
						}
				}
			},'-',{
				text:"删除",	
				iconCls: 'icon-remove',
				handler: function(){
					//先拿到被选中的部门id [{id},{},{}]
					var posts = $("#dg").datagrid("getSelections");
					if(posts){
						var ids = []; //定义空数组
						$(posts).each(function(index){
								ids.push(this.id);//[1,2,3]
						})
						//ids.toLocaleString()//"1,2,3"
						//发请求
						 $.ajax({url:"position/delete.do",
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