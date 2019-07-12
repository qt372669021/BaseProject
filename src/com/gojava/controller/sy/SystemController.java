package com.gojava.controller.sy;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/sy")
public class SystemController { 
		
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
}
