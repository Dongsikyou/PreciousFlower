package com.pf.member;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pf.member.dto.ListDto;
import com.pf.member.dto.MemberDto;
import com.pf.member.service.MemberService;

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private MemberService mServ;

	private ModelAndView mv;
	
	@Autowired
	private JavaMailSender mailSender;
	
	
	@GetMapping("/")
	public String home() {
		logger.info("home()"); {
			
			return "home"; 
		}
	}
	
	@GetMapping("/m_home")
	public String m_home() {
		logger.info("m_home()"); {
			
			return "m_home"; 
		}
	}
	
	@GetMapping("/about")
	public String about() {
		logger.info("about()"); {
			
			return "about"; 
		}
	}
	
	
	@GetMapping("/join")
	public String join() {
		logger.info("join()"); {
			
			return "join"; 
		}
	}
	
	
	@GetMapping("/m_main")
	public ModelAndView m_main(ListDto list, HttpSession session) {
		logger.info("m_main()-main");
		
		//DB에서 게시글의 목록을 가져와서 페이지로 전달
		mv = mServ.getMemberList(list, session);
		
		return mv;
	}
	
	@GetMapping("/m_list")
	public ModelAndView rlist(ListDto list, HttpSession session) {
		logger.info("m_list()");
		
		//DB에서 게시글의 목록을 가져와서 페이지로 전달
		mv = mServ.getMemberList(list, session);
		
		return mv;
	}
	
	
	@GetMapping("/m_joinFrm")
	public String mjoinFrm() {
		logger.info("m_joinFrm()"); {
			
			return "m_joinFrm"; 
		}
	}
	
	@GetMapping("/m_myPage")
	public String mmypage() {
		logger.info("m_mypage()"); {
			
			return "m_myPage"; 
		}
	}
	
	// 아이디 중복 검사 //
	
	@GetMapping(value = "/idCheck", 
			    produces = "application/text; charset=UTF-8")
	@ResponseBody
	public String idCheck(String mid) {
		logger.info("idCheck() - mid : " + mid);
		
		String res = mServ.idCheck(mid);
		
		return res;
	}
	
	// 아이디 중복 검사 End//
	
	// 회원 가입 //
	
	@PostMapping("/memInsert") 
	public String memberJoin(MemberDto member, RedirectAttributes rttr) {
		logger.info("mmemberJoin()");
		
		String view = mServ.memberInsert(member, rttr);
		
		return view;
	}
	
	// 회원 가입 End //
	
								// ********* 이메일 인증 *************
	
	@GetMapping(value = "/mmailCheck", produces = "application/text; charset=UTF-8")
	@ResponseBody
	public String remailCheck(String memberEmail) throws Exception {
		logger.info("일반 이메일 데이터 전송 확인");
		logger.info("인증번호 : " + memberEmail);
		
		String keyStr = mServ.emailConfirm(memberEmail);
		
		return keyStr;
	}
	
	
	
	// 일반,라이더 로그인 프로세스 //
	
	@PostMapping("/m_loginProc")
	public String m_loginProc(MemberDto member, HttpSession session, RedirectAttributes rttr) {
		logger.info("m_loginProc()");
		
		String view = mServ.m_loginProc(member, session, rttr);
		
		return view;
	}
	
	// 일반 로그인 프로세스 End //
	
	
	@GetMapping("/loginFrm")
	public String mloginFrm() {
		logger.info("loginFrm()"); {
			
			return "loginFrm"; 
		}
	}
	
	@GetMapping("/contents")
	public ModelAndView memberContents(Integer onum) {
		logger.info("memberContents() : onum - " + onum);
		
		mv = mServ.getMcontent(onum);
		
		return mv;
	}
	
	
	@GetMapping("/m_modify")
	public ModelAndView m_modify(String mid) {
		logger.info("m_modify() : mid - " + mid);	
		
		mv = mServ.mmodify(mid);
		
		return mv;
	}
	
	
	@PostMapping("/memberUpdate")
	public String memberUpdate (MultipartHttpServletRequest multi, RedirectAttributes rttr) {
		logger.info("memberUpdate()");
		
		String view = mServ.memberUpdate (multi, rttr);
		
		return view;
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		logger.info("logout()");
		
		String view = mServ.logout(session);
		
		return view;
	}
	
}
