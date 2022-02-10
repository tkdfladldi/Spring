 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <div class="container-fluid px-4">
                        <ol class="breadcrumb mb-4">
                  
                        </ol>
                     
                       
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                DataTable Example
                            </div>
                            <div class="card-body">
                            	        
                            	<button class="btn btn-primary" id="userRandom" onclick="userRandom();">회원 생성버튼</button>
                            	 	<button class="btn btn-primary" id="userRandom" onclick="usersDelete();">체크 회원 삭제</button>
                            	<div id="userCount"></div>
                            	 <table cellpadding="0" cellspacing="0" style="cursor:pointer" onClick="openEndClose();">
										       <tr>
										        <td align="center" width="200" style="border:1px solid;font-size:12px;">다중 검색하기</td>
										        <td><input type="button" value="▼" onclick=""></td>
										       </tr>
										   </table>
										   

								     <div id="Div" style="position:absolute;visibility:hidden;font-size:15px;">
								      <ul id="ul">
								         <li id="li"><input type="checkbox" name="checkbox" value="a.id">아이디</li>
								         <li id="li"><input type="checkbox" name="checkbox" value="a.name">이름</li>
								         <li id="li"><input type="checkbox" name="checkbox" value="a.email">이메일</li>
								         <li id="li"><input type="checkbox" name="checkbox" value="a.date">날짜</li>
								         <li id="li"><input type="checkbox" name="checkbox" value=b.address>주소</li>
								         <li id="li"><input type="checkbox" name="checkbox" value=b.height>키</li>
								         <li id="li"><input type="checkbox" name="checkbox" value=b.weight>몸무게</li>
								        </ul>    
								            <input id="keyword" placeholder="검색어 입력.." class="dataTable-input" style="position: relative; top: 10px;" type="text">
								     		<button class="btn btn-primary" style="position:relative; left: 210px; bottom: 25px;" onclick="checkboxGET();">검색하기</button>
								     </div>
								     
                            	     <div id="html"></div>
                                <table id="datatablesSimple">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>PW</th>
                                            <th>NAME</th>
                                            <th>EMAIL</th>
                                            <th>DATE</th>
                                            <th>주소</th>
                                            <th>키</th>
                                            <th>몸무게</th>
                                        </tr>
                                    </thead>
                                    <tbody id="list">
                                       
                                    </tbody>
                                </table>
                            </div>
                        </div>
</div>

<h1 style="visibility: hidden; font-size: 90px;">ex</h1>


<script>

	$(document).ready(function() {
		selUserList(1);
	});
	
	function checkboxGET() {
		var chkArray = new Array();
		
		 var obj_length = document.getElementsByName("checkbox").length;
		    for (var i=0; i<obj_length; i++) {
	            if (document.getElementsByName("checkbox")[i].checked == true) {
	                chkArray.push(document.getElementsByName("checkbox")[i].value);
	            }
		    }
		   selUserList(chkArray);
	}

 	var count = 2;
 	
	function multiSelect(count){
			$("#html").children().remove();
			var html = "<h1 style='visibility: hidden; font-size: 120px;'>ex</h1>"
			var cal = count % 2;
		   if(cal == 0){
			   Div.style.visibility="visible";
			   $("#html").append(html);
		   }
		   else Div.style.visibility="hidden";
		  }
	function openEndClose() {
		multiSelect(count);
		count += 1;
		
	}
	function selUserList(chkArray) {
		var keyword = $("#keyword").val();
	    $(".dataTable-search").remove();
		$("#list").children().remove();
		var html = "";
		
		$.ajax({
		    type : 'POST',
		    url : '/board/getUser',
		    dataType: 'json',
		    data : { chkArray : chkArray , keyword : keyword},
		    error : function(error) {
		        alert("Error!" + error);
		    },
		    success : function(value) {
		    	var map = value.mapList;
		    	var count = value.count;
		    	for(var i = 0; i <map.length; i++){
		    		html += '<tr>';
			    	html += '<td>'+map[i].id+'<br><input type="checkbox" id="userId'+[i]+'" name="userId" value='+map[i].id+'></td>';
			    	html += '<td>'+map[i].pw+'</td>';
			    	html += '<td>'+map[i].name+'</td>';
			    	html += '<td>'+map[i].email+'</td>';
			    	html += '<td>'+map[i].date+'</td>';
			    	
			    	html += '<td>'+map[i].address+'</td>';
			    	html += '<td>'+map[i].Height+'</td>';
			    	html += '<td>'+map[i].weight+'</td>';
			    	html += '</tr>';
		    	}
		    	$("#list").append(html);
		    	$("#userCount").children().remove();
		    	html2 = "<h5>현재 회원 목록 수 : "+count+"</h5>";
		    	$("#userCount").append(html2);
		    }
		})
	}
	

	function usersDelete() {
		var chkArray = new Array();
		
		 var obj_length = document.getElementsByName("userId").length;
		 
		 
		    for (var i=0; i<obj_length; i++) {
	            if (document.getElementsByName("userId")[i].checked == true) {
	                chkArray.push(document.getElementsByName("userId")[i].value);
	            }
		    }
		    
		 if(chkArray.length <= 0){
			 
			 alert("삭제 할 유저를 체크하세요.");
			 $('#userId0').focus();
			 return
		 }
		    
		    $.ajax({
			    type : 'Post',
			    url : '/userArr/Delete',
			    dataType: 'json',
			    data : { userArr : chkArray },
			    error : function(error) {
			        alert("Error!");
			    },
			    success : function(value) {
			    	if(value >= 1){
			    		location.reload();
				    	alert(value + " 개수 삭제 성공");
				    
			    	}else{
			    		alert("삭제 실패");
			    	}
			    }
			})
	}
	
	function userRandom() {
		
		var data = {};
		data.id = randomId(5);
		data.name = random_hangul();
		data.email = randomEmail(data.id);
		
		
		$.ajax({
		    type : 'Post',
		    url : '/board/userRandom',
		    data : data,
		    error : function(error) {
		        alert("Error!");
		    },
		    success : function(value) {
		    	if(value >= 1){
		    		location.reload();
			    	alert("등록 성공");
			    
		    	}else{
		    		alert("등록 실패");
		    	}
		    }
		})
		
	
	}
	function randomId(length) {
		   var result           = '';
		   var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
		   var charactersLength = characters.length;
		   for ( var i = 0; i < length; i++ ) {
		      result += characters.charAt(Math.floor(Math.random() * charactersLength));
		   }
		   return result;
	}
	
	function random_hangul() {
		var str = '';
		for(var i =0; i<3; i++){
			str += String.fromCharCode( 44031 + Math.ceil( 11172 * Math.random() ) );
		}
			
		 return str;
	}
	function randomEmail(id) {
		var randomEmail = '';
		
		var num = Math.floor(Math.random() * 4);
		
		switch (num) {
		  case 0:
			  randomEmail += "naver.com";
		    break;
		  case 1:
			  randomEmail +=  "google.co.kr";
		    break;
		  case 2:
			  randomEmail +=  "daum.net";
		    break;
		  case 3:
			  randomEmail +=  "netmarble.net";
			break;
		    
		  default:
		    alert( "어떤 값인지 파악이 되지 않습니다." );
		}
		email = id+"@"+randomEmail;
		
		return email;
	}


		

</script>