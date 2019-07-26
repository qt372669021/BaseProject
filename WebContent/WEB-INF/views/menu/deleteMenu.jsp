<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<script>
	/**
	* Name 删除记录
	*/
	function remove(){
		$.messager.confirm('信息提示','确定要删除该记录？', function(result){
			if(result){
				var item = $('#data-datagrid').datagrid('getSelected');
				$.ajax({
					url:'<%=request.getContextPath()%>/menu/delete',
					dataType:'json',
					type:'post',
					data:{id:item.id},
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
	</script>