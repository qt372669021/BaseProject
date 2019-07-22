<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		                	<select name="parentId" class="easyui-combobox" panelHeight="auto" style="width:268px">
				                <option value="0">选择用户组</option>
				                <c:forEach items="${topMenu }" var="menu"> 
				                	<option value="${menu.id }">${menu.name}</option>
				                </c:forEach>
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
					var data = $("#edit-form").serialize();
					$('#edit-form').form('submit', {
						url:'<%=request.getContextPath()%>/menu/editMenu',
						dataType:'json',
						type:'post',
						data:data,
						success:function(data){
							if(data.code=200){
								$.messager.alert('信息提示','提交成功！','info');
								$('#edit-dialog').dialog('close');
							}else{
								$.messager.alert('信息提示',data.msg,'info');
							}
						}
					});
				}
	

				/**
				* Name 打开修改窗口
				*/
				function openEdit(){
					var item = $('#data-datagrid').treegrid('getSelected');//选中行
					if(item == null || item.length == 0){
						$.messager.alert('信息提示','请选择要修改的数据！','info');
						return;
					}
					
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
			            onBeforeOpen:function(){//打开之后触发
			            	$("#edit-id").val(item.id);
			            	$("#edit-name").val(item.name);//将选中行数据赋值给相对应的字段
			            	$("#edit-parentId").combobox('setValue',item.parentId);
			            	$("#edit-parentId").combobox('readonly',false);
			            	//判断是否是按钮
			            	var parent = $('#data-datagrid').treegrid('getParent',item.id);
			        		if(parent != null){
			        			if(parent.parentId != 0){
			            			$("#edit-parentId").combobox('setText',parent.name);
			            			$("#edit-parentId").combobox('readonly',true);
			            		}
			        		}
			            	
			            	$("#edit-url").val(item.url);
			            	$("#edit-icon").val(item.icon);
			            }
			        });
				}	
	</script>