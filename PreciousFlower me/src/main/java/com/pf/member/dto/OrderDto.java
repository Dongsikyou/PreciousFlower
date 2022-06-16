package com.pf.member.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class OrderDto {
	
	private int o_num;
	private String o_mid;
	private String o_pcode;
	private String o_rnum;
	private Timestamp o_date;
	private int o_count;
	private String o_rec;
	private String o_phone;
	private String o_addr1;
	private String o_addr2;
	private String o_addr3;
	private int o_price;
	private String o_type;
	private String o_status;
	

}
