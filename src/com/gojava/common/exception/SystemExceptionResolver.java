package com.gojava.common.exception;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.support.spring.FastJsonJsonView;
import com.gojava.common.ResponseStatusEnum;

/**
 * 
 *SystemExceptionResolver
 *	自定义全局异常解析类
 * @author qt
 * 2019年7月18日上午10:38:27
 */

public class SystemExceptionResolver implements HandlerExceptionResolver {

	  private static final Logger LOG = LoggerFactory.getLogger(SystemExceptionResolver.class);

    @Override
    public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object obj,  Exception ex) {

        // SysUser user = (SysUser)request.getSession().getAttribute(Constants.LOGIN_USER);
        // String ip = IPUtil.getIpAddr(request);

        ModelAndView mav = new ModelAndView();
        //使用FastJson提供的FastJsonJsonView视图返回，不需要捕获异常
        FastJsonJsonView view = new FastJsonJsonView();
        Map<String, Object> attributes = new HashMap<String, Object>();

        if (ex instanceof SystemException) {
        	LOG.warn(ex.getMessage());
            attributes.put("code", ResponseStatusEnum.RUNTIME.code);
            attributes.put("msg", ex.getMessage());
        } else if (ex instanceof LoginException) {
        	LOG.warn(ex.getMessage());
            attributes.put("code", ResponseStatusEnum.NOT_LOGGED.code);
            attributes.put("msg", "会话超时");
        } else if (ex instanceof RepeatLoginException) {
            attributes.put("code", ResponseStatusEnum.REPEAT_LOGGED.code);
            attributes.put("msg", "该账号已在别处登录");
        } else {
        	LOG.warn(ex.getMessage());
            attributes.put("code", ResponseStatusEnum.CHECKED.code);
            attributes.put("msg", ex.getMessage());
        }

        view.setAttributesMap(attributes);
        mav.setView(view);
        return mav;
    }
}
