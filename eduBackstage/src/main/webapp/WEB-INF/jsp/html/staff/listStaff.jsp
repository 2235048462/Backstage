<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/jsp/lib.jsp" />
姓名：<input id="name">
<!-- 选择部门，职位发生相应的变化 -->
部门：<select id="deptId" >
		<option value="">--请选择--</option>
	</select>
职位：<select id="positionId" >
		<option value="">--请选择--</option>
	</select>
性别 ：
男<input name="sex" id="sex" type="radio" value="1"> 
女<input name="sex" type="radio" value="0"><br><br>
<!-- 1,只选择了一个起始日期或者结束日期
	 2，两个都选择了 起始日期小于结束日期 结束日期要大于起始日期
	 	判断大小
	 3，两个都没有选择
 -->
生日：起始日期<input id="start" type="text" class="easyui-datebox" ></input>     
	结束日期<input id="end" type="text" class="easyui-datebox" ></input>  

<button id="btn">查询</button>


<!-- 使用easgyUI datagrid组件表格 -->
<table id="dg"></table>
<div id="div1">
<form id="FF" action="#" method="get">
      <font color="red"></font><br><br>
<!-- {"id":1,"name":"任翔","username":"renxiang","password":null,"sex":1,"birthday":784382301000,"entry":1510055935000,"positionId":1,"updateTime":null,"createTime":null} -->
&nbsp;&nbsp;员工编号:<input type="text" name="id" id="ids"><br><br>
&nbsp;&nbsp;员工姓名:<input type="text" name="name" id="names"><br><br>
&nbsp;&nbsp;员工账号:<input type="text"  name="username" id="usernames"><br><br>
&nbsp;&nbsp;员工性别:
男<input name="sexs" id="sex" type="radio" value="1"> 
女<input name="sexs" type="radio" value="0"><br><br>
&nbsp;&nbsp;员工生日:<input id="birthdays" name="birthday" type="text" class="easyui-datebox" ><br><br>
&nbsp;&nbsp;入职时间:<input id="entrys" name="entry" type="text" class="easyui-datebox" ><br><br>
&nbsp;&nbsp;员工部门：<select id="deptIds" >
		<option value="">--请选择--</option>
	</select><br><br>
&nbsp;&nbsp;员工职位：<select id="positionIds" >
		<option value="">--请选择--</option>
	</select>
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
					$("#deptId").append("<option value="+dept.id+">"+dept.deptName+"</option>")
				})
				
			}
			
		})
		
		//部门的下拉列表绑定change事件
		$("#deptId").change(function(){
			//重置下来列表中的html代码
			$("#positionId").html("<option value=''>--请选择--</option>")
			//获取选中该部门的id
			var deptId = $("#deptId").val();
			//根据部门id查询所有职位
			$.ajax({
				url:"position/list.do?deptId="+deptId,
				success:function(data){
					//遍历rows职位数据
					$.each(data.rows,function(index,position){
						//追加到select中
						$("#positionId").append("<option value="+position.id+">"+position.positionName+"</option>")
					})
					
				}
				
			})
			
			
		})
		
		$("#btn").click(function(){
			//获取查询参数
			var name = $("#name").val()
			var positionId = $("#positionId").val()
			var sex
			$("input[name=sex]").each(function(){
				if(this.checked){
					sex=this.value
				}
			})
			
			var start = $("#start").datebox("getValue")
			if(start!=""&&start){
				start=start+" 00:00:00"
			}
			
			var end = $("#end").datebox("getValue")
			if(end!=""&&end){
				end=end+" 00:00:00"
			}
			//带参数刷新表格
			//带参数刷新表格
			$("#dg").datagrid({
				queryParams:{
					name:name,
					positionId:positionId,
					sex:sex,
					start:start,
					end:end
				}
			})
			
			
		})
		
	    
		
		//初始化对话框
		$("#div1").dialog({
			width : 330,
			height : 450,
		    closed: true,    
		    modal: true, //遮罩
		    buttons:[{
				text:"保存",
				iconCls:"icon-save",
				handler:function(){
					var id=$("#ids").val();
					var name=$("#names").val();
					var username=$("#usernames").val();
					var password=$("#passwords").val();
					var sex
					$("input[name=sexs]").each(function(){
						if(this.checked){
							sex=this.value
						}
					})
					
					var birthday = $("#birthdays").datebox("getValue")
					if(birthday!=""&&birthday){
						birthday=birthday+" 00:00:00"
					}
					
					var entry = $("#entrys").datebox("getValue")
					if(entry!=""&&entry){
						entry=entry+" 00:00:00"
					}
					
					var positionId = $("#positionIds").val()
					
					var data="id="+id+
					         "&name="+name+
					         "&username="+username+
					         "&password="+password+
					         "&sex="+sex+
					         "&birthday="+birthday+
					         "&entry="+entry+
					         "&positionId="+positionId;	
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
		    url:'staff/list.do',  
		    //一行数据
		    //{"id":1,"name":"任翔","username":"renxiang","password":null,"sex":1,"birthday":784382301000,"entry":1510055935000,"positionId":1,"updateTime":null,"createTime":null}
		    columns:[[    
		        {field:'id',title:'ID',width:100},    
		        {field:'name',title:'姓名',width:100},    
		        {field:'username',title:'账号',width:100},
		        {field:'sex',title:'性别',width:100,formatter:function(value){
		        	if(value=="1"){
		        		return "男"
		        	}else{
		        		return "女"
		        	}
		        }},    
		        {field:'positionName',title:'部门名称',width:100},    
		        {field:'birthday',title:'出生日期',width:100,formatter:function(value){
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
		        {field:'entry',title:'入职时间',width:100,formatter:function(value){
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
					$("#div1").dialog("setTitle", "新增员工");
					//重置部门选择框
					$("#deptIds").html("<option value=''>--请选择--</option>");
					//查询所有部门	
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
								$("#deptIds").append("<option value="+dept.id+">"+dept.deptName+"</option>")
							})
							
						}
						
					});
					
					//部门的下拉列表绑定change事件
					$("#deptIds").change(function(){
						//重置下来列表中的html代码
						$("#positionIds").html("<option value=''>--请选择--</option>")
						//获取选中该部门的id
						var deptId = $("#deptIds").val();
						//根据部门id查询所有职位
						$.ajax({
							url:"position/list.do?deptId="+deptId,
							success:function(data){
								//遍历rows职位数据
								$.each(data.rows,function(index,position){
									//追加到select中
									$("#positionIds").append("<option value="+position.id+">"+position.positionName+"</option>")
								})
								
							}
							
						})
						
						
					});
					url="staff/add.do?";
					
				}
			},'-',{
				text:"编辑",		    
				iconCls: 'icon-edit',
				handler: function(){
				  
					//清除表单残留内容
					$("#FF").form("clear");
					//打开对话框
					$("#div1").dialog("open");
					//修改对话框的标题
					$("#div1").dialog("setTitle", "修改员工");
					//重置部门选择框
					$("#deptIds").html("<option value=''>--请选择--</option>");
					//查询所有部门	
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
								$("#deptIds").append("<option value="+dept.id+">"+dept.deptName+"</option>")
							})
							
						}
						
					});
					
					//部门的下拉列表绑定change事件
					$("#deptIds").change(function(){
						//重置下来列表中的html代码
						$("#positionIds").html("<option value=''>--请选择--</option>")
						//获取选中该部门的id
						var deptId = $("#deptIds").val();
						//根据部门id查询所有职位
						$.ajax({
							url:"position/list.do?deptId="+deptId,
							success:function(data){
								//遍历rows职位数据
								$.each(data.rows,function(index,position){
									//追加到select中
									$("#positionIds").append("<option value="+position.id+">"+position.positionName+"</option>")
								})
								
							}
							
						})
						
						
					});
					
					
					//获取选中的第一个数据
					var staffs = $("#dg").datagrid("getSelected");
					if(staffs){
						$("#FF").form("load",staffs)
					//提交表单 点击保存按钮
						url="staff/update.do";
					}
				 
				
				}
			},'-',{
				text:"删除",	
				iconCls: 'icon-remove',
				handler: function(){
						
					//先拿到被选中的部门id [{id},{},{}]
					var staffs = $("#dg").datagrid("getSelections");
					if(staffs){
						var ids = []; //定义空数组
						$(staffs).each(function(index){
								ids.push(this.id);//[1,2,3]
						})
						//ids.toLocaleString()//"1,2,3"
						//发请求
						 $.ajax({url:"staff/delete.do",
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