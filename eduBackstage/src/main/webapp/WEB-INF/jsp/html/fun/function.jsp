<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/jsp/lib.jsp" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/metroStyle/metroStyle.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/demo.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.ztree.all.min.js"></script>

<ul id="treeDemo" class="ztree"></ul>


<div id="dlg">
	<form action="#" id="ff">
		<input name="pid" type="hidden"  id="pid"> 
		父节点<input id="pname" disabled="disabled"><br>
		节点名称<input id="name" name="name"><br> 
		节点代码<input id="code" name="code"><br>
		节点描述<input id="description" name="description"><br> 
		地址（接口）<input id="page" name="page"><br>
		<input name="generatemenu" type="hidden"  id="generatemenu"> 
	</form>
</div>

<div id="dlg2">
	<form action="#" id="ff2">
		<input name="pid" type="hidden"  id="pid2"> 
		父节点<input id="pname2" disabled="disabled"><br>
		节点名称<input id="name2" name="name"><br> 
		节点代码<input id="code2" name="code"><br>
		节点描述<input id="description2" name="description"><br> 
		地址（接口）<input id="page2" name="page"><br>
		<input name="generatemenu" type="hidden"  id="generatemenu2"> 
	</form>
</div>
<!-- 右击节点显示的菜单 -->
<style type="text/css">
div#rMenu {
	position: absolute;
	visibility: hidden;
	top: 0;
	background-color: #555;
	text-align: left;
	padding: 2px;
}

div#rMenu ul li {
	margin: 1px 0;
	padding: 0 5px;
	cursor: pointer;
	list-style: none outside none;
	background-color: #DFDFDF;
}
</style>

<div id="rMenu">
	<ul>
		<li id="m_add" onclick="addTreeNode();">增加节点</li>
		<li id="m_edit" onclick="editTreeNode();">编辑节点</li>
	</ul>
</div>


<script  type="text/javascript">
var url="";
function addTreeNode(){
	//清空表单
	$("#ff").form("clear")
	//设置对话框标题
	$("#dlg").dialog("setTitle","增加节点");
	//获取选中的节点
		//获取节点树
		var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
		var nodes = treeObj.getSelectedNodes();
		if(nodes[0]){
			$("#pid").val(nodes[0].id)
			$("#pname").val(nodes[0].name)
		}
	
	//打开对话框
	$("#dlg").dialog("open");
}

function editTreeNode(){
	//清空表单
	$("#ff").form("clear")
	//设置对话框标题
	$("#dlg2").dialog("setTitle","编辑节点");
	//获取选中的节点
	//后台查询选中节点的数据
	//在表单中回显数据
	//修改保存按钮中的ajax的url地址为function/update.do
	//获取节点树
	var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
	var nodes = treeObj.getSelectedNodes();
	if(nodes[0]){
		$.ajax({
			url:"function/chaxun.do?id="+nodes[0].id,
			success:function(data){
					$("#name2").val(data.name);
					$("#pname2").val(data.pid);
					$("#code2").val(data.code);
					$("#description2").val(data.description);
					$("#page2").val(data.page);
					$("#generatemenu2").val(data.generatemenu);
			}	
		});
	}
	//打开对话框
	$("#dlg2").dialog("open");
	url="function/update.do?id="+nodes[0].id;
}

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
		view : {
			selectedMulti : true //是否开启多选
		},
		edit : {
			enable : true,//开启节点编辑模式
			//初始化节点调用此函数 
			showRemoveBtn : function(treeId, treeNode) {
				//isParent 为true的时候是父节点 不可删除
				//isParent 为false的时候是子节点 可以删除的
				return !treeNode.isParent;
			},
			//是否显示重新命名按钮
			showRenameBtn : false,
		},
		callback : {
			//点击删除按钮的时候执行此函数
			onRemove : function(event, treeId, treeNode) {
				if (treeNode) {
					//发送ajax请求删除节点
					$.ajax({
						url:"function/delete.do?id="+treeNode.id,
						success:function(){
							//刷新节点
							//获取节点树
							var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
							//拿到树种选中的节点
							treeObj.reAsyncChildNodes(null, "refresh");
						}
					})
					
				}
			},
			
			//右击节点触发次函数 event 鼠标右击的事件
			onRightClick:function(event, treeId, treeNode) {
				if (treeNode) {
					//右击显示增加编辑对话框
					//拿到整棵树
					var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
					//选中被右击的节点
					treeObj.selectNode(treeNode);
					//显示按钮
					$("#rMenu,#m_add,#m_edit").show()
					//设置按钮的位置 坐标x,y 并且显示按钮
					$("#rMenu").css({
						"top":event.pageY+"px",
						"left":event.pageX+"px",
						visibility:"visible"})
					//鼠标点击其他区域就关闭按钮
					$("body").bind("mousedown",function(event){
						//鼠标点击非按钮区域
						if(!(event.target.id=="rMenu"||event.target.id=="m_add"||event.target.id=="m_edit")){
							//隐藏按钮
							$("#rMenu").css({visibility:"hidden"})
						}
					})
				}
					
			}
			
		},
		
		async : {
			enable : true, //设置启用异步加载
			type : "get", //异步加载类型:post和get
			//如果不定义默认值application/x-from-www;charset=UTF-8 默认是一个key:value
			//"application/json"参数值 {key:value}
			//contentType : "application/json", //定义ajax提交参数的参数类型，一般为json格式,在服务端的request的contentType "application/json"
			url : "function/nodes.do", //定义数据请求路径
			autoParam : [ "id=pid" ],// autoParam: ["id=zId"] 假设 对父节点 node = {id:1, name:"test"}，进行异步加载时，将提交参数 zId=1
			//定义提交时参数的名称，=号前面标识节点属性，后面标识提交时json数据中参数的名称
			dataFilter : function(treeId, parentNode, responseData) {
				//返回的节点数据中isParent不是boolean 改成boolean
				//返回的数据进行过虑
				$(responseData).each(function() {
					//返回1标识是父节点
					if (this.isParent == '1') {
						this.isParent = true;
					}
					//返回0标识是叶子节点
					if (this.isParent == '0') {
						this.isParent = false;
					}
				})
				return responseData;
			}
		}
		
}


//网页加载完毕执行这个方法
$(function() {
	
	//初始化对话框
	$("#dlg").dialog({
		closed:true,
		buttons:[
			{
				text:"保存",
				iconCls:"icon-save",
				handler:function(){
					//增加节点
					$.ajax({
						url:"function/add.do",
						data:$("#ff").form().serialize(),
						success:function(){
							//拿到整棵树
							var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
							var nodes = treeObj.getSelectedNodes();
							//强行刷新父节点下的子节点
							//需要先社会选中节点为父节点
							nodes[0].isParent=true;
							//刷新节点
							treeObj.reAsyncChildNodes(nodes[0], "refresh");
							$("#dlg").dialog("close");
						}
					})
				}
			},{
				text:"取消",
				iconCls:"icon-cancel",
				handler:function(){
					$("#dlg").dialog("close");
				}
			}]
	})
	
	
	
	//初始化对话框
	$("#dlg2").dialog({
		closed:true,
		buttons:[
			{
				text:"保存",
				iconCls:"icon-save",
				handler:function(){
					//增加节点
					$.ajax({
						url:url,
						data:$("#ff2").form().serialize(),
						success:function(){
							//拿到整棵树
							var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
							var nodes = treeObj.getSelectedNodes();
							treeObj.reAsyncChildNodes(nodes[0], "refresh");
							$("#dlg2").dialog("close");
						}
					})
				}
			},{
				text:"取消",
				iconCls:"icon-cancel",
				handler:function(){
					$("#dlg2").dialog("close");
				}
			}]
	})
	
	
	//获取根节点数据
	$.ajax({
			url:"function/nodes.do",
			success:function(data){
				//js 弱类型的语言
				//[{"isParent":"1","name":"管理员页面","pId":"1","id":11}] 修改isParent的值为true或者false
				
				$(data).each(function(){
					if(this.isParent == "1"){
						this.isParent=true
					}else{
						this.isParent=false
					}
				})
				
				//使用配置信息和节点数据初始化树
				$.fn.zTree.init($("#treeDemo"), setting, data);
			}
		})

})
</script>