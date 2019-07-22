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

<!-- 新增菜单信息弹窗 -->
<div id="add-dialog" class="easyui-dialog" data-options="closed:true,iconCls:'icon-save'" style="width:450px; padding:10px;">
	<form id="add-form" method="post">
        <table>
            <tr>
                <td width="60" align="right">菜单名称:</td>
                <td><input type="text" name="name" class="wu-text easyui-validatebox" data-options="required:true, missingMessage:'请填写菜单名称'" /></td>
            </tr>
            <tr>
                <td align="right">上级菜单:</td>
                <td>
                	<select name="parentId" class="easyui-combobox" panelHeight="auto" style="width:268px">
		                <option value="0">--</option>
		                <c:forEach items="${topMenu }" var="menu">
		                <option value="${menu.id }">${menu.name }</option>
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

<!-- 修改窗口 -->
<div id="edit-dialog" class="easyui-dialog" data-options="closed:true,iconCls:'icon-save'" style="width:450px; padding:10px;">
	<form id="edit-form" method="post">
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
                	<a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="selectIcon()" plain="true">选择</a>
                </td>
            </tr>
        </table>
    </form>
</div>

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

<!-- 选择图标弹窗 -->
<div id="select-icon-dialog" class="easyui-dialog" data-options="closed:true,iconCls:'icon-save'" style="width:820px;height:550px; padding:10px;">
     <table id="icons-table" cellspacing="8">  </table>
</div>
<!-- End of easyui-dialog -->
<script type="text/javascript">
	/**
	*  添加记录
	validate：验证表单内容是否填写
	*/
	function add(){
		var validate = $("#add-form").form("validate");
		if(!validate){
			$.messager.alert("消息提醒","请检查你输入的数据!","warning");//弹框
			return;
		}
		//序列化表单内容为字符串(k:v格式),用于Ajax请求
		var vdata = $("#add-form").serialize();///序列化表格内容为字符串,k:v,格式
		$.ajax({
			url:'<%=request.getContextPath()%>/menu/add',//把请求发送到哪个 URL
			dataType:'json',//可选。规定预期的服务器响应的数据类型。
			type:'post',
			data:vdata,//可选，data是json字符串,请求发送到服务器的数据,data主要方式有三种，html拼接的，json数组，form表单经serialize()序列化的；通过dataType指定，不指定智能判断
			success:function(data){//可选，请求成功时执行的回调函数
				if(data.type == 'success'){
					$.messager.alert('信息提示','添加成功！','info');
					$('#add-dialog').dialog('close');
					$('#data-datagrid').treegrid('reload');
				}else{
					$.messager.alert('信息提示',data.msg,'warning');
				}
			}
		});
	}
	
	//菜单图标 事件
	function selectIcon(){
		if($("#icons-table").children().length <= 0){
			$.ajax({
				url:'<%=request.getContextPath()%>/menu/get_icons',
				dataType:'json',
				type:'post', 
				success:function(data){
					if(data.type == 'success'){
						var icons = data.content;
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
	
	/**
	* Name 修改记录
	*/
	function edit(){
		var validate = $("#edit-form").form("validate");
		if(!validate){
			$.messager.alert("消息提醒","请检查你输入的数据!","warning");
			return;
		}
		var data = $("#edit-form").serialize();
		$.ajax({
			url:'<%=request.getContextPath()%>/menu/edit',
			dataType:'json',
			type:'post',
			data:data,
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
	
	/**
	* 删除记录
	*/
	function remove(){
		$.messager.confirm('信息提示','确定要删除该记录？', function(result){
			if(result){
				var item = $('#data-datagrid').datagrid('getSelected');
				$.ajax({
					url:'<%=request.getContextPath()%>/menu/delete',
					dataType:'json',
					type:'post',
					data:item,
					success:function(data){
						if(data.code == 200){
							$.messager.alert('信息提示','删除成功！','info');
							$('#data-datagrid').treegrid('reload');
						}else{
							$.messager.alert('信息提示',data.msg,'warning');
						}
					}
				});
			}	
		});
	}
	
	//添加按钮弹框
	function openAddMenu(){
		//$('#add-form').form('clear');
		var item = $('#data-datagrid').treegrid('getSelected');
		if(item == null || item.length == 0){
			$.messager.alert('信息提示','请选择要添加菜单的数据！','info');
			return;
		}
		if(item.parentId == 0){
			$.messager.alert('信息提示','请选择二级菜单！','info');
			return;
		}
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
            			$.messager.alert("消息提醒","请检查你输入的数据!","warning");
            			return;
            		}
            		var data = $("#add-menu-form").serialize();
            		$.ajax({
            			url:'add',
            			dataType:'json',
            			type:'post',
            			data:data,
            			success:function(data){
            				if(data.type == 'success'){
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
            	$("#parent-menu").val(item.name);//给上级菜单赋值
            	$("#add-menu-parent-id").val(item.id);
            }
        });
	}
	
	/**
	* Name 打开添加窗口
	*/
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
	
	/**
	* 打开修改窗口
	*/
	function openEdit(){
		//$('#edit-form').form('clear');
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
	
	
	//搜索按钮监听
	$("#search-btn").click(function(){
		$('#data-datagrid').treegrid('reload',{
			name:$("#search-name").val()
		});
	});
	
	/** 
	* 载入数据
	*/
	$('#data-datagrid').treegrid({
		url:'<%=request.getContextPath()%>/menu/selectMenuList',
		rownumbers:true,//显示行号
		singleSelect:true,//不要多选
		pageSize:20,           
		pagination:true,//分页
		multiSort:true,
		fitColumns:true,
		idField:'id',
	    treeField:'name',  //定义树节点的字段
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