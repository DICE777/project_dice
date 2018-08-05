package com.chat.web;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
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
	/*	
		//7강 7분
		
		ArrayList<ChatDTO> chatList = null;
		chatList = new ArrayList<ChatDTO>();
		
		while(rs.next()) {
			ChatDTO chat= new ChatDTO();
			chat.setChatID(rs.getInt("chatID"));
			chat.setFromID(rs.getString("fromID").replaceAll("","&nbsp;").replaceAll("<","&lt;").replaceAll("\n","<br>"));
			chat.setToID(rs.getString("toID").replaceAll("","&nbsp;").replaceAll("<","&lt;").replaceAll("\n","<br>"));
			chat.setChatContent(rs.getString("chatContent").replaceAll("","&nbsp;").replaceAll("<","&lt;").replaceAll("\n","<br>"));
			int chatTime= Integer.parseInt(rs.getString("chatTime").substring(11,13));
			String timeType = "오전";
			if(chatTime>=12) {
				timeType="오후";
				chatTime -=12;
			}
			chat.setChatTime(rs.getString("chatTime").substring(11,13)+" "+timeType+" "+chatTime+":"+rs.getString("chatTime").substring(14,16)+"");
			chatList.add();
		}
		*/
		
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
		
		//String fromID= request.getParameter("fromID");
		/*
		int fromID = chatDTO.getChatID();
		String toID = chatDTO.getToID();
		String chatContent= chatDTO.getChatContent();
		
		/*if(fromID==0 || toID==null || toID.equals("") || chatContent ==null || chatContent.equals("")) {
			model.addAttribute("0");
		} else {
			model.addAttribute(result);
			//response.getWriter().write(new ChatDAO().submit(fromID,toID,chatContent)+"");
		}*/
		
		
		return result;
	}
	
	//사용자가 주고받은 대화를 반환해줌
	@RequestMapping(value="/chatList",method=RequestMethod.POST)
	public String ChatList(ChatDTO chatDTO,Model model) {
		
		ChatDAO mapper = session.getMapper(ChatDAO.class);
		
		mapper.getChatListByID(chatDTO);
		
		String fromID = chatDTO.getFromID();
		String toID = chatDTO.getToID();
		
		
		if(fromID==null || toID==null || toID.equals("")) {
			model.addAttribute("");
		} else if(chatDTO!=null) {
			
		}
		
		
		return "chat";
	}
	/*
	//제이슨 : 어떠한 개발언어든 공통적으로 사용할 수 있는 1개의 배열같은 것들을 표현하고 담을 수 있는 약속
	 * 밑에 주석 정확한거 아님 다 수정해야함
	 12:04 실수한 부분 배열 하나임!
	public String getTen(String fromID, String toID) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		
		ChatDTO chatDTO = new ChatDTO();
		chatDTO.setFromID(fromID);
		chatDTO.setToID(toID);
		
		
		ChatDAO mapper = session.getMapper(ChatDAO.class);
		
		RowBounds rb = new RowBounds(1, 10);
		
		ArrayList<ChatDTO> chatList = mapper.getChatListByRecent(chatDTO,rb);
		if(chatList.size()==0) return ""; //chatList가 비어있으면 공백문자 반환
		for(int i =0; i<chatList.size(); i++) {  //있으면 대화내용출력하게 
			result.append("{\"value\":\""+chatList.get(i).getFrom()+              
			//2번째는 메시지 받은 사람
			//메시지보낸내용
			//보낸시각
			//if() 만약 마지막 원소가 아니라면 다음 원소가 있따는 걸 알려주기 위해 ,찍음
			//
		}
		return result.toString();
	}
	
		public String getID(String fromID, String toID, String chatID) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		
		ChatDTO chatDTO = new ChatDTO();
		chatDTO.setFromID(fromID);
		chatDTO.setToID(toID);
		
		
		ChatDAO mapper = session.getMapper(ChatDAO.class);
		
		RowBounds rb = new RowBounds(1, 10);
		
		ArrayList<ChatDTO> chatList = mapper.getChatListByID(chatDTO,rb);
		if(chatList.size()==0) return ""; //chatList가 비어있으면 공백문자 반환
		for(int i =0; i<chatList.size(); i++) {  //있으면 대화내용출력하게 
			result.append("{\"value\":\""+chatList.get(i).getFrom()+              
			//2번째는 메시지 받은 사람
			//메시지보낸내용
			//보낸시각
			//if() 만약 마지막 원소가 아니라면 다음 원소가 있따는 걸 알려주기 위해 ,찍음
			//
		}
		return result.toString();
	}
	*/
		
}
