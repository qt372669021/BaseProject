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
                <td width="60" align="right">菜单名称:</td>
                <td><input type="text" id="edit-name" name="name" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写菜单名称'" /></td>
            </tr>
            <tr>
                <td align="right">上级菜单:</td>
                <td>
                	<select id="edit-parentId" name="parentId" class="easyui-combobox" panelHeight="auto" style="width:268px">
		               	<option value="0">顶级分类</option>
		                <c:forEach items="${topMenu }" var="menu">
		                <option value="${menu.id }">${menu.name }</option>
		                </c:forEach>
		            </select>
                </td>
            </tr>
            <tr>
                <td align="right">菜单URL:</td>
                <td><input type="text" id="edit-url" name="url" class="wu-text" /></td>
            </tr>
            <tr>
                <td align="right">菜单图标:</td>
                <td>
                	<input type="text" id="edit-icon" name="icon" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写菜单图标'" />
                	<a href="#" class="easyui-linkbutton" iconCls="add-D2" onclick="selectIcon()" plain="true">选择</a>
                </td>
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
					url:'<%=request.getContextPath()%>/menu/edit',
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
	            onBeforeOpen:function(){//打开之前执行函数
	            	$("#edit-id").val(item.id);
	            	$("#edit-name").val(item.name);
	            	$("#edit-parentId").combobox('setValue',item.parentId);
	            	$("#edit-parentId").combobox('readonly',false);
	            	//判断是否是按钮
	            	var parent = $('#data-datagrid').treegrid('getParent',item.id);
	        		if(parent != null){
	        			if(parent.parentId != 0){//是按钮
	            			$("#edit-parentId").combobox('setText',parent.name);
	            			$("#edit-parentId").combobox('readonly',true);
	            		}
	        		}
	            	$("#edit-url").val(item.url);
	            	$("#edit-icon").val(item.icon);
	            }
	        });
	}	
				
				//打开图标弹窗口
				function selectIcon(){
					if($("#icons-table").children().length <= 0){//无数据时发请求
						$.ajax({
							url:'<%=request.getContextPath()%>/menu/get_icons',
							dataType:'json',
							type:'post',
							success:function(data){
								if(data.type == 'success'){
									var icons = data.content;
							//		console.log(icons); ["icon-accept", "icon-add"]
									var table = '';
									for(var i=0;i<icons.length;i++){
										var tbody = '<td class="icon-td"><a onclick="selected(this)" href="javascript:void(0)" class="' + icons[i] + '">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></td>';
										if(i == 0){
											table += '<tr>' + tbody;
											continue;
										}
										if((i+1)%24 === 0){
											//console.log(i + '---' + i%12);
											table += tbody + '</tr><tr>';
											continue;
										}
										table += tbody;
									}
									table += '</tr>';
									$("#icons-table").append(table);
								}else{
									$.messager.alert('信息提示',data.msg,'warning');
								}
							}
						});
					}
					
					$('#select-icon-dialog').dialog({
						closed: false,
						modal:true,
			            title: "选择icon信息",
			            buttons: [{
			                text: '确定',
			                iconCls: 'icon-ok',
			                handler: function(){
			                	var icon = $(".selected a").attr('class');
			                	$("#add-icon").val(icon);
			                	$("#edit-icon").val(icon);
			                	$("#add-menu-icon").val(icon);
			                	$('#select-icon-dialog').dialog('close'); 
			                }
			            }, {
			                text: '取消',
			                iconCls: 'icon-cancel',
			                handler: function () {
			                    $('#select-icon-dialog').dialog('close');                    
			                }
			            }]
			        });
				}
				
				function selected(e){
					$(".icon-td").removeClass('selected');
					$(e).parent("td").addClass('selected');
				}
	</script>