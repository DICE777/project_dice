package com.chat.web;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.userchat.web.dao.BoardDAO;
import com.userchat.web.dao.UserDAO;
import com.userchat.web.dto.BoardDTO;
import com.userchat.web.dto.UserDTO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class BoardController {
	
	@Autowired
	SqlSession session;

	//boardView List 출력
	@RequestMapping(value = "/boardView", method = RequestMethod.GET)
	public String boardView(HttpSession hSession, BoardDTO boardDTO,Model model) {
		
		String userID = (String) hSession.getAttribute("userID"); //객체 불러왔으니 캐스팅
		
		boardDTO.setUserID(userID); //세션이 DTO에 들어가있는 것.
		
		BoardDAO mapper = session.getMapper(BoardDAO.class);
		
		ArrayList<BoardDTO> result = mapper.selectAll(boardDTO);
		
		System.out.println(boardDTO);
		System.out.println("boardWrite 토론주제(게시글) 가져오기 완료");
		
		//보내줄 때 객체의 이름
		model.addAttribute("boardList", result);
		
		return "boardView";
		
	}
	
	//boardWrite로 이동
	@RequestMapping(value = "/boardWriteGo", method = RequestMethod.GET)
	public String boardWriteGo() {
			
		return "boardWrite";
			
	}
	
	//boardWrite에서 토론주제 작성
	@RequestMapping(value = "/boardWrite", method = RequestMethod.POST)
	public String boardWrite(BoardDTO boardDTO) {
		
		System.out.println(boardDTO);
		BoardDAO mapper = session.getMapper(BoardDAO.class);
			
		int result= mapper.insert(boardDTO);
		
		System.out.println(boardDTO);
		System.out.println("boardWrite 토론주제(게시글) 작성 완료");
			
		return "redirect:/boardView";
				
	}	
		

}
