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
import com.userchat.web.dao.BoardDAO2;
import com.userchat.web.dao.ChatDAO;
import com.userchat.web.dao.UserDAO;
import com.userchat.web.dto.BoardDTO;
import com.userchat.web.dto.ChatDTO;
import com.userchat.web.dto.UserDTO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class BoardController2 {
	
	@Autowired
	SqlSession session;

	//boardView List 출력
	@RequestMapping(value = "/boardView2", method = RequestMethod.GET)
	public String boardView(BoardDTO boardDTO,Model model) {
		BoardDAO2 mapper = session.getMapper(BoardDAO2.class);
		
		ArrayList<BoardDTO> result = mapper.selectBoard(boardDTO);
		
		System.out.println(boardDTO);
		System.out.println("게시판리스트");
		
		//보내줄 때 객체의 이름
		model.addAttribute("boardList", result);
		
		return "boardView2";
		
	}
	
	//boardWrite로 이동
	@RequestMapping(value = "/chatViewGo", method = RequestMethod.GET)
	public String chatViewGo() {
			
		return "chatView";
			
	}
	
	//chatContent가져오기
	@RequestMapping(value = "/chatContent", method = RequestMethod.GET)
	public String chatContent(ChatDTO chatDTO) {
		
		System.out.println(chatDTO);
		
		ChatDAO mapper = session.getMapper(ChatDAO.class);
		
		ArrayList<ChatDTO> result= mapper.chatContentSelect(chatDTO);
		
		System.out.println(chatDTO);
		System.out.println("토론 내용 가져옴");
			
		return "redirect:/boardView2";
				
	}	
		

}
