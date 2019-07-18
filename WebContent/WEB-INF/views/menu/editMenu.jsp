<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<!-- 修改窗口 -->
	<div id="edit-dialog" class="easyui-dialog" data-options="closed:true,iconCls:'icon-save'" style="width:400px; padding:10px;">
		<form id="edit-form" method="post">
	        <table>
	            <tr>
	                <td width="60" align="right">菜单名称：</td>
	                <td><input type="text" name="name" class="wu-text" /></td>
	            </tr>
	            <tr>
	                <td align="right">上级菜单：</td>
	                <td>
		                <select class="easyui-combobox" panelHeight="auto" style="width:100px">
			                <option value="0">选择用户组</option>
			                <option value="1">黄钻</option>
			                <option value="2">红钻</option>
			                <option value="3">蓝钻</option>
		            	</select>
	            	</td>
	            </tr>
	            <tr>
	                <td align="right">菜单URL:</td>
	                <td><input type="text" name="subject" class="wu-text" /></td>
	            </tr>
	            <tr>
	                <td valign="top" align="right">菜单图标:</td>
	                <td><input type="text" name="icon" class="wu-text" /></td>
	            </tr>
	        </table>
	    </form>
	</div>
	<script>
				/**
				* Name 修改记录
				*/
				function edit(){
					$('#edit-form').form('submit', {
						url:'',
						success:function(data){
							if(data){
								$.messager.alert('信息提示','提交成功！','info');
								$('#edit-dialog').dialog('close');
							}
							else
							{
								$.messager.alert('信息提示','提交失败！','info');
							}
						}
					});
				}
	

				/**
				* Name 打开修改窗口
				*/
				function openEdit(){
					$('#edit-form').form('clear');
					var item = $('#edit-datagrid').datagrid('getSelected');
					$.ajax({
						url:'',
						data:'',
						success:function(data){
							if(data){
								$('#edit-dialog').dialog('close');	
							}
							else{
								//绑定值
								$('#edit-form').form('load', data)
							}
						}	
					});
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
			            }]
			        });
				}	
	</script>