package com.pf.member.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pf.member.dao.MemberDao;
import com.pf.member.dao.OrderDao;
import com.pf.member.dto.ListDto;
import com.pf.member.dto.MemberDto;
import com.pf.member.dto.OrderDto;
import com.pf.util.MailUtils;
import com.pf.util.PagingUtil;
import com.pf.util.tempKey;

import lombok.extern.java.Log;

@Service
@Log
public class MemberService {
	
	@Autowired
	private MemberDao mDao;
	
	@Autowired
	private OrderDao oDao;
	
	@Autowired
	private JavaMailSender mailSender;
	
	private BCryptPasswordEncoder pwdEncoder;
	
	private ModelAndView mv;
	
	private int listCnt = 5; //페이지 당 출력할 게시글 개수
	
	//로그인 처리 서비스 메소드
	public String m_loginProc(MemberDto mem, HttpSession session,
			RedirectAttributes rttr) {
		String view = null;
		String msg = null;
		
		//회원의 비밀번호 구하기
		String pwd = mDao.pwdSelect(mem.getM_id());
		
		if(pwd != null) {
			//존재하는 아이디
			if(pwd.matches(mem.getM_pwd())) {
				//세션에 DTO 저장
				session.setAttribute("mb", mem);
				
				//로그인 성공 후 메인으로 이동
				view = "redirect:/";
				msg = "로그인 성공";
			} else {
				view = "redirect:/loginFrm";
				msg = "비밀번호 오류";
			}
		}
		else {
			//아이디가 존재하지 않는 경우
			view = "redirect:/loginFrm";
			msg = "없는 아이디";
		}
		
		rttr.addFlashAttribute("msg", msg);
		
		return view;
	}

	public String idCheck(String m_id) {
		String res = null;
		
		//아이디가 중복이면 1, 아니면 0.
		int cnt = mDao.idCheck(m_id);
		
		if(cnt == 0) {
			res = "ok";
		}
		else {
			res = "not";
		}
		
		return res;
		
		
	}
	
	public String memberInsert(MemberDto member,
			RedirectAttributes rttr) {
		String view = null;
		String msg = null;
		
		
		
		String encpwd = pwdEncoder.encode(member.getM_pwd());
		log.info("encpwd : " + encpwd);
		member.setM_pwd(encpwd);
		
		
		try {
			mDao.memberInsert(member);
			
			view = "redirect:/";
			msg = "가입 성공";
		} catch (Exception e) {
			e.printStackTrace();
			
			view = "redirect:/joinFrm";
			msg = "가입 실패";
		}
		
		rttr.addFlashAttribute("msg", msg);
		
		return view;
	}
	//로그아웃 처리 메소드
		public String logout(HttpSession session) {
			String view = "redirect:/";
			
			session.invalidate();
			
			return view;
		}

		public ModelAndView getMemberList(ListDto list, HttpSession session) {
			mv = new ModelAndView();
			
			int num = list.getPageNum();
			if(num == 0) num = 1;
			list.setPageNum((num - 1) * listCnt);
			list.setListCnt(listCnt);
			
			List<OrderDto> mList = oDao.MemberListSelect(list);
			
			mv.addObject("mList", mList);

			//페이징 처리
			list.setPageNum(num);
			String pageHtml = getPaging(list);

			mv.addObject("paging", pageHtml);
			//addObject(String name, Object value)
			//뷰에 전달할 값을 설정

			session.setAttribute("pageNum", list.getPageNum());
			if(list.getColname() != null ) {
				session.setAttribute("list", list);
			}
			else {
				session.removeAttribute("list");
			}

			mv.setViewName("m_main");

			return mv;
		}
			
			private String getPaging(ListDto list) {
				String pageHtml = null;

				//전체 글 개수 구하기
				int maxNum = oDao.mcntSelect(list);
				//한 페이지 당 보여질 페이지 번호의 개수
				int pageCnt = 5;
				String listName = "mlist?";

				//검색 용 컬럼명과 검색어를 추가
				if(list.getColname() != null) {
					listName += "colname=" + list.getColname()
					+ "&keyword=" + list.getKeyword() + "&";
				}
				PagingUtil paging = new PagingUtil
						(maxNum, list.getPageNum(),	listCnt, pageCnt, listName);

				pageHtml = paging.makePaging();

				return pageHtml;
			}

			public ModelAndView getMcontent(Integer onum) {
				mv = new ModelAndView(); 

				//배송 상세 내용 가져오기

				OrderDto order = oDao.orderSelect(onum);

				mv.addObject("order", order);

				mv.setViewName("m_contents");

				return mv;
			}
			
			public ModelAndView mmodify(String mid) {
				mv = new ModelAndView();

				MemberDto memberList = mDao.memberSelect(mid);

				mv.addObject("memberList", memberList);

				mv.setViewName("m_modify");

				return mv;
			}
			
			@Transactional 
			public String memberUpdate(MultipartHttpServletRequest multi, RedirectAttributes rttr) {
				String view = null;
				String msg = null;

				String mid = multi.getParameter("mid");

				//getparameter는 name 값을 가져올 수 있음
				MemberDto member = new MemberDto();
				member.setM_id(mid);
				member.setM_pwd(multi.getParameter("m_pwd"));
				member.setM_name(multi.getParameter("m_name"));
				member.setM_phone(multi.getParameter("m_phone"));
				member.setM_addr1(multi.getParameter("m_addr1"));
				member.setM_addr2(multi.getParameter("m_addr2"));
				member.setM_addr3(multi.getParameter("m_addr3"));
				member.setM_email(multi.getParameter("m_email"));
				member.setM_gcode(multi.getParameter("m_gcode"));
				
				try {

					mDao.memberUpdate(member);

					view = "redirect:/m_myPage";
					msg = "수정 성공";

				} catch (Exception e) {
					e.printStackTrace();

					view = "redirect:/m_modify";
					msg = "수정 실패";
				}

				rttr.addFlashAttribute("msg", msg);

				return view;
			}
			public String emailConfirm(String memberemail) {
				String key = null;

				try {
					// 인증키 생성
					key = new tempKey().getKey(10, false); //위에서 String 선언해주면 밑에서 다시 선언할 필요가 없다. 
					log.info("인증번호 : " + key);


					// 메일 발송
					MailUtils sendMail = new MailUtils(mailSender);

					sendMail.setSubject("[회원가입 서비스 이메일 인증 입니다.]");
					sendMail.setText(new StringBuffer().append("<h1>라이더 가입 메일인증 입니다</h1>")
							.append("<br><br>")
							.append("홈페이지를 방문해주셔서 감사합니다")
							.append("<br><br>")
							.append("인증번호는 ").append(key) .append("입니다.")
							.append("<br><br>")
							.append("해당 인증번호를 인증번호 확인란에 기입해주세요.").toString());
					sendMail.setFrom("glc0420@gmail.com", "PreciousFlower");
					sendMail.setTo(memberemail);
					sendMail.send();

					log.info("이메일 : " + memberemail);

				} catch (Exception e) {
					e.printStackTrace();
				}
				return key;
			}



	
		}

		
		
	


