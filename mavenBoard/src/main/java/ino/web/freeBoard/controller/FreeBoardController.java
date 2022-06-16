package ino.web.freeBoard.controller;

import ino.web.freeBoard.dto.FreeBoardDto; 
import ino.web.freeBoard.service.FreeBoardService;

import java.io.IOException;
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
	public HashMap<String,Object> freeBoardInsertPro( HttpServletRequest request, @RequestParam HashMap<String,Object> params){
		/*System.out.println("::::::::: 입력받은 데이터 :::::::::"+dto);*/

		Integer newNum = 0;
		HashMap<String,Object> map = new HashMap<>();
		
		try {
		
			freeBoardService.freeBoardInsertPro(params);
			newNum = freeBoardService.getNewNum();
			map.put("num", newNum);
			map.put("status", "SUCCESS");

		}catch(Exception e) {
			map.put("message", e.getMessage());
			return map;
		}
		map.put("message","게시글 작성 완료");
		/*System.out.println("------------------------------최종 입력전데이터---------------------------"+dto);*/
		return map;
	}
	
	@RequestMapping("/freeBoardDetail.ino")
	@ResponseBody
	public ModelAndView freeBoardDetail(HttpServletRequest request, Integer num){
		
		ModelAndView mv  = new ModelAndView("freeBoardDetail", "freeBoardDto", freeBoardService.getDetailByNum(num));
		
		return mv;
	}
	
	@RequestMapping("/freeBoardModify.ino")
	@ResponseBody
	public ModelAndView freeBoardModify(HttpServletRequest request, FreeBoardDto dto, int num){
		ModelAndView mv = null;
		
		try {
			
			freeBoardService.freeBoardModify(dto);
		
			mv = new ModelAndView("freeBoardDetail", "freeBoardDto", freeBoardService.getDetailByNum(num));
		}catch(Exception e) {
			e.printStackTrace();
		}
		return mv;
	}


	@RequestMapping("/freeBoardDelete.ino")
	@ResponseBody
	public HashMap<String,Object> FreeBoardDelete(@RequestParam HashMap<String,Object> params){
	
		HashMap<String,Object> map = new HashMap<>();
		try {
			freeBoardService.FreeBoardDelete(params);
			map.put("num", params);
			map.put("status", "SUCCESS");
		}catch(Exception e) {
			map.put("message", e.getMessage());
			return map;
		}
			map.put("message", "게시물 삭제 완료");
		return map;
	}
	
	@RequestMapping("/freeBoardDeleteMultiple.ino")
	@ResponseBody
	public HashMap<String,Object>  FreeBoardDeleteMultiple(@RequestParam(value="valueArr[]")List<Integer> valueArr) {
		
		HashMap<String,Object> map = new HashMap<>();
		try {
			
			System.out.println("선택된 넘값 배열"+valueArr);
			map.put("valueArr", valueArr);
			freeBoardService.FreeBoardDeleteMultiple(valueArr);
			
			map.put("status", "SUCCESS");
		
		}catch(Exception e) {
			map.put("message", e.getMessage());
			return map;
		}
			map.put("message", "게시물 삭제 완료");
		return map;
	}
}