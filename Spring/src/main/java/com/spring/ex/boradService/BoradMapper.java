package com.spring.ex.boradService;

import java.util.HashMap;
import java.util.List;

public interface BoradMapper {
  int userRandom(BoardVO paramBoardVO);
  
  List<HashMap> getUser(HashMap<String, String> paramHashMap);
  
  int countUser();
  
  int userArrDelete(List<String> paramList);
  
}
