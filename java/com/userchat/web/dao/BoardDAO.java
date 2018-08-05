package com.userchat.web.dao;

import java.util.ArrayList;

import com.userchat.web.dto.BoardDTO;

public interface BoardDAO {
	public int insert(BoardDTO boardDTO); //게시글 등록 (토론채팅방)
	public ArrayList<BoardDTO> selectAll(BoardDTO boardDTO); //게시글 가져오기 (토론채팅방)
}
