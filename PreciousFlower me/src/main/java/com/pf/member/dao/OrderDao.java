package com.pf.member.dao;

import java.util.List;

import com.pf.member.dto.ListDto;
import com.pf.member.dto.OrderDto;

public interface OrderDao {
	
	//게시글 목록 가져오기
	List<OrderDto> MemberListSelect(ListDto list);
	
	//전체 글 개수 구하기
	int mcntSelect(ListDto list);
	
	//배송 상세 불러오기 
	OrderDto orderSelect(Integer onum);

}
