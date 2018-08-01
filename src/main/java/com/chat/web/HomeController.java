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
import org.junit.runner.Request;
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
import org.springframework.web.servlet.ModelAndView;

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
	
	//회원가입 페이지 가는 거
	@RequestMapping(value="/join", method=RequestMethod.GET)
	public String joinGo() {
			
		return "join";
		
	}
	
	//회원가입 기능 
	@RequestMapping(value="/userRegister", method=RequestMethod.POST)
	public String join(UserDTO userDTO,HttpSession hsession,Model model) {
		
		String userID = userDTO.getUserID();
		String userPassword = userDTO.getUserPassword();
		String userPassword2 = userDTO.getUserPassword();
		String userName = userDTO.getUserName();
		int userAge = userDTO.getUserAge();
		String userGender = userDTO.getUserGender();
		String userEmail = userDTO.getUserEmail();
		String userProfile= userDTO.getUserProfile();
		
		if(userID==null || userID.equals("") || userPassword==null || userPassword.equals("")
				|| userPassword2==null || userPassword2.equals("")|| userName==null || userName.equals("")
				|| userAge==0 || userGender==null || userGender.equals("")|| userEmail==null || userEmail.equals("")) {
			//request.getSession().setAttribute("messageType", "오류 메시지");
			hsession.setAttribute("messageType", "오류 메시지");
			hsession.setAttribute("messageContent", "모든 내용을 입력하세요.");
			return "join";
		}
		if(!userPassword.equals(userPassword2)) {
			hsession.setAttribute("messageType", "오류 메시지");
			hsession.setAttribute("messageContent", "비밀번호가 서로 다릅니다.");
			return "join";
		}
		
		//회원가입시켜줌

		System.out.println(userDTO);
		
		UserDAO mapper = session.getMapper(UserDAO.class);
		
		int count= mapper.insertUser(userDTO);
		
		if(count==1) {
			hsession.setAttribute("userID", userID);
			hsession.setAttribute("messageType", "성공 메시지");
			hsession.setAttribute("messageContent", "회원가입에 성공했습니다");
			return "index";
		} else {
			hsession.setAttribute("messageType", "오류 메시지");
			hsession.setAttribute("messageContent", "이미 존재하는 회원입니다.");
			return "join";
		}
		
		
	}
	/*
	//아이디 중복체크 기능 (실행되는 것)
	@RequestMapping(value="/idcheck",method=RequestMethod.GET)
	public @ResponseBody int example(UserDTO userDTO) {
		
		UserDAO mapper = session.getMapper(UserDAO.class);
		
		int result= mapper.idcheck(userDTO);
		
		System.out.println(result);
		
		return result;
		
	}
	
	*/
	
	//작업중인거
	@RequestMapping(value="/UserRegisterCheck",method=RequestMethod.POST)
	public @ResponseBody int UserRegisterCheck(UserDTO userDTO) {
		
		UserDAO mapper = session.getMapper(UserDAO.class);
		
		int result= mapper.idcheck(userDTO);
		
		System.out.println(result);
		
		return result;
		
	}
	
		
}
