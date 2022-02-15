package com.spring.ex.boradService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class BoardController {
  @Autowired
  BoardDAO nDAO;
   
  @ResponseBody
  @RequestMapping(value = {"/board/userRandom"}, method = {RequestMethod.POST})
  public int userRandom(HttpServletRequest req) {
    int resultNum = this.nDAO.userRandom(req);
    return resultNum;
  }
  
  @ResponseBody
  @RequestMapping(value = {"/board/getUser"}, method = {RequestMethod.POST})
  public Map<String, Object> getUser(HttpServletRequest req) {
    List<Map<String, Object>> param = this.nDAO.getUser(req);
    int count = param.size();
    Map<String, Object> mapList = new HashMap<>();
    mapList.put("mapList", param);
    mapList.put("count", Integer.valueOf(count));
    return mapList;
  }
  
  @ResponseBody
  @RequestMapping(value = {"/userArr/Delete"}, method = {RequestMethod.POST})
  public int userArrDelete(HttpServletRequest req, @RequestParam("userArr[]") List<String> userArr) {
    int result = this.nDAO.userArrDelete(userArr);
    return result;
  }
}
