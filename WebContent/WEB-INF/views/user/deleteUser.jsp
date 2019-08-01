<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<script>
	/**
	* Name 删除记录 
	   1.定义一个字符串ids存id，2.定义一个数组存id，并转换为字符串传后端，定义字符串ids2，循环数组，或者ids.join(",")=1,2
	*/
	function remove(){
		$.messager.confirm('信息提示','确定要删除该记录？', function(result){
			if(result){
				var item = $('#data-datagrid').datagrid('getSelections');
				if(item == null || item.length == 0){
					$.messager.alert('信息提示','请选择要删除的数据！','info');
					return;
				}
				var ids = [];
				for(var i=0;i<item.length;i++){
					ids.push(item[i].id);
				}
				console.log(ids.join(","))
/* 				var ids2 = '';
				for(var j=0;j<ids.length;j++){
					ids2+=ids[j]+',';
				} */
				$.ajax({
					url:'<%=request.getContextPath()%>/user/deleteUser',
					dataType:'json',
					type:'post',
					data:{ids:ids.join(",")},
					success:function(data){
						if(data.code == 200){
							$.messager.alert('信息提示','删除成功！','info');
							$('#data-datagrid').datagrid('reload');
						}else{
							$.messager.alert('信息提示',data.msg,'warning');
						}
					}
				});
			}	
		});
	}
	</script>