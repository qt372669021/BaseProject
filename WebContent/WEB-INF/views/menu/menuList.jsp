<%@ page language="java" contentType="text/html; charset=Utf-8"  pageEncoding="Utf-8"%>
<div class="easyui-layout" data-options="fit:true">
    <!-- 工具栏 -->
    <div id="wu-toolbar">
        <div class="wu-toolbar-button">
            <a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="openAdd()" plain="true">添加</a>
            <a href="#" class="easyui-linkbutton" iconCls="icon-remove" onclick="remove()" plain="true">删除</a>
            <a href="#" class="easyui-linkbutton" iconCls="icon-edit" onclick="openEdit()" plain="true">修改</a>
        </div>
        <div class="wu-toolbar-search">
            <label>菜单名称：</label><input id="search-name" class="wu-text" style="width:100px">
            <a href="#" id="search-btn" class="easyui-linkbutton" iconCls="icon-search">搜索</a>
        </div>
    </div>
    <table id="data-datagrid" class="easyui-datagrid" toolbar="#wu-toolbar"></table>
</div>

<!-- 新增 -->
<jsp:include   page="addMenu.jsp" 	 flush="true"/>
<!-- 修改 -->
<jsp:include   page="editMenu.jsp" 	 flush="true"/>
<!-- 删除 -->
<jsp:include   page="deleteMenu.jsp" flush="true"/>

<script type="text/javascript">
	
	//搜索按钮监听
	$("#search-btn").click(function(){
		$('#data-datagrid').treegrid('reload',{name:$("#search-name").val()});
	});


	//载入数据
	$('#data-datagrid').datagrid({
		url:'<%=request.getContextPath()%>/menu/selectMenuList',
		rownumbers:true,
		singleSelect:false,
		pageSize:20,           
		pagination:true,
		multiSort:true,
		fitColumns:true,
		fit:true,
		columns:[[
		      	{ field:'name',title:'菜单名称',width:100,sortable:true},//这一行就是treeField定义的树节点的列
				{ field:'url',title:'菜单URL',width:100,sortable:true},
				{ field:'icon',title:'图标icon',width:100,
					formatter:function(value,index,row){
					var test = '<a class="' + value + '">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>'
					return test + value;
				}},
		]]
	});
	
</script>