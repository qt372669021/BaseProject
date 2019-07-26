<%@ page language="java" contentType="text/html; charset=Utf-8"  pageEncoding="Utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 新增角色弹窗 -->
<div id="add-dialog" class="easyui-dialog" data-options="closed:true,iconCls:'icon-save'" style="width:450px; padding:10px;">
	<form id="add-form" method="post">
        <table>
            <tr>
                <td width="60" align="right">角色名称:</td>
                <td><input type="text" name="name" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写菜单名称'" /></td>
            </tr>
            <tr>
                <td align="right">备注</td>
                <td><input type="text" name="remark" class="wu-text" /></td>
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
		console.log(111);
		$.ajax({
			url:'<%=request.getContextPath()%>/role/addRole',//把请求发送到哪个 URL
			dataType:'json',//可选。规定预期的服务器响应的数据类型。
			type:'post',
			data:vdata,//可选，data是json字符串,请求发送到服务器的数据,data主要方式有三种，html拼接的，json数组，form表单经serialize()序列化的；通过dataType指定，不指定智能判断
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
            title: "添加菜单信息",
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