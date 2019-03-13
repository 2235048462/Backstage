<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
		<jsp:include page="/WEB-INF/jsp/lib.jsp" />

<table id="dg"></table>

<div id="dlg">
	<form action="#" id="ff">
		<input name="id" type="hidden">
		部门名称:<input disabled="disabled" name="dname"><br>
		职位名称:<input disabled="disabled" name="pname"><br>
		姓名:<input disabled="disabled" name="name"><br>
		角色：<div id="roles">
				
			</div>
		用户名:<input  name="username"><br>
		密码:<input  name="password"><br>
		
	</form>
</div>

<script type="text/javascript">




//页面加载完毕调用初始化
	$(function() {
		//初始化checkbox
		$.ajax({
			url:"role/list.do?rows=30",
			success:function(data){
				$(data.rows).each(function(){
					$("#roles").append(this.name+'<input  name="roids" type="checkbox" value="'+this.id+'"><br>')
				})
			}
		})
		//初始化对话框
		$("#dlg").dialog({
			title:"编辑管理员",
		    closed: true,    
		    modal: true,   //遮罩
		    buttons:[{
				text:"保存",
				iconCls:"icon-save",
				handler:function(){
					//获取管理员的id
					var staffid = $("input[name=id]").val()
					var roids=[]
					//获取全部的checkbox
					$("input[type=checkbox]").each(function(){
						//如果checkbox被选中就取id
						if(this.checked){
							roids.push(this.value)
						}
					})
					//获取管理员的用户名
					var username = $("input[name=username]").val()
					//获取管理员的密码
					var password = $("input[name=password]").val()
					//数据发送到服务器保存
					$.ajax({
						url:"admin/update.do",
						data:{id:staffid,roids:roids.toLocaleString(),username:username,password:password},
						success:function(){
							$("#dlg").dialog("close")
							//刷新表格
							$('#dg').datagrid("reload")   
						}
					})
					
				}
		    },{
				text:"取消",
				iconCls:"icon-cancel",
				handler:function(){
					$("#dlg").dialog("close")
				}
		    }]
		})
		
		//初始化表格
		$('#dg').datagrid({    
		    url:'admin/list.do',  
		    //一行数据
		    //{"rname":"全部系统管理员（超级管理员）","pname":"财务总监","name":"卢宝平","id":6,"dname":"财务部"}
		    columns:[[    
		        {field:'id',title:'ID',width:100},    
		        {field:'name',title:'姓名',width:100},    
		        {field:'dname',title:'部门名称',width:100},    
		        {field:'pname',title:'职位名称',width:100},    
		        {field:'rname',title:'角色名称',width:100},
		        {field:'username',title:'登陆名称',width:100},
		    ]],
		    fitColumns:true,
		    toolbar: [{
				text:"编辑",		    
				iconCls: 'icon-edit',
				handler: function(){
					//打开编辑对话框
					$("#dlg").dialog("open")
					var row = $("#dg").datagrid("getSelected");
					if(row){
						//先清楚对话框
						$("#ff").form("clear");
						$("#ff").form("load",row);
						//查询管理员所有的角色
						$.ajax({
							url:"admin/roles.do?staffId="+row.id,
							success:function(data){
								//选中所有input name属性是roids的标签
								$("input[name=roids]").each(function(_,dom){
									$(data.rows).each(function(){
										//如果查询到的角色id和input表全的value值相同就选中此标签
										if(this.roleId==$(dom).val()){
											$(dom).attr("checked","checked")
										}
									})
								})
							}
						})
					}
				}
			}],
			pagination:true,
			singleSelect:true

		}); 
	})
</script>