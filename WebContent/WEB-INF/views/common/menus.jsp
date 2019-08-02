<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
			<c:forEach items="${thiredMenu }" var="thiredM">
        		  <a href="#" class="easyui-linkbutton" iconCls="${thiredM.icon }" onclick="${thiredM.url}" plain="true">${thiredM.name }</a>
        	</c:forEach>