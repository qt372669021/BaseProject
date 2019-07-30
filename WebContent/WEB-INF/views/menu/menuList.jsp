<%@ page language="java" contentType="text/html; charset=Utf-8"  pageEncoding="Utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="easyui-layout" data-options="fit:true">
    <!-- 工具栏 -->
    <div id="wu-toolbar">
        <div class="wu-toolbar-button">
            <a href="#" class="easyui-linkbutton" iconCls="icon-adD2" onclick="openAdd()" plain="true">添加</a>
            <a href="#" class="easyui-linkbutton" iconCls="delete_D2" onclick="remove()" plain="true">删除</a>
            <a href="#" class="easyui-linkbutton" iconCls="edit_D2" onclick="openEdit()" plain="true">修改</a>
            <a href="#" class="easyui-linkbutton" iconCls="icon-adD2" onclick="openAddButtonMenu()" plain="true">添加按钮</a>
        </div>
      <div class="wu-toolbar-search">
            <label>菜单名称：</label><input id="search-name" class="wu-text" style="width:100px">
            <a href="#" id="search-btn" class="easyui-linkbutton" iconCls="icon-search">搜索</a>
        </div>
    </div>
    <table id="data-datagrid" class="easyui-treegrid" toolbar="#wu-toolbar"></table>
</div>
<!-- 工具栏结束 -->


<!-- 选择图标弹窗(新增、修改) -->
<div id="select-icon-dialog" class="easyui-dialog" data-options="closed:true,iconCls:'icon-save'" style="width:820px;height:550px; padding:10px;">
     <table id="icons-table" cellspacing="8"> </table>
</div>
<style>
	.selected {
		background:red;
	}
</style>

<!-- 新增菜单信息弹窗 -->
<jsp:include page="addMenu.jsp"></jsp:include>
<!-- 修改窗口 -->
<jsp:include page="editMenu.jsp"></jsp:include>
<!-- 删除 -->
<jsp:include page="deleteMenu.jsp"/>

<!-- 添加按钮弹窗 -->
<jsp:include page="addButtonMenu.jsp"></jsp:include>

<script type="text/javascript">
	//搜索按钮监听
	$("#search-btn").click(function(){
		$('#data-datagrid').treegrid('reload',{
			name:$("#search-name").val()
		});
	});
	
	//载入数据
	$('#data-datagrid').treegrid({
		url:'<%=request.getContextPath()%>/menu/selectMenuList',
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
			{ field:'name',title:'菜单名称',width:100,sortable:true},
			{ field:'url',title:'菜单URL',width:100,sortable:true},
			{ field:'icon',title:'图标icon',width:100,formatter:function(value,index,row){
				var test = '<a class="' + value + '">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>'
				return test + value;
			}},
		]]
	});
</script>