<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/jsp/lib.jsp" />



<table id="StudentInfo"></table>  
<div id="StudentInfoUpdate">
<form id="ff" action="#">
<table >
         <tr>
			<td><input type="hidden" id="stuid" name="stuid" /></td>
	    </tr>
         <tr>
			<td>姓名:</td>
			<td><input type="text" id="stuname" name="stuname" /></td>
	    </tr>
	   
	    <tr>
			        <td>性别:</td>
                    <td>     
                                 男<input name="stusex" id="sex" type="radio" value="男">
                                 女<input name="stusex" id="sex" type="radio" value="女">
                   </td>
       </tr>
       
         <tr>      
			<td>年龄:</td>
			<td><input type="text" id="stuage" name="stuage" /></td>
		</tr>
		
		<tr>
			<td>电话：</td>
			<td><input type="text" id="stutel" name="stutel" /></td>
		</tr>
		
		<tr>
			<td>QQ：</td>
			<td><input type="text" id="stuqq" name="stuqq" /></td>
	    </tr>
	    
	    <tr>
			<td>地址：</td>
			<td><input type="text" id="stuaddress" name="stuaddress" /></td>
		</tr>
	   
	   <tr>
			<td>课程意向：</td>
		               	 <td>               
			                       <select id="stuintent"  name="stuintent">
		                                     <option value="JAVA EE">JAVAEE</option>
		                                     <option value="JAVA SE">JAVASE</option>
		                                     <option value="JAVA ME">JAVAME</option>
                                	</select>
                         </td>
	   </tr>
	   
	    <tr>
		     <td>状态:</td>
                    <td>     
                                    <select id="stustatus"  name="stustatus">
		                                     <option value="已报名">已 报 名</option>
		                                     <option value="未报名">未 报 名</option>
                                	</select>
                   </td>
		    </tr>
		
	     <tr>
			<td>备注：</td>
			<td><input type="text" id="sturemark" name="remark" /></td>
		</tr>
		
		<td>
              <button id="btn" >确定修改</button>
        </td>
</table>
   </form>
</div>


<script type="text/javascript">
$(function(){
       $("#StudentInfo").datagrid({
    	   url:"user/selectuser.do",
    	   //宽度自适应
			fitColumns:true,
			//开启分页
			pagination:true,
			//只允许选择一行
			singleSelect:true,
			//数据格式  
			
            columns : [ [ {
				//表格第一列
				field : 'stuid',
				title : 'ID',
				width : 100,
				 align:'center',
				 halign: 'center',
			}, {
				//表格第二列
				field : 'stuname',
				title : '姓名',
				width : 100,
				 align:'center',
				 halign: 'center',
			}, {
				//表格第三列
				field : 'stusex',
				title : '性别',
				width : 100,
			    align:'center',
			    halign: 'center',
			    formatter: function(value,row,index){
					if (value=="male"){
						return "男"
					} else {
						return "女";
					}
			    }
			},
			{
				//表格第四列
				field : 'stuage',
				title : '年龄',
				width : 100,
				 align:'center',
				 halign: 'center',
			}, 
			{
				//表格第五列
				field : 'stutel',
				title : '电话',
				width : 100,
				 align:'center',
				 halign: 'center',
			}, 
			{
				//表格第六列
				field : 'stuqq',
				title : 'QQ',
				width : 100,
				 align:'center',
				 halign: 'center',
			}, {
				//表格第七列
				field : 'stuaddress',
				title : '地址',
				width : 100,
			    align:'center',
			    halign: 'center',
			},
			{
				//表格第八列
				field : 'stuintent',
				title : '课程意向',
				width : 100,
				 align:'center',
				 halign: 'center',
			}, 
			{
				//表格第九列
				field : 'stustatus',
				title : '状态',
				width : 100,
				 align:'center',
				 halign: 'center',
			}, 
			{
				//表格第十列
				field : 'remark',
				title : '备注',
				width : 100,
				 align:'center',
				 halign: 'center'
			}
			] ],
			
       //初始化按钮
       	 toolbar:[{
			 text:"添加信息",
			 iconCls:'icon-add',
			 handler:function(){
				 $("#userinfo").dialog({
					    closed: false,
					    modal: true
				     })
			 }
		  },"-",{
			  text:'修改信息',
			  iconCls:'icon-edit',
			  handler:function(){
				  
				//回显数据
					//获取选中的第一个数据
					var depts = $("#StudentInfo").datagrid("getSelected");
					if(depts==null){
				alert("请选择需要修改的信息")
				}else{
				  $("#ff").form("load",depts)
				 $("#StudentInfoUpdate").dialog({
					  title: '修改学生信息',    
					    width: 280,    
					    height: 300,
					    modal: true,
					    closed: false
				 })
				}
			  }
         },"-",{
			  text:'删除信息',
			  iconCls:'icon-remove',
			  handler:function(){
				 var data= $("#StudentInfo").datagrid("getSelected");
				if(data==null){
					 alert("请选中被删除的数据")
				 }else{
					$.ajax({
						url:"user/deleteUserInfo.do?stuid="+data.stuid,
						success:function(){
							alert("删除成功");
							$("#StudentInfo").datagrid("reload");
							
						}
					})
					
					 
				 }
			  }
         }]
       })
       
       //修改按钮被点击
       $("#btn").click(function(){
    	   //获取表单数据
    	   var updateUserInfo = $("#ff").form();
    	   var data= updateUserInfo.serialize();
    	   $.ajax({
				url:"user/updateUserInfo.do",
				data:data,
				success:function(){
					alert("修改成功"),
					//关闭窗口
					$("#StudentInfoUpdate").dialog("close");
					//刷新表格
					$("#StudentInfo").datagrid("reload");
					$("#ff").form("clear")
				}
})
    	 
       })
       
        
       
       //添加按钮被点击
$("#btn1").click(function(){
	//得到文件框输入值
	 var stusex = 0
	$("input[name=sex]").each(function(){
		if(this.checked){
			stusex=this.value
		}
	})
	//获取表单的数据
	var userfrom = $("#userfrom").form();
	 var data= userfrom.serialize();
	 alert(data)
	$.ajax({
							url:"user/	adduser.do",
							data:data,
							success:function(){
								alert("提交成功"),
								//关闭窗口
								$("#userinfo").dialog("close");
								//刷新表格
								$("#StudentInfo").datagrid("reload");
								$("#userfrom").form("clear")
							}
			})
			
			
})
 

       //添加学生信息。初始化为 不可视
    $("#userinfo").dialog({
	    closed: true
     })  
     $("#StudentInfoUpdate").dialog({
 	    closed: true
      }) 
})
</script>

       
              
       
	
<div id="userinfo">
	<form action="#" id="userfrom" data-options="novalidate:true">
	<table id="dg" align="center" >
        <tr>
			<td>姓名:</td>
			<td><input type="text" id="stuname" name="stuname" /></td>
	    </tr>
	   
	    <tr>
			        <td>性别:</td>
                    <td>     
                                 男<input name="stusex" id="sex" type="radio" value="男">
                                 女<input name="stusex" id="sex" type="radio" value="女">
                   </td>
       </tr>
      
        <tr>      
			<td>年龄:</td>
			<td><input type="text" id="stuage" name="stuage" /></td>
		</tr>
		
		<tr>
			<td>电话：</td>
			<td><input type="text" id="stutel" name="stutel" /></td>
		</tr>
		
		<tr>
			<td>QQ：</td>
			<td><input type="text" id="stuqq" name="stuqq" /></td>
	    </tr>
	    
	    <tr>
			<td>地址：</td>
			<td><input type="text" id="stuaddress" name="stuaddress" /></td>
		</tr>
	   
	   <tr>
			<td>课程意向：</td>
		               	 <td>               
			                       <select id="stuintent"  name="stuintent">
		                                     <option value="JAVA EE">JAVAEE</option>
		                                     <option value="JAVA SE">JAVASE</option>
		                                     <option value="JAVA ME">JAVAME</option>
                                	</select>
                         </td>
	   </tr>
	   
	    <tr>
		     <td>状态:</td>
                    <td>     
                                    <select id="stustatus"  name="stustatus">
		                                     <option value="已报名">已 报 名</option>
		                                     <option value="未报名">未 报 名</option>
                                	</select>
                   </td>
		    </tr>
		
	     <tr>
			<td>备注：</td>
			<td><input type="text" id="sturemark" name="remark" /></td>
		</tr>
		
		<td>
              <button id="btn1" >添加信息</button>
        </td>
		</table>
	</form>
</div>




