<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Inosys Sample Web Hompage</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<link rel="shortcut icon" href="#">
</head>
<script type="text/javascript">

	$(function(){
		var checkObj = document.getElementsByName("RowCheck");
		var rowCnt = checkObj.length;
		
		$("input[name='allCheck']").click(function(){
			var chk_listArr = $("input[name='RowCheck']");
			for(var i = 0; i < chk_listArr.length; i++){
				chk_listArr[i].checked = this.checked;
			}
		});
		$("input[name='RowCheck']").click(function(){
			if($("input[name='RowCheck']:checked").length == rowCnt){
				$("input[name='allCheck']")[0].checked = true;
			}else{	
				$("input[name='allCheck']")[0].checked = false;
			}
		});
	
	});
 	function deleteValue(){
		var valueArr = new Array();
		const list = $("input[name='RowCheck']");
		for(var i = 0; i < list.length; i++){
			if(list[i].checked){   //선택되어잇으면 배열에 저장
				valueArr.push(list[i].value);
				console.log("배열값 = "+valueArr);
			}
		}
		if(valueArr.length == 0){
			alert("선택된 글이 없습니다");
		}else{
			var chk = confirm("정말 삭제하시겠습니까?");
			if(chk){
				
			$.ajax({
				url : "./freeBoardDeleteMultiple.ino",
				data : {
					valueArr : valueArr
				},
				success: function(data){
					console.log(data);
					if(data.status == "SUCCESS"){
						alert(data.message);
						location.replace("./main.ino");
					}else{
						alert(data.message);
						location.reload();
					}
				}
				
			});
			}
		}
	  } 
	
</script>
<body>

	<div>
		<h1>자유게시판</h1>
	</div>
	<div style="width:650px;" align="right">
		<a href="./freeBoardInsert.ino">글쓰기</a>
	</div>
	<hr style="width: 600px;">
	<div style="padding-bottom: 10px;">
		<table border="1">
			<thead>
				<tr>
					<th scope="col"><input id="allCheck" type="checkbox" name="allCheck"/></th>
					<th scope="col" style="width: 55px; padding-left: 30px;" align="center">타입</th>
					<th scope="col" style="width: 50px; padding-left: 10px;" align="center">글번호</th>
					<th scope="col" style="width: 125px;" align="center">글제목</th>
					<th scope="col" style="width: 48px; padding-left: 50px;" align="center">글쓴이</th>
					<th scope="col" style="width: 100px; padding-left: 95px;" align="center">작성일시</th>
				</tr>
			</thead>
		</table>
	</div>
	<hr style="width: 600px;">

	<div>
		<table border="1">
			<tbody id="tb">
					<c:forEach var="dto" items="${freeBoardList }">
						<tr>
							<td><input name="RowCheck" type="checkbox" value="${dto.num }"/></td>
							<td style="width: 55px; padding-left: 30px;" align="center">${dto.codeType }</td>
							<td style="width: 50px; padding-left: 10px;" align="center">${dto.num }</td>
							<td style="width: 125px;" align="center"><a href="./freeBoardDetail.ino?num=${dto.num }">${dto.title }</a></td>
							<td style="width: 48px; padding-left: 50px;" align="center">${dto.name }</td>
							<td style="width: 100px; padding-left: 95px;" align="center">${dto.regdate }</td>
						<tr>
					</c:forEach>
			</tbody>
		</table>
		<input style="margin-top: 10px; float: right;" type="button" value="선택항목 삭제" class="btn_checkedDel" onclick="deleteValue();">
	</div>

</body>
</html>