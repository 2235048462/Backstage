<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>在线教育平台登录</title>
<link href="${pageContext.request.contextPath}/css/main.css" rel="stylesheet" type="text/css" />
<jsp:include page="/WEB-INF/jsp/lib.jsp" />
</head>
<body>
	<div class="login">
		<div class="box png">
			<div class="logo png"></div>
			<div class="input">
				<div class="log">
					<font color='red' size='3'></font>
					<form id="loginForm" action="auth/login.do" method="post">
						<div class="name">
							<label>用户名</label> 
							<input class="easyui-textbox text" type="text" name="username" data-options="required:true" style="width: 200px;" />
						</div>
						<div class="name">
							<label>密&nbsp;&nbsp;码</label> 
							<input class="easyui-textbox text" type="text" name="password" data-options="required:true" style="width: 200px;" />
						</div>
						<div class="pwd">
							<input type="button" id="btn" class="submit" value="登录">
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(function() {
			$("#btn").click(function() {
				if (!$('#loginForm').form('validate')) {
					$.messager.alert('提示', '请填写用户名和密码');
					return;
				}
				$("#loginForm").submit();
			});
		})
	</script>
</body>
</html>