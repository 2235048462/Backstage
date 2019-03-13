<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/jsp/lib.jsp" />
<!-- 使用easgyUI datagrid组件表格 -->
<table id="dg"></table>
<div id="div1">
<form id="FF" action="#" method="get">
      <font color="red"></font><br><br>
<!--  //"stuStatus":"未报名","LIUSHI":"0","ZHUANGTAI":1,"stuSex":"男","XUNFEI":10000,"SHENGLIU":1,"stuQQ":"10001","stuAge":15,"stuAddress":"西安市雁塔区","ID":1,"stuName":"张三","stuTel":"138888","stuIntent":"JAVA" -->
&nbsp;&nbsp;<input type="hidden" name="ID" id="ID"><br><br>
&nbsp;&nbsp;学员状态:
已毕业<input id="yby" name="ZHUANGTAI" type="radio" value="已毕业"> 
未毕业<input id="wby" name="ZHUANGTAI" type="radio" value="未毕业"><br><br>
&nbsp;&nbsp;学员学费:<input type="text"  name="XUNFEI" id="XUNFEI"><br><br>
&nbsp;&nbsp;学员正/异常:
正常<input id="zc" name="LIUSHI" type="radio" value="正常"> 
流失<input id="ls" name="LIUSHI" type="radio" value="流失"><br><br>
</form>
</div>
<script type="text/javascript">


//页面加载完毕调用初始化
	$(function() {
					
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
					//获取表单的数据
					/* var ff = $("#FF").form();
					var data = ff.serialize() */
					var id=$("#ID").val();
					var zhuangtai
					$("input[name=ZHUANGTAI]").each(function(){
						if(this.checked){
							zhuangtai=this.value
						}
					});
					
					var xunfei=$("#XUNFEI").val();
					var liushi
					$("input[name=LIUSHI]").each(function(){
						if(this.checked){
							liushi=this.value
						}
					});
					var data="id="+id+
			         "&zhuangtai="+zhuangtai+
			         "&xunfei="+xunfei+
			         "&liushi="+liushi;	
					//发送ajax
					$.ajax({
						url:"student/update.do",
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
		    url:'student/list.do',  
		    //一行数据
		    //{"s_nate":"升学","stuStatus":"已报名","LIUSHI":"正常","stuQQ":"10001","stuAge":15,"stuAddress":"西安市雁塔区","ID":1,"ZHUANGTAI":"已毕业","stuName":"张三","XUNFEI":10000,"stuSex":"男","stuTel":"138888","stuIntent":"JAVA"}
		    columns:[[    
		        {field:'ID',title:'ID',width:100},    
		        {field:'stuName',title:'姓名',width:100},    
		        {field:'stuSex',title:'性别',width:100},
		        {field:'stuAge',title:'年龄',width:100},
		        {field:'stuTel',title:'联系方式',width:100},
		        {field:'stuQQ',title:'QQ',width:100},
		        {field:'stuAddress',title:'地址',width:100},
		        {field:'stuIntent',title:'班级',width:100}, 
		        {field:'ZHUANGTAI',title:'状态',width:100}, 
		        {field:'XUNFEI',title:'学费',width:100}, 
		        {field:'s_nate',title:'升/留学',width:100}, 
		        {field:'LIUSHI',title:'正常/流失',width:100}, 
		    ]],
		    fitColumns:true,
		    toolbar: [{
				text:"编辑",		    
				iconCls: 'icon-edit',
				handler: function(){
					//清除表单残留内容
					$("#FF").form("clear");
					//打开对话框
					$("#div1").dialog("open");
					//修改对话框的标题
					$("#div1").dialog("setTitle", "修改学员信息");
					
					//获取选中的第一个数据
					var students = $("#dg").datagrid("getSelected");
					if(students){
						//$("#XUNFEI").val(students.xunfei);
						$("#FF").form("load",students);
						 $("#yby").attr("value","已毕业");
						$("#wby").attr("value","未毕业");
						$("#zc").attr("value","正常");
						$("#ls").attr("value","流失"); 
					}else{
						//打开对话框
						$("#div1").dialog("close");
						alert("请选择一行数据进行编辑");
					}
				}
			}],
			pagination:true,
			singleSelect:true
		}); 
	})
</script>