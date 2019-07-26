<%@ page language="java" contentType="text/html; charset=Utf-8"  pageEncoding="Utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">

//删除记录
function remove(){
	$.messager.confirm('信息提示','确定要删除该记录？', function(result){
		if(result){
			var item = $('#data-datagrid').datagrid('getSelected');
			$.ajax({
				url:'<%=request.getContextPath()%>/role/deleteRole',
				dataType:'json',
				type:'post',
				data:item,
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