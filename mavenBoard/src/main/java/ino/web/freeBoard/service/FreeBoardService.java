package ino.web.freeBoard.service;

import ino.web.freeBoard.dto.FreeBoardDto;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FreeBoardService {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public List<FreeBoardDto> freeBoardList(HashMap<String,Object>val){
		HashMap<String,Object> map = new HashMap<>();
		
		
		map.put("searchType", val.get("searchType"));
		map.put("s_selectCode", val.get("s_selectCode"));
		map.put("searchByKeyword", val.get("searchByKeyword"));
		map.put("searchByNum", val.get("searchByNum"));
		map.put("sDate", val.get("sDate"));
		map.put("eDate", val.get("eDate"));
		
		return sqlSessionTemplate.selectList("freeBoardGetList",map);
	}


	public void freeBoardInsertPro(HashMap<String,Object> vals){
		sqlSessionTemplate.insert("freeBoardInsertPro",vals);
	}

	public FreeBoardDto getDetailByNum(int num){
		return sqlSessionTemplate.selectOne("freeBoardDetailByNum", num);
	}

	public int getNewNum(){
		return sqlSessionTemplate.selectOne("freeBoardNewNum");
	}

	public void freeBoardModify(FreeBoardDto dto){
		sqlSessionTemplate.update("freeBoardModify", dto);
	}

	public void FreeBoardDelete (Integer num) {
		sqlSessionTemplate.delete("freeBoardDelete", num);

	}
	
	public void FreeBoardMultiDelete(List<Integer> valueArr) {
		sqlSessionTemplate.delete("freeBoardMultiDelete", valueArr);
	}



}
