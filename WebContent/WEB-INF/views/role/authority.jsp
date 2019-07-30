<%@ page language="java" contentType="text/html; charset=Utf-8"  pageEncoding="Utf-8"%>

<!-- 权限弹窗 -->
<div id="select-authority-dialog" class="easyui-dialog" data-options="closed:true,iconCls:'icon-save'" style="width:230px;height:450px; padding:10px;">
     <ul id="authority-tree" url="<%=request.getContextPath()%>/authority/getMenuList" checkbox="true"></ul>
</div>

<script type="text/javascript">


//某个角色已经拥有的权限
var existAuthority = null;
function isAdded(row,rows){
	for(var k=0;k<existAuthority.length;k++){
		if(existAuthority[k].menuId == row.id && haveParent(rows,row.parentId)){
			//console.log(existAuthority[k].menuId+'---'+row.parentId);
			return true;
		}
	}
	return false;
}

//判断是否有父分类

function haveParent(rows,parentId){
	for(var i=0; i<rows.length; i++){
		if (rows[i].id == parentId){
			if(rows[i].parentId != 0) return true;
		}
	}
	return false;
}

//判断是否有父类
function exists(rows, parentId){
	for(var i=0; i<rows.length; i++){
		if (rows[i].id == parentId) return true;
	}
	return false;
}

//转换原始数据至符合tree的要求
function convert(rows){
	var nodes = [];
	// get the top level nodes
	//首先获取所有的父分类
	for(var i=0; i<rows.length; i++){
		var row = rows[i];
		if (!exists(rows, row.parentId)){
			nodes.push({
				id:row.id,
				text:row.name
			});
		}
	}
	
	var toDo = [];
	for(var i=0; i<nodes.length; i++){
		toDo.push(nodes[i]);
	}
	while(toDo.length){
		var node = toDo.shift();	// the parent node
		// get the children nodes
		for(var i=0; i<rows.length; i++){
			var row = rows[i];
			if (row.parentId == node.id){
				var child = {id:row.id,text:row.name};
				if(isAdded(row,rows)){
					child.checked = true;
				}
				if (node.children){
					node.children.push(child);
				} else {
					node.children = [child];
				}
				//把刚才创建的孩子再添加到父分类的数组中
				toDo.push(child);
			}
		}
	}
	return nodes;
}

//打开权限选择框
function selectAuthority(roleId){
	$('#select-authority-dialog').dialog({
		closed: false,
		modal:true,
        title: "选择权限信息",
        buttons: [{
            text: '确定',
            iconCls: 'icon-ok',
            handler: function(){
            	var checkedNodes = $("#authority-tree").tree('getChecked');//获取勾选的，排除上级的
            	var ids = '';
            	for(var i=0;i<checkedNodes.length;i++){
            		ids += checkedNodes[i].id + ',';
            	}
            	var checkedParentNodes = $("#authority-tree").tree('getChecked', 'indeterminate');//获取勾选上级，排除本身；
            	for(var i=0;i<checkedParentNodes.length;i++){
            		ids += checkedParentNodes[i].id + ',';
            	}
            	//console.log(ids);
            	if(ids != ''){
            		
            		$.ajax({
            			url:'<%=request.getContextPath()%>/authority/addAuthority',
            			type:"post",
            			data:{ids:ids,roleId:roleId},
            			dataType:'json',
            			success:function(data){
            				if(data.code == 200){
            					$.messager.alert('信息提示','权限编辑成！','info');
            					$('#select-authority-dialog').dialog('close');
            				}else{
            					$.messager.alert('信息提示',data.msg,'info');
            				}
            			}
            		});
            	}else{
            		$.messager.alert('信息提示','请至少选择一条权限！','info');
            	}
            }
        }, {
            text: '取消',
            iconCls: 'icon-cancel',
            handler: function () {
                $('#select-authority-dialog').dialog('close');                    
            }
        }],
        onBeforeOpen:function(){
    		//首先获取该角色已经拥有的权限
    		$.ajax({
    			url:'<%=request.getContextPath()%>/authority/selectAuthorityByRoleId',
    			data:{roleId:roleId},
    			type:'post',
    			dataType:'json',
    			success:function(data){
    				existAuthority = data;
    				$("#authority-tree").tree({
                		loadFilter: function(rows){
                			return convert(rows);
                		}
                	});
    			}
    		});
        	
        }
    });
}
	

		
</script>