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
								     <table>
									     <tr>
									      <td align="center" width="200" style="position: relative; left : 300px; font-size:12px;">특정 컬럼 조회</td>
									     </tr>
								     </table>
								      <div id="" style="position:relative; left : 300px;  font-size:15px;">
								         <input onchange="onChange('userId','userIdChk');" id="userIdChk" type="checkbox" name="checkbox2" value="a.id" checked>아이디
								          <input onchange="onChange('userpw','userpwChk');" id="userpwChk" type="checkbox" name="checkbox2" value="a.name" checked>pw
								         <input onchange="onChange('username','usernameChk');" id="usernameChk" type="checkbox" name="checkbox2" value="a.name" checked>이름
								         <input onchange="onChange('useremail','useremailChk');" id="useremailChk" type="checkbox" name="checkbox2" value="a.email" checked>이메일
								         <input onchange="onChange('userdate','userdateChk');" id="userdateChk" type="checkbox" name="checkbox2" value="a.date" checked>날짜
								         <input onchange="onChange('useraddress','useraddressChk');" id="useraddressChk" type="checkbox" name="checkbox2" value=b.address checked>주소
								         <input onchange="onChange('userHeight','userHeighChk');" id="userHeighChk" type="checkbox" name="checkbox2" value=b.height checked>키
								         <input onchange="onChange('userweight','userweightChk');" id="userweightChk" type="checkbox" name="checkbox2" value=b.weight checked>몸무게
								     </div>
								     
                            	     <div id="html"></div>
                                <table id="datatablesSimple">
                                    <thead>
                                        <tr>
                                            <th id="userId">ID</th>
                                            <th id="userpw">PW</th>
                                            <th id="username">NAME</th>
                                            <th id="useremail">EMAIL</th>
                                            <th id="userdate">DATE</th>
                                            <th id="useraddress">주소</th>
                                            <th id="userHeight">키</th>
                                            <th id="userweight">몸무게</th>
                                        </tr>
                                    </thead>
                                    <tbody id="list">
                                       
                                    </tbody>
                                </table>
                               
                                <ul class="pagination">
								</ul>
                            </div>
                        </div>
</div>

<h1 style="visibility: hidden; font-size: 90px;">ex</h1>


<script>
 	let deleteColum = new Map();
	
	function onChange(param , selChk) {
		var test1 = document.getElementById(''+selChk+'').checked;
		if(test1 != true){
			deleteColum.set(param,selChk);
		$('[name="'+param+'"]').hide();
		$("#"+param+"").hide();			
		}
		else if(test1 == true){
			deleteColum.delete(param);
			$('[name="'+param+'"]').show();
			$("#"+param+"").show();			
		}
	}

	$(document).ready(function() {
		selUserList(1,1,1,10);
	});
	
	function checkboxGET() {
		var chkArray = new Array();
		
		 var obj_length = document.getElementsByName("checkbox").length;
		    for (var i=0; i<obj_length; i++) {
	            if (document.getElementsByName("checkbox")[i].checked == true) {
	                chkArray.push(document.getElementsByName("checkbox")[i].value);
	            }
		    }
		   selUserList(chkArray,1,1,10);
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
	function selUserList(chkArray,page,range,listSize) {
		var keyword = $("#keyword").val();
	    $(".dataTable-search").remove();
		$("#list").children().remove();
		$(".pagination").children().remove();
		
		var html = "";
		
	
		$.ajax({
		    type : 'POST',
		    url : '/board/getUser',
		    dataType: 'json',
		    data : { chkArray : chkArray , 
		    		 keyword : keyword, 
		    		 page : page, 
		    		 range : range,
		    		 listSize : listSize},
		    		 
		    error : function(error) {
		        alert("Error!" + error);
		    },
		    success : function(value) {
		    	var map = value.mapList;
		    	var count = value.count-1;
		    	for(var i = 0; i <map.length-1; i++){
		    		html += '<tr>';
			    	html += '<td name="userId">'+map[i].id+'<br><input type="checkbox" id="userId'+[i]+'" name="userId" value='+map[i].id+'></td>';
			    	html += '<td name="userpw">'+map[i].pw+'</td>';
			    	html += '<td name="username">'+map[i].name+'</td>';
			    	html += '<td name="useremail">'+map[i].email+'</td>';
			    	html += '<td name="userdate">'+map[i].date+'</td>';
			    	
			    	html += '<td name="useraddress">'+map[i].address+'</td>';
			    	html += '<td name="userHeight">'+map[i].Height+'</td>';
			    	html += '<td name="userweight">'+map[i].weight+'</td>';
			    	html += '</tr>';
		    	}
		    	$("#list").append(html);
		    	$("#userCount").children().remove();
		    	html2 = "<h5>현재 회원 목록 수 : "+count+"</h5>";
		    	$("#userCount").append(html2);
		    	
		    	for (let vegetable of deleteColum.keys()) {
		    		$('[name="'+vegetable+'"]').hide();
		    		$("#"+vegetable+"").hide();		
		    	}
		    	
		    	var pageNa = map[map.length-1];
		    	
		    	pageNation(pageNa.startPage,pageNa.endPage,pageNa.range,pageNa.listSize,pageNa.prev,pageNa.next);
		    } 
		})
	}
	function pageNation(startPage , endPage , range , listSize, prev ,next) {
		 var pagaNationN = "";
		 if(prev == "true"){
		 pagaNationN += '<li class="btn"><a onclick="goPrev('+range+','+listSize+');" style="color: red" href="#"> << </a></li>';			 
		 }
		 
		for(var i = startPage; i<=endPage; i++){
			pagaNationN += '<li class="btn"><a onclick="goPage('+i+','+range+','+listSize+');" style="color: red" href="#">'+i+'</a></li>';
		}
		if(next == "true"){
		pagaNationN += '<li class="btn"><a onclick="goNext('+range+','+listSize+');" style="color: red" href="#"> >> </a></li>';
		}
			$(".pagination").append(pagaNationN);		
	}
	function goPage(page, range, listSize) {
		selUserList(1,page,range,listSize)
	}
	function goPrev(range, listSize) {
		var page = (range -1) * listSize;
		var range = range - 1;
		selUserList(1,page,range,listSize)
	}
	function goNext(range, listSize) {
		var page =  range * listSize+1;
		range = range + 1;
		selUserList(1,page,range,listSize)
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