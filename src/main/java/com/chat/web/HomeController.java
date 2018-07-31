package com.chat.web;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.xml.ws.Response;

import org.apache.ibatis.javassist.compiler.TokenId;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.userchat.web.dao.ChatDAO;
import com.userchat.web.dao.UserDAO;
import com.userchat.web.dto.ChatDTO;
import com.userchat.web.dto.UserDTO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	SqlSession session;

	//메인 페이지
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		
		return "index";
	}
	
	//로그인 페이지
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String login(HttpSession hsession,UserDTO userDTO) {
		
		UserDAO mapper = session.getMapper(UserDAO.class);
		
		UserDTO result= mapper.login(userDTO);
		
		hsession.setAttribute("userID", result.getUserID());
		
		System.out.println("로그인 메소드 완료");
		
		return "redirect:home";
	}
	
	//회원가입 페이지
	@RequestMapping(value="/userRegister", method=RequestMethod.POST)
	public String join(UserDTO userDTO) {
		
		System.out.println(userDTO);
		
		UserDAO mapper = session.getMapper(UserDAO.class);
		
		mapper.insertUser(userDTO);
		
		System.out.println("회원가입 완료");
		
		return "redirect:home";
	}
	
	/*//아이디 중복체크 기능
	@RequestMapping(value="/idcheck",method=RequestMethod.GET)
	public @ResponseBody int example(UserDTO userDTO) {
		
		UserDAO mapper = session.getMapper(UserDAO.class);
		
		int result= mapper.idcheck(userDTO);
		
		System.out.println(result);
		
		return result;
		
	}*/
	
	//채팅 페이지
		@RequestMapping(value="/chat")
		public String chatGO() {
			
			return "chat";
		}
	
	/*@RequestMapping(value="/UserRegisterCheck",method=RequestMethod.POST)
	public @ResponseBody int UserRegisterCheck(UserDTO userDTO) {
		
		UserDAO mapper = session.getMapper(UserDAO.class);
		
		int result= mapper.idcheck(userDTO);
		
		System.out.println(result);
		
		return result;
		
	}
	*/
		//////////////////////8강3분부터~~~~~
	/*@RequestMapping(value="/",method=RequestMethod.POST)
	public String ChatSubmit(ChatDTO chatDTO,Model model) {
		
		ChatDAO mapper = session.getMapper(ChatDAO.class);
		
		int result = mapper.submit(chatDTO);
		
		int fromID = chatDTO.getChatID();
		String toID = chatDTO.getToID();
		String chatContent= chatDTO.getChatContent();
		
		if(fromID==0 || toID==null || toID.equals("")
				|| chatContent ==null || chatContent.equals("")) {
			model.addAttribute("0");
		} else {
			
		}
		
		
		return null;
	}*/
}
