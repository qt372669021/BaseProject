package com.gojava.controller.sy;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import tk.mybatis.mapper.entity.Example;
import tk.mybatis.mapper.entity.Example.Criteria;

import com.github.pagehelper.util.StringUtil;
import com.gojava.common.ResponseContent;
import com.gojava.common.Result;
import com.gojava.common.SystemException;
import com.gojava.entity.sy.User;
import com.gojava.service.sy.UserService;
import com.gojava.util.cpacha.CpachaUtil;

@Controller
@RequestMapping("/sy")
public class SystemController { 
	
	@Autowired
	private  UserService userService;
		
//		@RequestMapping(value="/login",method=RequestMethod.GET)
//		public  String  index(){
//			return  "login";
//		}
		
		@RequestMapping(value="/login",method=RequestMethod.GET)
		public  ModelAndView  log(ModelAndView mv){
			mv.addObject("msg", "大爷哦");
			mv.setViewName("sy/login"); 
			return  mv;
		}
		
		/**
		 * 
		* @Title: getYanzCode  
		* @Description: TODO(获取验证码)  
		*  step1:生成验证码，并存取在session对象中；
		*  step2:生成验证码图片（含在图片上画验证码）；
		*  step3：画干扰线；
		*
		 */
		@RequestMapping(value="/yanzCode",method=RequestMethod.GET)
		public void  getYanzCode( int vl,Integer w,	Integer h,@RequestParam(name="type",required=true,defaultValue="loginCpacha") String cpachaType,HttpServletRequest req,HttpServletResponse resp){
			CpachaUtil  cu=new CpachaUtil(vl,w,h);
			String  yzCode=cu.generatorVCode();//生成验证码
			req.getSession().setAttribute(cpachaType, yzCode);
			BufferedImage bimage=	cu.generatorRotateVCodeImage(yzCode, true);
			try {
				ImageIO.write(bimage, "gif", resp.getOutputStream());
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		@RequestMapping(value="/login",method=RequestMethod.POST)
		public Map<String, String>  login(ModelAndView mv,HttpServletRequest req,User user,String cpacha){
			Map<String, String> ret = new HashMap<String, String>();
			try{
				User u=userService.selectLogin(user, cpacha, req);
				ret.put("type", "success");
				ret.put("msg","登陆成功！");
			}catch(Exception e){
				ret.put("type", "false");
				ret.put("msg",e.getMessage());
			}
			return ret;
		}
}
