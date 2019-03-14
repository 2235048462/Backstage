<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html >
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>应用实例</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/default.css" />
	<jsp:include page="/WEB-INF/view/lib.jsp" />
	<script type="text/javascript" src='${pageContext.request.contextPath}/js/outlook2.js'> </script>
    <script type="text/javascript">
	 var _menus = {"menus":[
						{"menuid":"1","icon":"icon-sys","menuname":"系统管理",
							"menus":[
									{"menuid":"11","menuname":"用户管理","icon":"icon-users","url":"${pageContext.request.contextPath}/html_admin_listadmin.do"},
									{"menuid":"12","menuname":"角色系统","icon":"icon-role","url":"${pageContext.request.contextPath}/html_role_roles.do"},
									{"menuid":"13","menuname":"权限设置","icon":"icon-set","url":"${pageContext.request.contextPath}/html_fun_function.do"},
									{"menuid":"14","menuname":"系统日志","icon":"icon-log","url":"${pageContext.request.contextPath}/html_log4_log4.do"}
								]
						},{"menuid":"2","icon":"icon-sys","menuname":"咨询管理",
							"menus":[{"menuid":"21","menuname":"咨询学生","icon":"icon-nav","url":"${pageContext.request.contextPath}/html_advisory_ConsultingStudent.do"},
									{"menuid":"22","menuname":"学生跟踪","icon":"icon-nav","url":"${pageContext.request.contextPath}/html_advisory_TrackStudent.do"},
									{"menuid":"23","menuname":"学生移交","icon":"icon-nav","url":"html/remove/listRemove.html"},
									{"menuid":"24","menuname":"移交历史","icon":"icon-nav","url":"html/remove/historyRemove.html"},
								]
						},{"menuid":"3","icon":"icon-sys","menuname":"学工管理",
							"menus":[{"menuid":"31","menuname":"在校学生系统","icon":"icon-nav","url":"${pageContext.request.contextPath}/html_student_student.do"},
									{"menuid":"32","menuname":"学生升/留级","icon":"icon-nav","url":"${pageContext.request.contextPath}/html_student_shengliu.do"},
									{"menuid":"33","menuname":"学生流失情况","icon":"icon-nav","url":"${pageContext.request.contextPath}/html_student_liushi.do"},
									{"menuid":"33","menuname":"数据报表","icon":"icon-nav","url":"${pageContext.request.contextPath}/html_student_shujubaobiao.do"},
									]
						},{"menuid":"4","icon":"icon-sys","menuname":"教学管理",
							"menus":[{"menuid":"41","menuname":"班级系统","icon":"icon-nav","url":"html_class_listClass.do"},
									{"menuid":"42","menuname":"课程类型","icon":"icon-nav","url":"html_course_listCourse.do"},
									{"menuid":"43","menuname":"考试系统","icon":"icon-nav","url":"html_exam_listExam.do"},
									{"menuid":"44","menuname":"成绩数据","icon":"icon-nav","url":"html_score_listScore.do"}
								]
						},{"menuid":"5","icon":"icon-sys","menuname":"就业管理",
							"menus":[{"menuid":"51","menuname":"面试情况","icon":"icon-nav","url":"html_mianshi_mianshi.do"},
							{"menuid":"51","menuname":"就业状态","icon":"icon-nav","url":"html_mianshi_jiuyezhuangtai.do"}
								]
						},{"menuid":"6","icon":"icon-sys","menuname":"人员管理",
							"menus":[{"menuid":"61","menuname":"部门系统","icon":"icon-nav","url":"${pageContext.request.contextPath}/html_dept_listDept.do"},
									{"menuid":"62","menuname":"职务系统","icon":"icon-nav","url":"${pageContext.request.contextPath}/html_position_listPosition.do"},
									{"menuid":"63","menuname":"员工系统","icon":"icon-nav","url":"${pageContext.request.contextPath}/html_staff_listStaff.do"}
								]
						}
				]};
        //设置登录窗口
        function openPwd() {
            $('#w').window({
                title: '修改密码',
                width: 300,
                modal: true,
                shadow: true,
                closed: true,
                height: 160,
                resizable:false
            });
        }
        //关闭登录窗口
        function closePwd() {
            $('#w').window('close');
        }

        

        //修改密码
        function serverLogin() {
            var $newpass = $('#txtNewPass');
            var $rePass = $('#txtRePass');

            if ($newpass.val() == '') {
                msgShow('系统提示', '请输入密码！', 'warning');
                return false;
            }
            if ($rePass.val() == '') {
                msgShow('系统提示', '请在一次输入密码！', 'warning');
                return false;
            }

            if ($newpass.val() != $rePass.val()) {
                msgShow('系统提示', '两次密码不一至！请重新输入', 'warning');
                return false;
            }
            var data = "username=" + $('#yonghu').val() + "password=" + $newpass.val();
            $.ajax({
            url:"${pageContext.request.contextPath}/staff/updatefrom.do",	
            data:data,
            success:function(data) {
            	$('#w').window('close');
                msgShow('系统提示', '恭喜，密码'+ data.msg, 'info');
            }
            })
            
        }

        $(function() {

            openPwd();

            $('#editpass').click(function() {
            	$('#txtNewPass').val('');
            	$('#txtRePass').val('');
                $('#w').window('open');
            });

            $('#btnEp').click(function() {
                serverLogin();
            })

			$('#btnCancel').click(function(){closePwd();})

            $('#loginOut').click(function() {
                $.messager.confirm('系统提示', '您确定要退出本次登录吗?', function(r) {

                    if (r) {
                        location.href = '/ajax/loginout.ashx';
                    }
                });
            })
        });
    </script>
</head>
<body class="easyui-layout" style="overflow-y: hidden"  scroll="no">
	<noscript>
	<div style=" position:absolute; z-index:100000; height:2046px;top:0px;left:0px; width:100%; background:white; text-align:center;">
		<img src="images/noscript.gif" alt='抱歉，请开启脚本支持！' />
	</div>
	</noscript>
    <div region="north" split="true" border="false" style="height:50px; background-image: url(${pageContext.request.contextPath}/images/bg_logo.jpg);"	>
		<span style="float:right; padding-right:20px;" class="head">
			欢迎<input id="yonghu" name="username" value="${dangqian}" disabled="disabled"/><a href="#" id="editpass">修改密码</a> <a href="${pageContext.request.contextPath}/auth/logout.do" id="loginOut">安全退出</a>
		</span>
        <span style="padding-left:10px; font-size: 16px; ">
			<img src="${pageContext.request.contextPath}/images/blocks.gif" width="20" height="20" align="absmiddle" />快学教育客户系统平台</img>
		</span>
	</div>
	
    <div region="south" split="true" style="height: 30px; background: #D2E0F2; "></div>
    <div region="west" hide="true" split="true" title="导航菜单" style="width:180px;" id="west">
		<div id="nav" class="easyui-accordion" fit="true" border="false">
			<!--  导航内容 -->
		</div>
    </div>
	
    <div id="mainPanle" region="center" style="background: #eee; overflow-y:hidden">
        <div id="tabs" class="easyui-tabs"  fit="true" border="false" >
			<div title="欢迎使用" style="padding:20px;overflow:hidden; color:red; " >
			</div>
		</div>
    </div>
    
    <!--修改密码窗口-->
    <div id="w" class="easyui-window" title="修改密码" collapsible="false" minimizable="false"
        maximizable="false" icon="icon-save"  style="width: 300px; height: 150px; padding: 5px;
        background: #fafafa;">
        <div class="easyui-layout" fit="true">
            <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
                <table cellpadding=3>
                    <tr>
                        <td>新密码：</td>
                        <td><input id="txtNewPass" type="password" class="txt01" /></td>
                    </tr>
                    <tr>
                        <td>确认密码：</td>
                        <td><input id="txtRePass" type="password" class="txt01" /></td>
                    </tr>
                </table>
            </div>
            <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
                <a id="btnEp" class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" >
                    确定</a> <a id="btnCancel" class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)">取消</a>
            </div>
        </div>
    </div>

	<div id="mm" class="easyui-menu" style="width:150px;">
		<div id="mm-tabupdate">刷新</div>
		<div class="menu-sep"></div>
		<div id="mm-tabclose">关闭</div>
		<div id="mm-tabcloseall">全系统关闭</div>
		<div id="mm-tabcloseother">除此之外全系统关闭</div>
		<div class="menu-sep"></div>
		<div id="mm-tabcloseright">当前页右侧全系统关闭</div>
		<div id="mm-tabcloseleft">当前页左侧全系统关闭</div>
		<div class="menu-sep"></div>
		<div id="mm-exit">退出</div>
	</div>
</body>
</html></html>