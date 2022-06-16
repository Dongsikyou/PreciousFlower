package com.pf.member.dao;

import com.pf.member.dto.MemberDto;

public interface MemberDao {
	
	//비밀번호 구하기
	public String pwdSelect(String id);
	
	//회원 정보 구하기
	public MemberDto memberSelect(String m_id);
	
	//아이디 체크 메소드
	public int idCheck(String m_id);
	
	//회원 가입
	public void memberInsert(MemberDto member);
	
	//회원 정보 불러오기
	public MemberDto memberselect(String mid);
	
	//회원 정보 업데이트
	public void memberUpdate(MemberDto member);

}


