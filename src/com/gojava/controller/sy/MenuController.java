package com.gojava.controller.sy;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/menu")
public class MenuController {
	
	@RequestMapping(value="/menuList",method=RequestMethod.GET)
	public  ModelAndView  log(ModelAndView mv){
		mv.setViewName("sy/menuList"); 
		return  mv;
	}
}
