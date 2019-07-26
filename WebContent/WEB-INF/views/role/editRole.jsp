<%@ page language="java" contentType="text/html; charset=Utf-8"  pageEncoding="Utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 修改窗口 -->
<div id="edit-dialog" class="easyui-dialog" data-options="closed:true,iconCls:'icon-save'" style="width:400px; padding:10px;">
	<form id="edit-form" method="post">
        <input type="hidden" name="id" id="edit-id">
        <table>
            <tr>
                <td width="60" align="right">角色名称:</td>
                <td><input type="text" id="edit-name" name="name" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写菜单名称'" /></td>
            </tr>
            <tr>
                <td align="right">备注:</td>
                <td><input type="text" id="edit-remark" name="remark" class="wu-text" /></td>
            </tr>
        </table>
    </form>
</div>

<script type="text/javascript">
function edit(){
	var validate = $("#edit-form").form("validate");
	if(!validate){
		$.messager.alert("消息提醒","请检查你输入的数据!","warning");
		return;
	}
	var data = $("#edit-form").serialize();
	$.ajax({
		url:'<%=request.getContextPath()%>/role/editRole',
		dataType:'json',
		type:'post',
		data:data,
		success:function(data){
			if(data.code == 200){
				$.messager.alert('信息提示','修改成功！','info');
				$('#edit-dialog').dialog('close');
				$('#data-datagrid').datagrid('reload');
			}else{
				$.messager.alert('信息提示',data.msg,'warning');
			}
		}
	});
}
//修改窗口
function openEdit(){
	var item = $('#data-datagrid').datagrid('getSelected');
	if(item == null || item.length == 0){
		$.messager.alert('信息提示','请选择要修改的数据！','info');
		return;
	}
	
	$('#edit-dialog').dialog({
		closed: false,
		modal:true,//模态框
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
        	$("#edit-id").val(item.id);
        	$("#edit-name").val(item.name);
        	$("#edit-remark").val(item.remark);
        }
    });
}	
	
</script>