package ino.web.freeBoard.controller;

import ino.web.freeBoard.dto.FreeBoardDto; 
import ino.web.freeBoard.service.FreeBoardService;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
	public String freeBoardInsertPro( HttpServletRequest request, FreeBoardDto dto){
		System.out.println("::::::::: 입력받은 데이터 :::::::::"+dto);
		freeBoardService.freeBoardInsertPro(dto);
		
		dto.setNum(freeBoardService.getNewNum());
		System.out.println("------------------------------최종 입력전데이터---------------------------"+dto);
		return "forward:/freeBoardDetail.ino?num="+dto.getNum();
	}
	

	@RequestMapping("/freeBoardDetail.ino")
	public ModelAndView freeBoardDetail(HttpServletRequest request,int num){
		
		ModelAndView mv = new ModelAndView("freeBoardDetail", "freeBoardDto", freeBoardService.getDetailByNum(num));
		
		return mv;
	}
	
	@RequestMapping("/freeBoardModify.ino")
	public String freeBoardModify(HttpServletRequest request, FreeBoardDto dto){
		return "redirect:/main.ino";
	}


	@RequestMapping("/freeBoardDelete.ino")
	public String FreeBoardDelete(int num){
		return "redirect:/main.ino";
	}
}