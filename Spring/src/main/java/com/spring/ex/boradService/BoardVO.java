package com.spring.ex.boradService;

public class BoardVO {
  String id;
  
  String pw;
  
  String name;
  
  String email;
  
  String date;
  
  public String getId() {
    return this.id;
  }
  
  public void setId(String id) {
    this.id = id;
  }
  
  public String getPw() {
    return this.pw;
  }
  
  public void setPw(String pw) {
    this.pw = pw;
  }
  
  public String getName() {
    return this.name;
  }
  
  public void setName(String name) {
    this.name = name;
  }
  
  public String getEmail() {
    return this.email;
  }
  
  public void setEmail(String email) {
    this.email = email;
  }
  
  public String getdate() {
    return this.date;
  }
  
  public void setdate(String date) {
    this.date = date;
  }
  
  public String toString() {
    return "BoardVO [id=" + this.id + ", pw=" + this.pw + ", name=" + this.name + ", email=" + this.email + ", date=" + this.date + "]";
  }
}
