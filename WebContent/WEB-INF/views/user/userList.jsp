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
            <label>用户名称：</label><input id="search-name" class="wu-text" style="width:100px">
            <label>所属角色：</label>
             <select id="search-role" class="easyui-combobox" panelHeight="auto" style="width:120px">
            	<option value="-1">全部</option>
            	<c:forEach items="${roleList }" var="role">
            		<option value="${role.id }">${role.name }</option>
            	</c:forEach>
            </select>
             <label>性别:</label>
            <select id="search-sex" class="easyui-combobox" panelHeight="auto" style="width:120px">
            	<option value="-1">全部</option>
            	<option value="0">未知</option>
            	<option value="1">男</option>
            	<option value="2">女</option>
            </select>
            <a href="#" id="search-btn" class="easyui-linkbutton" iconCls="icon-search">搜索</a>
        </div>
    </div>
    <table id="data-datagrid" class="easyui-datagrid" toolbar="#wu-toolbar"></table>
 </div>   
<!-- 工具栏结束 -->


<!-- 新增角色弹窗 -->
<jsp:include page="addUser.jsp"></jsp:include>

<!-- 修改窗口 -->
<jsp:include page="editUser.jsp"></jsp:include>

<!-- 删除 -->
<jsp:include page="deleteUser.jsp"></jsp:include>


<script type="text/javascript">
	//搜索按钮监听,name与实体属性一致
	$("#search-btn").click(function(){
		$('#data-datagrid').datagrid('reload',{
			name:$("#search-name").val()
		});
	});
	
	//载入
	$('#data-datagrid').datagrid({
		url:'${path}/user/selectUser',
		rownumbers:true,
		singleSelect:false,
		pageSize:20,           
		pagination:true,
		multiSort:true,
		fitColumns:true,
		idField:'id',
	    treeField:'name',
		fit:true,
		columns:[[
					{ field:'chk',checkbox:true},
					{ field:'username',title:'用户名称',align:'center',width:$(this).width()*0.01,sortable:true},
					{ field:'password',title:'密码',align:'center',width:10,sortable:true},
					{ field:'roleId',title:'所属角色',align:'center',width:10,sortable:true,formatter:function(value,row,index){
						var roleList = $("#search-role").combobox('getData');
						for(var i=0;i<roleList.length;i++){
							if(value == roleList[i].value)return roleList[i].text;
						}
						return value;
					}},
					{ field:'age',title:'年龄',align:'center',width:10,sortable:true},
					{ field:'photo',title:'照片',align:'center',width:10,sortable:true},
					{ field:'address',title:'地址',align:'center',width:10,sortable:true},
					{ field:'sex',title:'性别',align:'center',width:10,sortable:true},
					
				]],
			});
</script>