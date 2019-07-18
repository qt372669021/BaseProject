<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
		<!-- 新增窗口 -->
		<div id="add-dialog" class="easyui-dialog" data-options="closed:true,iconCls:'icon-save'" style="width:400px; padding:10px;">
			<form id="add-form" method="post">
		        <table>
		            <tr>
		                <td width="60" align="right">菜单名称：</td>
		                <td><input type="text" name="name"  class="wu-text easyui-validatebox"  /></td>
		            </tr>
		            <tr>
		                <td align="right">上级菜单：</td>
		                <td>
		                	<select name="parentId" class="easyui-combobox" panelHeight="auto" style="width:268px">
				                <option value="0">选择用户组</option>
				                <option value="1">黄钻</option>
				                <option value="2">红钻</option>
				                <option value="3">蓝钻</option>
			            	</select>
		            	</td>
		            </tr>
		            <tr>
		                <td align="right">菜单URL:</td>
		                <td><input type="text" name="url" class="wu-text" /></td>
		            </tr>
		            <tr>
		                <td valign="top" align="right">菜单图标:</td>
		                <td><input type="text" name="icon" class="wu-text" /></td>
		            </tr>
		        </table>
		    </form>
		</div>
		
		
	<script type="text/javascript">
	//添加记录
	function add(){
		var validate = $("#add-form").form("validate");
		console.log(validate);
		if(!validate){
			$.messager.alert("消息提醒","请检查你输入的数据!","warning");//弹框
			return;
		}
		//序列化表单内容为字符串(k:v格式),用于Ajax请求
		var vdata = $("#add-form").serialize();
		$.ajax({
			url:'<%=request.getContextPath()%>/menu/add',
			dataType:'json',
			type:'post',
			data:vdata,
			success:function(data){
				if(data.code ==200){
					$.messager.alert('信息提示','新增成功！','info');
					$('#add-dialog').dialog('close');
					$('#data-datagrid').treegrid('reload');
				}else{
					console.log(data.code);
					$.messager.alert('信息提示',data.msg,'warning');
				}
			},
			error:function(jqXHR, textStatus, errorThrown){
				$.messager.alert('信息提示','请联系管理员','warning');
			}
		});
	}
	
	//打开添加窗口
	function openAdd(){
		$('#add-form').form('clear');
		$('#add-dialog').dialog({
			closed: false,
			modal:true,
            title: "添加信息",
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
