package com.spring.ex.boradService;

import java.util.HashMap;

public class Pagination {
	private int listSize = 0;  //한 페이지 목록 개수 
	
	private int rangeSize = 10; //한 페이지 범위의 개수 초기값으로 페이지범위를 10으로 셋팅
	
	private int page; //현재페이지

	private int range; //현재 페이지 범위

	private int listCnt; //총 게시물의 개수

	private int pageCnt; // 총 페이지 범위의 개수

	private int startPage; //시작번호

	private int startList;	//디비 리스트조회 인덱스  

	private int endPage; // 끝번호

	private boolean prev; // 이전 페이지

	private boolean next; // 다음페이지

	private int product_id;
	
	
	public HashMap<String, String> pageInfo(int page,int range ,int ListCnt, int listSize) {
		HashMap<String, String> map = new HashMap<>();
		 
		this.listSize = listSize;
		
		this.startList = (page-1) * this.listSize;
		
		this.range = range;
		
		this.page = page;
		
		this.pageCnt = (int) Math.ceil((double)ListCnt/listSize);
		
		this.startPage = (range-1) * this.rangeSize +1;
		
		this.endPage = (range * this.listSize);
		
		this.prev = range == 1 ? false : true;
		
		this.next = endPage >= pageCnt ? false : true;
			if(this.endPage > this.pageCnt) {
				this.endPage = this.pageCnt;
				this.next = false;
				
			}
			
		map.put("listSize", String.valueOf(this.listSize));
		map.put("range", String.valueOf(this.range));
		map.put("page", String.valueOf(this.page));
		map.put("pageCnt", String.valueOf(this.pageCnt));
		map.put("startPage", String.valueOf(this.startPage));
		map.put("endPage", String.valueOf(this.endPage));
		map.put("prev", String.valueOf(this.prev));
		map.put("next", String.valueOf(this.next));
		map.put("startList", String.valueOf(this.startList));
		
		return map;
		
	}
	
	
	
	
	

}
