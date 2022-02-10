package com.spring.ex.boradService;

import java.time.LocalDateTime;

import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BoardDAO {
  @Autowired
  SqlSession ss;
  
  public int userRandom(HttpServletRequest req) {
    String id = req.getParameter("id");
    String name = req.getParameter("name");
    String email = req.getParameter("email");
    BoardVO boardVO = new BoardVO();
    boardVO.setId(id);
    boardVO.setPw(randomPw(6));
    boardVO.setName(name);
    boardVO.setEmail(email);
    LocalDateTime now = LocalDateTime.now();
    String formatedNow = now.format(DateTimeFormatter.ofPattern("yyyy년MM월dd일 HH시mm분ss초"));
    boardVO.setdate(formatedNow);
    int resultNum = ((BoradMapper)this.ss.getMapper(BoradMapper.class)).userRandom(boardVO);
    return resultNum;
  }
  
  public String randomPw(int len) {
    String str = "";
    for (int i = 0; i < len; i++) {
      int ranNum = (int)(Math.random() * 2.0D) + 1;
      if (ranNum == 1) {
        str = String.valueOf(str) + String.valueOf((int)(Math.random() * 9.0D) + 1);
      } else {
        char ch = (char)(int)(Math.random() * 26.0D + 97.0D);
        str = String.valueOf(str) + ch;
      } 
    } 
    return str;
  }
  
  public List<HashMap> getUser(HttpServletRequest req) {
    HashMap<String, String> map = new HashMap<>();
    String[] arrayParam = req.getParameterValues("chkArray[]");
    String keyword = req.getParameter("keyword");
    if (arrayParam != null) {
      String sql = sqlCal(arrayParam, keyword);
      map.put("sql", sql);
    } 
    try {
      List<HashMap> param = ((BoradMapper)this.ss.getMapper(BoradMapper.class)).getUser(map);
      return param;
    } catch (Exception e) {
      System.out.println("error");
      return null;
    } 
  }
  
  public int countUser() {
    int count = ((BoradMapper)this.ss.getMapper(BoradMapper.class)).countUser();
    return count;
  }
  
  public int userArrDelete(List<String> userArr) {
    return ((BoradMapper)this.ss.getMapper(BoradMapper.class)).userArrDelete(userArr);
  }
  
  public String sqlCal(String[] arrayParam, String keyword) {
    arrayParam = xssFilterRemove(arrayParam);
    keyword = xssFilterRemove(keyword);
    int length = arrayParam.length;
    String sql = "where " + arrayParam[0] + " Like concat('%','" + keyword + "','%')";
    if (length > 1)
      for (int i = 1; i < arrayParam.length; i++)
        sql = String.valueOf(sql) + " OR " + arrayParam[i] + " Like concat('%','" + keyword + "','%')";  
    return sql;
  }
  
  public String[] xssFilterRemove(String[] filter) {
    for (int i = 0; i < filter.length; i++)
      filter[i] = xssFilterRemove(filter[i]); 
    return filter;
  }
  
  public String xssFilterRemove(String filter) {
    filter = filter.replaceAll("<", "&lst;").replaceAll(">", "&gt;");
    filter = filter.replaceAll("\\(", "&#40;").replaceAll("\\)", "&#41;");
    filter = filter.replaceAll("'", "&#39;");
    filter = filter.replaceAll("eval\\((.*)\\)", "");
    filter = filter.replaceAll("[\\\"\\'][\\s]*javascript:(.*)[\\\"\\']", "\"\"");
    filter = filter.replaceAll("script", "");
    return filter;
  }
}
