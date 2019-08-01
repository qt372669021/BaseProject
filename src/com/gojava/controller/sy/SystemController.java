package com.gojava.controller.sy;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.gojava.entity.sy.Menu;
import com.gojava.entity.sy.User;
import com.gojava.service.sy.UserService;
import com.gojava.util.MenuUtil;
import com.gojava.util.cpacha.CpachaUtil;

@Controller
@RequestMapping("/system")
public class SystemController { 
	
	@Autowired
	private  UserService userService;
	
	
		
//		@RequestMapping(value="/login",method=RequestMethod.GET)
//		public  String  index(){
//			return  "login";
//		}
		
		//访问登录页面
		@RequestMapping(value="/login",method=RequestMethod.GET)
		public  ModelAndView  log(ModelAndView mv){
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
		public void  getYanzCode( int vl,Integer w,	Integer h, String type,HttpServletRequest req,HttpServletResponse resp){
			CpachaUtil  cu=new CpachaUtil(vl,w,h);
			String  yzCode=cu.generatorVCode();//生成验证码
			req.getSession().setAttribute("cpachaType", yzCode);
			BufferedImage bimage=	cu.generatorRotateVCodeImage(yzCode, true);
			try {
				ImageIO.write(bimage, "gif", resp.getOutputStream());
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		//登录表单提交处理控制器
		@RequestMapping(value="/login",method=RequestMethod.POST)
		@ResponseBody
		public Map<String, String>  login(ModelAndView mv,HttpServletRequest req,User user,String cpacha){
			Map<String, String> ret = new HashMap<String, String>();
			try{
				userService.selectLogin(user, cpacha, req);
				ret.put("type", "success");
				ret.put("msg","登陆成功！");
			}catch(Exception e){
				ret.put("type", "false");
				ret.put("msg",e.getMessage());
			}
			return ret;
		}
		//登录后的主页
		@RequestMapping(value="/main",method=RequestMethod.GET)
		public  ModelAndView  getMain(ModelAndView mv,HttpServletRequest req){
			mv.setViewName("sy/main");
			@SuppressWarnings("unchecked")
			List<Menu> userMenu=(List<Menu>) req.getSession().getAttribute("userMenu");
			mv.addObject("topMenuList", MenuUtil.getTopMenuList(userMenu));//顶部菜单
			mv.addObject("secondMenuList", MenuUtil.getSecondMenuList(userMenu));//二级菜单
			return  mv;
		}
		//首页
		@RequestMapping(value="/home",method=RequestMethod.GET)
		public  ModelAndView  getHome(ModelAndView mv){
			mv.setViewName("sy/home");
			return  mv;
		}
		//退出
		@RequestMapping(value="/logout",method=RequestMethod.GET)
		public  String  logout(HttpServletRequest req){
			HttpSession session=req.getSession();
			session.setAttribute("login_user", null);
			session.setAttribute("role", null);
			session.setAttribute("userMenu", null);
			return  "redirect:login";
		}
}
