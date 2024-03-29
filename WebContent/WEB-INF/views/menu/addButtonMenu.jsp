<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- 添加按钮弹窗 -->
<div id="add-menu-dialog" class="easyui-dialog" data-options="closed:true,iconCls:'icon-save'" style="width:450px; padding:10px;">
	<form id="add-menu-form" method="post">
        <table>
            <tr>
                <td width="60" align="right">按钮名称:</td>
                <td><input type="text" name="name" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写菜单名称'" /></td>
            </tr>
            <tr>
                <td align="right">上级菜单:</td>
                <td>
                	<input type="hidden" name="parentId" id="add-menu-parent-id">
                	<input type="text" readonly="readonly" id="parent-menu" class="wu-text easyui-validatebox" />
                </td>
            </tr>
            <tr>
                <td align="right">按钮事件:</td>
                <td><input type="text" name="url" class="wu-text" /></td>
            </tr>
            <tr>
                <td align="right">按钮图标:</td>
                <td>
                	<input type="text" id="add-menu-icon" name="icon" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写菜单图标'" />
                	<a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="selectIcon()" plain="true">选择</a>
                </td>
            </tr>
        </table>
    </form>
</div>
		
		
<script type="text/javascript">

	//添加按钮事件
	function openAddButtonMenu(){
		var item = $('#data-datagrid').treegrid('getSelected');//选中行
		if(item == null || item.length == 0){
			$.messager.alert('信息提示','请选择菜单！','info');
			return;
		}
		if(item.parentId==0){
			$.messager.alert('信息提示','请选择二级菜单！','info');
			return;
		}
		//获取选中行的父节点
		var parent = $('#data-datagrid').treegrid('getParent',item.id);
		if(parent.parentId != 0){
			$.messager.alert('信息提示','请选择二级菜单！','info');
			return;
		}
		
		$('#add-menu-dialog').dialog({
			closed: false,
			modal:true,
            title: "添加按钮信息",
            buttons: [{
                text: '确定',
                iconCls: 'icon-ok',
                handler: function(){
                	var validate = $("#add-menu-form").form("validate");
                	if(!validate){
                		$.messager.alert("消息提醒","请检查你输入的数据!","warning");//弹框
                		return;
                	}
                	var vdata = $("#add-menu-form").serialize();///序列化表格内容为字符串,k:v,格式
                	$.ajax({
                		url:'<%=request.getContextPath()%>/menu/add',//把请求发送到哪个 URL
                		dataType:'json',//可选。规定预期的服务器响应的数据类型。
                		type:'post',
                		data:vdata,//可选，data是json字符串,请求发送到服务器的数据,data主要方式有三种，html拼接的，json数组，form表单经serialize()序列化的；通过dataType指定，不指定智能判断
                		success:function(data){//可选，请求成功时执行的回调函数
                			if(data.code == 200){
                				$.messager.alert('信息提示','添加成功！','info');
                				$('#add-menu-dialog').dialog('close');
                				$('#data-datagrid').treegrid('reload');
                			}else{
                				$.messager.alert('信息提示',data.msg,'warning');
                			}
                		}
                	});
                }
            }, {
                text: '取消',
                iconCls: 'icon-cancel',
                handler: function () {
                    $('#add-menu-dialog').dialog('close');                    
                }
            }],
            onBeforeOpen:function(){
            	$("#parent-menu").val(item.name);
            	$("#add-menu-parent-id").val(item.id);
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
