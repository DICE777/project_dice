package com.chat.web;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.userchat.web.dao.ChatDAO;
import com.userchat.web.dto.ChatDTO;

@Controller
public class ChatController {
	
	@Autowired
	SqlSession session;
	
	//채팅 페이지
	@RequestMapping(value="/chat",method=RequestMethod.GET)
	public String chatGO(ChatDTO chatDTO,Model model) {
		
		model.addAttribute("chatID", chatDTO.getChatID());
		
		return "chat";
	}
	
	//특정아이디에 따라 채팅 내역을 가져옴
	@RequestMapping(value="/chatContent",method=RequestMethod.POST)
	public String getChatListByID(ChatDTO chatDTO) {
		
		ChatDAO mapper= session.getMapper(ChatDAO.class);
		
		ArrayList<ChatDTO> result = mapper.getChatListByID(chatDTO);
		
		System.out.println(chatDTO);
		System.out.println("채팅 내용 가져왔다!");
	
		return "chat";
	}
	
		
	//대화 내역 중 최근 몇 개만 뽑아서 가져옴
	@RequestMapping(value="/portlet-heading",method=RequestMethod.POST)
	public String getChatListByRecent(ChatDTO chatDTO) {
		
		ChatDAO mapper= session.getMapper(ChatDAO.class);
		
		ArrayList<ChatDTO> result= mapper.getChatListByRecent(chatDTO);
		
		System.out.println(chatDTO);
		
		return "chat";
	}
	
	
	
	//전송
	@RequestMapping(value="/ChatSubmit",method=RequestMethod.POST)
	public @ResponseBody int ChatSubmit(@RequestBody ChatDTO chatDTO) { //내가 넘겨줄 값의 타입을 적는 것. 여기서는 int.
		
		System.out.println(chatDTO);		
		
		ChatDAO mapper = session.getMapper(ChatDAO.class);
		
		int result = mapper.submit(chatDTO);
		
		System.out.println(result);
		
		int fromID = chatDTO.getChatID();
		String toID = chatDTO.getToID();
		String chatContent= chatDTO.getChatContent();
		
		if(fromID==0 || toID==null || toID.equals("") || chatContent ==null || chatContent.equals("")) {
			return 0;
		}
		
		
		return result;
	}
	
	//사용자가 주고받은 대화를 반환해줌
	@RequestMapping(value="/chatList",method=RequestMethod.POST)
	public @ResponseBody ArrayList<ChatDTO> ChatList(@RequestBody ChatDTO chatDTO,Model model) {
		
		System.out.println(chatDTO);
		ChatDAO mapper = session.getMapper(ChatDAO.class);
		
		ArrayList<ChatDTO> chatList = mapper.getChatListByID(chatDTO);
		System.out.println(chatList);
		String fromID = chatDTO.getFromID();
		String toID = chatDTO.getToID();
		
		//String result = "";
		
		if(fromID==null || toID==null || toID.equals("")) {
			return null;
		}
			
		return chatList;
	}
	
}
