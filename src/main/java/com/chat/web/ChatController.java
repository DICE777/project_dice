package com.chat.web;

import java.net.URLDecoder;

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
	
	
	@RequestMapping(value="/chatContent",method=RequestMethod.POST)
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
	
	//전송
	@RequestMapping(value="/ChatSubmit",method=RequestMethod.POST)
	public String ChatSubmit(ChatDTO chatDTO,Model model) {
		
		ChatDAO mapper = session.getMapper(ChatDAO.class);
		
		int result = mapper.submit(chatDTO);
		
		System.out.println(result);
		
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
		
}
