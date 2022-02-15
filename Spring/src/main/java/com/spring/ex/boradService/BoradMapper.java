package com.spring.ex.boradService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface BoradMapper {
  int userRandom(BoardVO paramBoardVO);
  
//  List<HashMap> getUser(HashMap<String, String> paramHashMap);
  List<Map<String,Object>> getUser(Map<String,Object> pa);
  
  int countUser();
  
  int userArrDelete(List<String> paramList);
  
  int countJoinUser(Map<String,Object> pa);
  
}
