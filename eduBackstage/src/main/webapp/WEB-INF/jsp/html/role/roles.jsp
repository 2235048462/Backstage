<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/jsp/lib.jsp" />

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/metroStyle/metroStyle.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/demo.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.ztree.all.min.js"></script>


<!-- 使用easgyUI datagrid组件表格 -->
<table id="dg"></table>


<div id="dlg">
	<ul id="treeDemo" class="ztree"></ul>
</div>

<div id="div1">
<form id="FF" action="#" method="get">
      <font color="red"></font><br><br>
&nbsp;&nbsp;角色编号:<input type="text" name="id" id="id"><br><br>
&nbsp;&nbsp;角色名称:<input type="text" name="name" id="name"><br><br>
&nbsp;&nbsp;角色编码:<input type="text"  name="code" id="code"><br><br>
&nbsp;&nbsp;角色描述:<input type="text"  name="description" id="description">
</form>
</div>

<script type="text/javascript">

//配置信息js对象
var setting={
		data:{
			//开启使用简单数据结构
			simpleData:{
				//开启简单数据类型
				enable:true,
				//指定节点数据中id的key
				idKey:"id",
				//指定节点数父id的key
				pIdKey:"pId",
				//根节点的id
				rootPid: null
			}
		},
		check : {
			enable : true //设置是否显示checkbox复选框
		}
		
}
//页面加载完毕调用初始化
	$(function() {
       var url="";		
		
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
					var id=$("#id").val();
					var name=$("#name").val();
					var code=$("#code").val();
					var description=$("#description").val();
					var data="id="+id+
					         "&name="+name+
					         "&code="+code+
					         "&description="+description;	
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
		
		
		
		function initTree(roleid){
			//使用角色id查询权限数据
			$.ajax({
				url:'role/funs.do?roleId='+roleid,
				success:function(data){
					//初始化权限数
					$.fn.zTree.init($("#treeDemo"), setting, data);
				}
			})
		}
		
		//初始化对话框
		$("#dlg").dialog({
			closed:true,
			buttons:[
				{
					text:"保存",
					iconCls:"icon-save",
					handler:function(){
						//获取角色id
						var row = $("#dg").datagrid("getSelected");
						//获取整个权限树
						var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
						//获取被选中的角色id
						var nodes = treeObj.getCheckedNodes(true);
						//nodes中所有节点的id转化为1，2，3，4字符串
						var ids = []
						$(nodes).each(function(){
							ids.push(this.id)
						})
						$.ajax({
							url:"role/authfuns.do",
							data:{roleId:row.id,fids:ids.toLocaleString()},
							success:function(){
								initTree(row.id);
							}
						})
						$("#dlg").dialog("close");
					}
				},{
					text:"取消",
					iconCls:"icon-cancel",
					handler:function(){
						$("#dlg").dialog("close");
					}
				}]
		})
		
		
		//初始化表格
		$('#dg').datagrid({    
		    url:'role/list.do',  
		    //一行数据
		    //{"id":1,"name":"全部系统管理员（超级管理员）","code":"sysadmin","description":"超级管理员"}
		    columns:[[    
		        {field:'id',title:'ID',width:100},    
		        {field:'name',title:'角色名称',width:100},    
		        {field:'code',title:'角色码',width:100},    
		        {field:'description',title:'描述',width:100}
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
					$("#div1").dialog("setTitle", "新增角色");	
					url="role/add.do";
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
					$("#div1").dialog("setTitle", "编辑角色");	
					//获取选中的第一个数据
					var roles = $("#dg").datagrid("getSelected");
					if(roles){
						$("#FF").form("load",roles)
					//提交表单 点击保存按钮
						url="role/update.do";
					}
				}
			},'-',{
				text:"删除",	
				iconCls: 'icon-remove',
				handler: function(){
					//先拿到被选中的部门id [{id},{},{}]
					var role = $("#dg").datagrid("getSelected");
						 $.ajax({url:"role/delete.do?id="+role.id,
							 success:function(data){
							    alert(data.msg)
							    $("#dg").datagrid("reload");
						}
						 })
				}
			},'-',{
				text:"授权",	
				iconCls: 'icon-edit',
				handler: function(){
					//获得表格选中的数据
					var row = $("#dg").datagrid("getSelected")
					if(row){
						//打开对话框
						$("#dlg").dialog("open");
						$("#dlg").dialog("setTitle","修改权限");
						initTree(row.id);
					}
			
				}
			}],
			pagination:true,
			singleSelect:true

		}); 
	})
</script>