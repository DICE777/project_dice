package com.userchat.web.dao;

import com.userchat.web.dto.ChatDTO;
import com.userchat.web.dto.UserDTO;

public interface ChatDAO {
	public ChatDTO getChatListByID(ChatDTO chatDTO);
	public ChatDTO getChatListByRecent(ChatDTO chatDTO);//대화 내역 중 최근 몇개만 뽑아서 가져오는 것
	public int submit(ChatDTO chatDTO);//채팅보내는 전송기능
}
