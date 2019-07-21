<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<style>
.selected{
	background:red;
}
</style>
		<!-- 新增窗口 -->
		<div id="add-dialog" class="easyui-dialog" data-options="closed:true,iconCls:'icon-save'" style="width:450px; padding:10px;">
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
				                <c:forEach items="${topMenu }" var="menu"> 
				                	<option value="${menu.id }">${menu.name}</option>
				                </c:forEach>
			            	</select>
		            	</td>
		            </tr>
		            <tr>
		                <td align="right">菜单URL:</td>
		                <td><input type="text" name="url" class="wu-text" /></td>
		            </tr>
		            
		            <tr>
			                <td align="right">菜单图标:</td>
			                <td>
			                	<input type="text" id="add-icon" name="icon" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写菜单图标'" />
			                	<a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="selectIcon()" plain="true">选择</a>
			                </td>
		            </tr>
		        </table>
		    </form>
		</div>
		
		<!-- 选择图标弹窗 -->
		<div id="select-icon-dialog" class="easyui-dialog" data-options="closed:true,iconCls:'icon-save'" style="width:820px; height:550px;   padding:10px;">
			  <table id="icons-table" cellspacing="8"> </table>
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
                	console.log(icon);
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
