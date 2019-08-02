package com.gojava.util.interceptor;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.util.StringUtil;
import com.gojava.entity.sy.Menu;
import com.gojava.util.MenuUtil;
/**
 * 后台登录拦截器
 * 
 */
public class LoginInterceptor implements HandlerInterceptor{

	@Override
	public void afterCompletion(HttpServletRequest req,HttpServletResponse resp, Object arg2, Exception arg3)
			throws Exception {
		
	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1,
			Object arg2, ModelAndView arg3) throws Exception {
		
	}
	/**
	 * 该方法将在请求处理之前进行调用
	 */
	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp,Object arg2) throws Exception {
		String  reqURI=req.getRequestURI();
		System.out.println(reqURI);
		Object loginUser=	req.getSession().getAttribute("login_user");
		if(loginUser ==null){
			String header = req.getHeader("X-Requested-With");
			//判断是否是ajax请求
			if("XMLHttpRequest".equals(header)){
				//表示是ajax请求
				Map<String, String> ret = new HashMap<String, String>();
				ret.put("type", "error");
				ret.put("msg", "登录会话超时或还未登录，请重新登录!");
				resp.getWriter().write(JSONObject.fromObject(ret).toString());//将map转换json
				return false;//返回false请求结束
			}
			resp.sendRedirect(req.getContextPath()+"/system/login");
			return  false;
		}
		
		String mid=req.getParameter("_mid");//获取参数值
		if(StringUtil.isNotEmpty(mid)){
		@SuppressWarnings("unchecked")
		List<Menu>  m=	(List<Menu>)req.getSession().getAttribute("userMenu");
		List<Menu> thiredMenu=MenuUtil.getThiredMenu(m, Long.valueOf(mid));
		req.getSession().setAttribute("thiredMenu", thiredMenu);
		}
		return true;//拦截，不执行了
		
	}

}
