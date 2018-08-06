package com.userchat.web.dao;

import java.util.ArrayList;

import com.userchat.web.dto.BoardDTO;
import com.userchat.web.dto.ChatDTO;

public interface BoardDAO2 {
	public ArrayList<BoardDTO> selectBoard(BoardDTO boardDTO); //게시글 가져오기 (토론채팅방)
	
}
