<%@ page language="java" contentType="text/html; charset=Utf-8"  pageEncoding="Utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% pageContext.setAttribute("path", request.getContextPath()); %>
<div class="easyui-layout" data-options="fit:true">
    <!-- 工具栏 -->
    <div id="wu-toolbar">
        <div class="wu-toolbar-button">
            <a href="#" class="easyui-linkbutton" iconCls="icon-adD2" onclick="openAdd()" plain="true">添加</a>
            <a href="#" class="easyui-linkbutton" iconCls="delete_D2" onclick="remove()" plain="true">删除</a>
            <a href="#" class="easyui-linkbutton" iconCls="edit_D2" onclick="openEdit()" plain="true">修改</a>
        </div>
      <div class="wu-toolbar-search">
            <label>菜单名称：</label><input id="search-name" class="wu-text" style="width:100px">
            <a href="#" id="search-btn" class="easyui-linkbutton" iconCls="icon-search">搜索</a>
        </div>
    </div>
    <table id="data-datagrid" class="easyui-datagrid" toolbar="#wu-toolbar"></table>
 </div>   
<!-- 工具栏结束 -->


<!-- 新增角色弹窗 -->
<jsp:include page="addRole.jsp"></jsp:include>

<!-- 修改窗口 -->
<jsp:include page="editRole.jsp"></jsp:include>

<!-- 删除 -->
<jsp:include page="deleteRole.jsp"></jsp:include>

<!-- 选择权限弹窗 -->
<jsp:include page="authority.jsp"></jsp:include>

<script type="text/javascript">
	//搜索按钮监听,name与实体属性一致
	$("#search-btn").click(function(){
		$('#data-datagrid').datagrid('reload',{
			name:$("#search-name").val()
		});
	});
	
	//载入
	$('#data-datagrid').datagrid({
		url:'${path}/role/selectRoleList',
		rownumbers:true,
		singleSelect:true,
		pageSize:20,           
		pagination:true,
		multiSort:true,
		fitColumns:true,
		idField:'id',
	    treeField:'name',
		fit:true,
		columns:[[
					{ field:'chk',checkbox:true},
					{ field:'name',title:'角色名称',align:'center',width:$(this).width()*0.01,sortable:true},
					{ field:'remark',title:'角色备注',align:'center',width:10,sortable:true},
					{ field:'icon',title:'权限操作',width:$(this).width()*0.01,formatter:function(value,row,index){
						var test = '<a class="authority-edit" onclick="selectAuthority('+row.id+')"></a>'
						return test;
					}},
				]],
				onLoadSuccess:function(data){  
					$('.authority-edit').linkbutton({text:'编辑权限',plain:true,iconCls:'edit_D2'});  
				 }  
			});
</script>