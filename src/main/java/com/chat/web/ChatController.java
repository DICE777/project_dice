package com.chat.web;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.userchat.web.dao.ChatDAO;
import com.userchat.web.dto.ChatDTO;

@Controller
public class ChatController {
	
	@Autowired
	SqlSession session;
	
	//채팅 페이지
	@RequestMapping(value="/chat")
	public String chatGO() {
				
		return "chat";
	}
	
	
/*	@RequestMapping(value="/chatContent",method=RequestMethod.POST)
	public String getChatListByID(ChatDTO chatDTO) {
		ChatDAO mapper= session.getMapper(ChatDAO.class);
		
		ChatDTO result = mapper.getChatListByID(chatDTO);
		
		System.out.println(chatDTO);
		
		return "chat";
	}
	
	@RequestMapping(value="/portlet-heading",method=RequestMethod.POST)
	public String getChatListByRecent(ChatDTO chatDTO) {
		ChatDAO mapper= session.getMapper(ChatDAO.class);
		
		ChatDTO result = mapper.getChatListByRecent(chatDTO);
		
		System.out.println(chatDTO);
		
		return "chat";
	}
	*/
	//전송
	@RequestMapping(value="/ChatSubmit",method=RequestMethod.POST)
	public String ChatSubmit(ChatDTO chatDTO,Model model) {
		
		ChatDAO mapper = session.getMapper(ChatDAO.class);
		
		int result = mapper.submit(chatDTO);
		
		System.out.println(result);
		//String fromID= request.getParameter("fromID");
		int fromID = chatDTO.getChatID();
		String toID = chatDTO.getToID();
		String chatContent= chatDTO.getChatContent();
		
		if(fromID==0 || toID==null || toID.equals("") || chatContent ==null || chatContent.equals("")) {
			model.addAttribute("0");
		} else {
			model.addAttribute(result);
			//response.getWriter().write(new ChatDAO().submit(fromID,toID,chatContent)+"");
		}
		
		
		return "chat";
	}
	/*
	//사용자가 주고받은 대화를 반환해줌
	@RequestMapping(value="/",method=RequestMethod.POST)
	public String ChatList(ChatDTO chatDTO,Model model) {
		
		ChatDAO mapper = session.getMapper(ChatDAO.class);
		
		mapper.getChatListByID(chatDTO);
		
		int fromID = chatDTO.getChatID();
		String toID = chatDTO.getToID();
		
		
		if(fromID==0 || toID==null || toID.equals("")) {
			model.addAttribute("");
		} else if(chatDTO!=null) {
		}
		
		
		return "chat";
	}
	
	//제이슨 : 어떠한 개발언어든 공통적으로 사용할 수 있는 1개의 배열같은 것들을 표현하고 담을 수 있는 약속
	public String getTen(String fromID, String toID, String chatID) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		
		ChatDTO chatDTO = new ChatDTO();
		chatDTO.setFromID(fromID);
		chatDTO.setToID(toID);
		
		
		ChatDAO mapper = session.getMapper(ChatDAO.class);
		
		RowBounds rb = new RowBounds(1, 10);
		
		ArrayList<ChatDTO> chatList = mapper.getChatListByRecent(chatDTO,rb);
		if(chatList.size()==0) return "";
		for(int i =0; i<chatList.size(); i++) {
			result.append("{\"value\":\""+)
		}
		return result.toString();
	}
		*/
}
