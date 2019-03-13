<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
		<jsp:include page="/WEB-INF/jsp/lib.jsp" />
人员查询<input id="msRenyuan" >
<button id="btn" >查询</button>
<!-- 使用easgyUI datagrid组件表格 -->
<table id="dg"></table>

<div id="dlg">
	<form action="#" id="ff"><br>
	            人员编号<input name="mianshi_id" disabled id="mianshi_id"><br>
		面试公司<input name="ms_gongsi"id="ms_gongsi"><br>
		期望工资<input name="ms_gongzi" id="ms_gongzi"><br>
		面试结果 ：
                                         录入<input name="jieguo"  type="radio" value="1">
                                         待定<input name="jieguo" type="radio" value="0"><br>
	</form>
</div>
<script type="text/javascript">

//查询按钮绑定事件
	$("#btn").click(function(){
		//得到文件框输入值
		var msRenyuan = $("#msRenyuan").val()
		//带参数刷新表格
		$("#dg").datagrid({
			
			queryParams:{msRenyuan:msRenyuan }
		
		})
		//url:'mianshi/list2.do';
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
					var id=$("#mianshi_id").val();
						var gongsi=$("#ms_gongsi").val();
							var gongzi=$("#ms_gongzi").val();
								var jieguo
								$("input[name=jieguo]").each(function(){
									if(this.checked){
										jieguo=this.value
									}
								})
					var data ="mianshiId="+id+
					           "&msGongsi="+gongsi+
					           "&msGongzi="+gongzi+
					           "&msJieguo="+jieguo;
					           
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
		    url:'mianshi/list2.do',  
		    //一行数据
		   //{"stuQQ":"10001","stuAge":15,"mianshi_id":1,"stuAddress":"西安市雁塔区","ms_gongsi":"测试公司1",
		 //"stuName":"张三","ZHUANGTAI":1,"stuSex":"男","stuTel":"138888","ms_jieguo":1,"ms_gongzi":12000,"stuIntent":"JAVA"}
		   columns:[[    
		        {field:'mianshi_id',title:'ID',width:100},    
		        {field:'stuName',title:'姓名',width:100},
		        {field:'stuSex',title:'性别',width:100},
		        {field:'stuQQ',title:'QQ',width:100},
		        {field:'stuAge',title:'年龄',width:100},
		        {field:'stuTel',title:'联系方式',width:100},
		        {field:'stuAddress',title:'地址',width:100},
		        {field:'stuIntent',title:'专业',width:100},
		        {field:'ms_gongsi',title:'公司',width:100},
		        {field:'ms_gongzi',title:'工资',width:100},
		        {field:'ms_jieguo',title:'面试果结',width:100, formatter:function(msJieguo){
		        	if(msJieguo=="1"){
		        		return "录取"
		        	}else{
		        		return "待定"
		        	
		        }}},
		    ]],
		    fitColumns:true,
		    toolbar: [{
				text:"编辑",		    
				iconCls: 'icon-edit',
				handler: function(){
					//清空表单数据
					$("#ff").form("clear");
					//打开对话框、
					$("#dlg").dialog("open");
					//修改对话框标题
					$("#dlg").dialog("setTitle","修改面试人员信息");
					//回显数据
						//获取选中的第一个数据
						var mianshis = $("#dg").datagrid("getSelected");
						if(mianshis){
							
						$("#ff").form("load",mianshis)

						//提交表单 点击保存按钮
							url="mianshi/update.do";
						}
					}
			}],
			pagination:true
		}); 
	})
</script>