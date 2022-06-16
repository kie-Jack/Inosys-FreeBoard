<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
 
    request.setCharacterEncoding("UTF-8");
 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.11.1/jquery.validate.js"></script>
<link rel="shortcut icon" href="#">
</head>
<script type="text/javascript">

$(document).on('click','#btnInsert', function(e){
	const name = $("#name").val().trim();
	const title = $("#title").val().trim();
	const content = $("#content").val().trim();
	const codeType = $("#codeType option:selected").val();
	
	if(name === ''){
		alert('이름을 입력해주세요.');
		return;
	}
	if(title === ''){
		alert('제목을 입력해주세요.');
		return;
	}
	if(content === ''){
		alert('내용을 입력해주세요.');
		return;
	}
	
	var yn = confirm("게시글을 등록하시겠습니까?");
	if(yn){	
		$.ajax({
			url : "./freeBoardInsertPro.ino",
			data : {
					codeType : $("#codeType option:selected").val(),
					name : $("#name").val(),
					title : $("#title").val(),
					content : $("#content").val()
			},
			success : function(data){
				console.log(data.message);
				if(data.status == "SUCCESS"){
					alert(data.message);
					var result = confirm('메인화면으로 이동하시겠습니까?');
					if(result){
						location.href ='./main.ino';
					}else{
						location.href = './freeBoardDetail.ino?num='+data;
					}
					
				}else{
					alert(data.message);
					location.href = './freeBoardInsert.ino';
					
				}
			}
			
			
	})
}			
				
});
</script>
<body>
	<div>
		<h1>자유게시판</h1>
	</div>
	<div style="width:650px;" align="right">
		<a href="./main.ino">리스트로</a>
	</div>
	<hr style="width: 600px">

	<form id = "frm1" action="./freeBoardInsertPro.ino" method ="POST" accept-charset="utf-8">
	<input type = "hidden" id = "num" value ="${freeBoardDto.num} }" />
		<table border="1">
			<tbody>
				<tr>
					<td style="width: 150px;" align="center">타입 :</td>
					<td style="width: 400px;">
						<select id = "codeType">
							<option value="01">자유</option>
							<option value="02">익명</option>
							<option value="03">QnA</option>
						</select>
					</td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">이름 :</td>
					<td style="width: 400px;"><input type="text" name="name" id="name" placeholder="ex. 홍길동"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">제목 :</td>
					<td style="width: 400px;"><input type="text" name="title"id="title" placeholder="ex. 안녕하세요"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">내용 :</td>
					<td style="width: 400px;"><textarea name="content" id="content" rows="25" cols="65"></textarea></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
					<td align="right">
					<input type="button" value="글쓰기" id = "btnInsert">
					<input type="button" value="다시쓰기" id = "btnReset" onclick="reset()">
					<input type="button" value="취소" onclick="location.href='javascript:history.back()'">
					&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
			</tfoot>
		</table>

	</form>



</body>
</html>