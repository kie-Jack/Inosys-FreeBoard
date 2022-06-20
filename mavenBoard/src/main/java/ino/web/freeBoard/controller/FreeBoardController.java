package ino.web.freeBoard.controller;

import ino.web.freeBoard.dto.FreeBoardDto;
import ino.web.freeBoard.service.FreeBoardService;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class FreeBoardController {

	@Autowired
	private FreeBoardService freeBoardService;

	@RequestMapping("/main.ino")
	public ModelAndView main(HttpServletRequest request){
		ModelAndView mav = new ModelAndView();
		List<FreeBoardDto> list = freeBoardService.freeBoardList();

		mav.setViewName("boardMain");
		mav.addObject("freeBoardList",list);
		return mav;
	}
	
	@RequestMapping("/freeBoardInsert.ino")
	public String freeBoardInsert(){
		return "freeBoardInsert";
	}

	@RequestMapping("/freeBoardInsertPro.ino")
	@ResponseBody
	public HashMap<String,Object> freeBoardInsertPro(HttpServletRequest request,@RequestParam HashMap<String,Object> vals){
		HashMap<String,Object> map = new HashMap<String, Object>();
		Integer newNum = 0;
		try {

			freeBoardService.freeBoardInsertPro(vals);
			newNum = freeBoardService.getNewNum();
			map.put("status", true);
			map.put("num", newNum);
			
		}catch(Exception e) {
			
			map.put("message",e.getMessage());
			map.put("status", false);
			
			return map;
		}
		
		return map;
	}

	@RequestMapping("/freeBoardDetail.ino")
	@ResponseBody
	public ModelAndView freeBoardDetail(HttpServletRequest request, Integer num){
		
		ModelAndView mv = new ModelAndView("freeBoardDetail","freeBoardDto",freeBoardService.getDetailByNum(num));
		
		return mv;
	}

	@RequestMapping("/freeBoardModify.ino")
	@ResponseBody
	public HashMap<String,Object> freeBoardModify(HttpServletRequest request, FreeBoardDto dto){
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		int num = dto.getNum();
		try {
			freeBoardService.freeBoardModify(dto);
			map.put("num", num);
			map.put("status", true);
			
		}catch(Exception e) {
			
			map.put("message", e.getMessage());
			map.put("status", false);
			
			return map;
		}
		
		return map;
	}


	@RequestMapping("/freeBoardDelete.ino")
	@ResponseBody
	public HashMap<String,Object> FreeBoardDelete(Integer num){
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		try {
			
			freeBoardService.FreeBoardDelete(num);
			map.put("status", true);
			map.put("num", num);
			
		}catch(Exception e) {
			
			map.put("status", false);
			map.put("message", e.getMessage());
			
			return map;
		}
		
		return map;
	}
	
	@RequestMapping("/freeBoardMultiDelete.ino")
	@ResponseBody
	public HashMap<String,Object> FreeBoardMultiDelete(@RequestParam (value="valueArr[]")List<Integer> valueArr){
		HashMap<String,Object> map = new HashMap<String,Object>();
		try {
			
			map.put("status", true);
			map.put("valueArr", valueArr);
			freeBoardService.FreeBoardMultiDelete(valueArr);
		
		}catch(Exception e) {
			
			map.put("status", false);
			map.put("message", e.getMessage());
			
			return map;
		}
		
		return map;
	}
}