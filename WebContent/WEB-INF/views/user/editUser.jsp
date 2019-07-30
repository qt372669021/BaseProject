<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!-- 修改窗口 -->
<div id="edit-dialog" class="easyui-dialog" data-options="closed:true,iconCls:'icon-save'" style="width:450px; padding:10px;">
	<form id="edit-form" method="post">
	<!-- 通过主键修改 -->
        <input type="hidden" name="id" id="edit-id">
        <table>
            <tr>
                <td width="60" align="right">用户名称:</td>
                <td><input type="text" name="username" id="edit-username" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写菜单名称'" /></td>
            </tr>
            <tr>
                <td width="60" align="right">密码:</td>
                <td><input type="password" name="password" id="edit-password" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写密码'" /></td>
            </tr>
            <tr>
	             <td width="30" align="right">所属角色:</td>
	             <td>
		             <select id="edit-roleId" name="roleId" class="easyui-combobox" panelHeight="auto" style="width:268px">
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
		             <select id="edit-sex" class="easyui-combobox" panelHeight="auto" style="width:268px">
		            	<option value="-1">全部</option>
		            	<option value="0">未知</option>
		            	<option value="1">男</option>
		            	<option value="2">女</option>
		            </select>
            	 </td>
            </tr>
            <tr>
                <td align="right">照片</td>
                <td><input type="text" name="photo" id="edit-photo" class="wu-text" /></td>
            </tr>
            <tr>
                <td align="right">年龄</td>
                <td><input type="text" name="age" id="edit-age" class="wu-text easyui-numberbox easyui-validatebox" data-options="required:true,min:1,precision:0, missingMessage:'请填写年龄'"/></td>
            </tr>
            <tr>
                <td align="right">地址</td>
                <td><input type="text" name="address"  id="edit-address" class="wu-text" /></td>
            </tr>
        </table>
    </form>
</div>
<script>
		//修改记录
		function edit(){
				var validate = $("#edit-form").form("validate");
				if(!validate){
					$.messager.alert("消息提醒","请检查你输入的数据!","warning");
					return;
				}
				var dataEdit = $("#edit-form").serialize();
				$.ajax({
					url:'<%=request.getContextPath()%>/user/editUser',
					dataType:'json',
					type:'post',
					data:dataEdit,
					success:function(data){
						if(data.code == 200){
							$.messager.alert('信息提示','修改成功！','info');
							$('#edit-dialog').dialog('close');
							$('#data-datagrid').treegrid('reload');
						}else{
							$.messager.alert('信息提示',data.msg,'warning');
						}
					}
				});
			}
	

		//打开修改窗口
		function openEdit(){
			var item = $('#data-datagrid').datagrid('getSelections');
			if(item == null || item.length == 0){
				$.messager.alert('信息提示','请选择要修改的数据！','info');
				return;
			}
			if(item.length > 1){
				$.messager.alert('信息提示','请选择一条数据进行修改！','info');
				return;
			}
			item = item[0];
			$('#edit-dialog').dialog({
				closed: false,
				modal:true,
	            title: "修改信息",
	            buttons: [{
	                text: '确定',
	                iconCls: 'icon-ok',
	                handler: edit
	            }, {
	                text: '取消',
	                iconCls: 'icon-cancel',
	                handler: function () {
	                    $('#edit-dialog').dialog('close');                    
	                }
	            }],
	            onBeforeOpen:function(){
	            	
	            }
	        });
	}	
				
	</script>