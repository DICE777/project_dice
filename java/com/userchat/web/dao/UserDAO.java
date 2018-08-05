package com.userchat.web.dao;

import com.userchat.web.dto.UserDTO;

public interface UserDAO {
	public UserDTO login(UserDTO userDTO); //로그인
	//public int registerCheck(); 
	public int idcheck(UserDTO userDTO);//id중복확인
	public int insertUser(UserDTO userDTO); //회원가입
	public UserDTO selectUser(UserDTO userDTO); //회원정보 모두 가져오기
}
