<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@page import="java.text.SimpleDateFormat"%>
	
<%@page import="java.util.*"%>
<jsp:include page="/WEB-INF/jsp/lib.jsp" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>学生状态跟踪</title>
</head>
    <form>
<table>
       
       <tr>
          [编辑学员跟踪]
       </tr>
    <tr>
          <td>首次咨询日期：
          <%
		Date d = new Date();
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String now = df.format(d);
	       %>
	
	    <%=now %>          
          </td>
          
          
           <tr>
          <td>
          交流方式:<select id="stuintent"  name="stuintent">
		                                     <option value="wx">微信</option>
		                                     <option value="qq">QQ</option>
		                                     <option value="internet">其他网络渠道</option>
                                	</select>
                                	
          </td>
          
          
           <tr>
          <td>营销人员:
             <select id="stuintent"  name="stuintent">
		                                     <option value="zhangsan">张三</option>
		                                     <option value="lisi">李四</option>
		                                     <option value="wangwu">王五</option>
                                	</select>
           </td>
           
          </td>
    </tr>
    
      <tr>
          <td>资讯时常:</td>
          
         
    </tr>
    
    
     <tr>
           <td>QQ:</td>
    </tr>
    
     <tr>
            <td>学员:</td>
    </tr>
    
     <tr>
           <td>备注:</td>
    </tr>
  
</table>
</form>
</html>