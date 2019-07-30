<%@ page language="java" contentType="text/html; charset=Utf-8"  pageEncoding="Utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 新增用户弹窗 -->
<div id="add-dialog" class="easyui-dialog" data-options="closed:true,iconCls:'icon-save'" style="width:450px; padding:10px;">
	<form id="add-form" method="post">
        <table>
            <tr>
                <td width="60" align="right">用户名称:</td>
                <td><input type="text" name="username" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写菜单名称'" /></td>
            </tr>
            <tr>
                <td width="60" align="right">密码:</td>
                <td><input type="password" name="password" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写密码'" /></td>
            </tr>
            <tr>
	             <td width="30" align="right">所属角色:</td>
	             <td>
		             <select id="roleId" name="roleId" class="easyui-combobox" panelHeight="auto" style="width:268px">
		            	<option value="-1">全部</option>
		            	<c:forEach items="${roleList }" var="role">
		            		<option value="${role.id }">${role.name }</option>
		            	</c:forEach>
		            </select>
	            </td>
            </tr>
            <tr>
            	 <td width="30" align="right">性别:</td>
	             <td>
		             <select id="sex" class="easyui-combobox" panelHeight="auto" style="width:268px">
		            	<option value="-1">全部</option>
		            	<option value="0">未知</option>
		            	<option value="1">男</option>
		            	<option value="2">女</option>
		            </select>
            	 </td>
            </tr>
            <tr>
                <td align="right">照片</td>
                <td><input type="text" name="photo" class="wu-text" /></td>
            </tr>
            <tr>
                <td align="right">年龄</td>
                <td><input type="text" name="age" class="wu-text easyui-numberbox easyui-validatebox" data-options="required:true,min:1,precision:0, missingMessage:'请填写年龄'"/></td>
            </tr>
            <tr>
                <td align="right">地址</td>
                <td><input type="text" name="address" class="wu-text" /></td>
            </tr>
        </table>
    </form>
</div>

<script type="text/javascript">
	//添加记录
	function add(){
		var validate = $("#add-form").form("validate");
		if(!validate){
			$.messager.alert("消息提醒","请检查你输入的数据!","warning");//弹框
			return;
		}
		//序列化表单内容为字符串(k:v格式),用于Ajax请求
		var vdata = $("#add-form").serialize();///序列化表格内容为字符串,k:v,格式
		console.log(vdata);
		$.ajax({
			url:'<%=request.getContextPath()%>/user/addUser',//把请求发送到哪个 URL
			dataType:'json',//可选。规定预期的服务器响应的数据类型。
			type:'post',
			data:vdata,
			success:function(data){//可选，请求成功时执行的回调函数
				if(data.code == 200){
					$.messager.alert('信息提示','添加成功！','info');
					$('#add-dialog').dialog('close');
					$('#data-datagrid').datagrid('reload');
				}else{
					$.messager.alert('信息提示',data.msg,'warning');
				}
			}
		});
	}
	//打开窗口
	function openAdd(){
		$('#add-dialog').dialog({
			closed: false,
			modal:true,
            title: "添加用户信息",
            buttons: [{
                text: '确定',
                iconCls: 'icon-ok',
                handler: add
            }, {
                text: '取消',
                iconCls: 'icon-cancel',
                handler: function () {
                    $('#add-dialog').dialog('close');                    
                }
            }]
        });
	}
	
</script>