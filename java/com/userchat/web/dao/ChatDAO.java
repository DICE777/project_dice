package com.userchat.web.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;

import com.userchat.web.dto.ChatDTO;

public interface ChatDAO {
	public ArrayList<ChatDTO> getChatListByID(ChatDTO chatDTO);
	public ArrayList<ChatDTO> getChatListByRecent(ChatDTO chatDTO);//대화 내역 중 최근 몇개만 뽑아서 가져오는 것
	public int submit(ChatDTO chatDTO);//채팅보내는 전송기능
	public int updateButton(ChatDTO chatDTO);
	public ArrayList<ChatDTO> chatContentSelect(ChatDTO chatDTO);  //게시글내용
}
