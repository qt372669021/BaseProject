<%@ page language="java" contentType="text/html; charset=Utf-8"  pageEncoding="Utf-8"%>

<!-- 权限弹窗 -->
<div id="select-authority-dialog" class="easyui-dialog" data-options="closed:true,iconCls:'icon-save'" style="width:230px;height:450px; padding:10px;">
     <ul id="authority-tree" url="<%=request.getContextPath()%>/authority/getMenuList" checkbox="true"></ul>
</div>

<script type="text/javascript">


// step3 .判断是否有父类--来自官方文档,rows: 返回的菜单信息
function exists(rows, parentId){
	for(var i=0; i<rows.length; i++){
		if (rows[i].id == parentId) 
			return true;
	}
	return false;
}
//step2. 转换原始数据符号tree要求；
function convert(rows){
	var nodes = [];
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
		var node = toDo.shift();	
		for(var i=0; i<rows.length; i++){
			var row = rows[i];
			if (row.parentId == node.id){
				var child = {id:row.id,text:row.name};
				if (node.children){
					node.children.push(child);
				} else {
					node.children = [child];
				}
				toDo.push(child);
			}
		}
	}
	return nodes;
}


	function selectAuthority(){
		//打开窗口
		$('#select-authority-dialog').dialog({
			closed: false,
			modal:true,
	        title: "选择权限",
	        buttons: [{
	            text: '确定',
	            iconCls: 'icon-ok',
	            handler: function(){
	            	//获取选中的值
	            	var ids='';
	            	var nodes = $('#authority-tree').tree('getChecked');//获取勾选的，排除上级的
	            	 for(var i=0;i<nodes.length;i++){
	            		 ids+=nodes[i].id+',';
	            	 }
	            	var nodesParent = $('#authority-tree').tree('getChecked', 'indeterminate');//获取勾选上级，排除本身；
	            	  for(var i=0;i<nodesParent.length;i++){
	            		  ids+=nodesParent[i].id+',';
	            	  }
	            	if(ids !=''){
	            		var item = $('#data-datagrid').datagrid('getSelected');
	            		console.log(item);
	            		$.ajax({
	            			url:'<%=request.getContextPath()%>/authority/addAuthority',
	            			type:'post',
	            			data:{ids:ids,roleId:item.id},
	            			dataType:'json',
	            			success:function(data){
	            				if(data.code=200){
	            					$.messager.alert('信息提示','权限编辑成功！','info');
	            					$('#select-authority-dialog').dialog('close');
	            				}else{
	            					$.messager.alert('信息提示',data.msg,'warning');
	            				}
	            			}
	            		});
	            	}
	            }
	        }, {
	            text: '取消',
	            iconCls: 'icon-cancel',
	            handler: function () {
	                $('#select-authority-dialog').dialog('close');                    
	            }
	        }],
	      //在窗口弹出之前要加载
	        onBeforeOpen:function(){
	        	$('#authority-tree').tree({
	        	//获取改角色拥有的权限
	        		loadFilter: function(rows){
	        			//step1.
	        			return convert(rows);
	        		}
	        	});
	        }
	    });
	}
	

		
</script>