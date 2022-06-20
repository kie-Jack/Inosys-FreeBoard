<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Inosys Sample Web DetailPage</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.11.1/jquery.validate.js"></script>
</head>
<script type="text/javascript">
$(document).ready(function(){
	
		function getCodeType(){
			const codeType = document.getElementById("codeType").value;
			
				if(codeType =='자유'){
					$('#code1').attr('selected','selected');
				}else if(codeType =='익명'){
					$('#code2').attr('selected','selected');
				}else{
					$('#code3').attr('selected','selected');
				}
		}
		getCodeType();
		});
		
		$(document).on("click","#btnModify", function(){
			const num = $("#num").val();
			const title = $("#title").val();
			const content = $("#content").val();
			
			if(title === ''){
				alert("제목을 입력해주세요.");
				return;
			}
			if(content === ''){
				alert("내용을 입력해주세요.");
				return;
			}
			
			var yn = confirm("게시물을 이대로 수정하시겠습니까?");
			
			if(yn){
			$.ajax({
				url : "./freeBoardModify.ino",
				data : {
					num : $("#num").val(),
					title : $("#title").val(),
					content : $("#content").val()
				},
				success : function(data){
					if(data.status){
						alert("게시물이 수정 되었습니다.");
						var after = confirm("메인화면으로 가시겠습니까?");
						
						if(after){
							location.href = './main.ino';
						}else{
							location.href = './freeBoardDetail.ino?num='+data.num;
						}
					}else if(data.status = false){
						alert(data.message);
					}
				}
			});
			}
		}); 
		$(document).on("click","#btnDelete", function(){
			var yn = confirm("정말 게시글을 삭제 하시겠습니까?");
			if(yn){
				deleteOne();
			}
		});
		function deleteOne(){
			$.ajax({
				url : "./freeBoardDelete.ino",
				data : {
					num : $("#num").val()
				},
				success : function(data){
					if(data.status){
						alert("게시물이 삭제되었습니다.");
						location.replace('./main.ino');
					}else if(data.status = false){
						alert(data.message);
					}
				}
			});
		}
		 
	
</script>
<body>

	<div>
		<h1>자유게시판</h1>
	</div>
	<div style="width:650px;" align="right">
		<a href="./main.ino">리스트로</a>
	</div>
	<hr style="width: 600px">
		<input type="hidden" id="codeType" value="${freeBoardDto.codeType }" />
		<input type="hidden" id="num" value="${freeBoardDto.num }" />
		<table border="1">
			<tbody>
				<tr>
					<td style="width: 150px;" align="center">타입 :</td>
					<td style="width: 400px;">
						<select id="codeType">
							<option id= "code1" value="01">자유</option>
							<option id= "code2" value="02">익명</option>
							<option id= "code3" value="03">QnA</option>
						</select>
					</td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">이름 :</td>
					<td style="width: 400px;"><input type="text" name="name" id="name" value="${freeBoardDto.name }" readonly/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">제목 :</td>
					<td style="width: 400px;"><input type="text" name="title" id="title"  value="${freeBoardDto.title }"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">내용 :</td>
					<td style="width: 400px;"><textarea name="content" id="content" rows="25" cols="65"  >${freeBoardDto.content }</textarea></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
					<td align="right">
					<input type="button" value="수정" id="btnModify">
					<input type="button" value="삭제" id="btnDelete">
					<input type="button" value="취소" onclick="location.href='./main.ino'">
					&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
			</tfoot>
		</table>



<%-- 	<input type="hidden" name="num" value="${freeBoardDto.num }" />

		<div style="width: 150px; float: left;">이름 :</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" name="name" value="${freeBoardDto.name }" readonly/></div>

		<div style="width: 150px; float: left;">제목 :</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" name="title"  value="${freeBoardDto.title }"/></div>

		<div style="width: 150px; float: left;">작성날자</div>
		<div style="width: 500px; float: left;" align="left"><input type="text" name="regdate"  value="${freeBoardDto.regdate }"/></div>

		<div style="width: 150px; float: left;">내용 :</div>
		<div style="width: 500px; float: left;" align="left"><textarea name="content" rows="25" cols="65"  >${freeBoardDto.content }</textarea></div>
		<div align="right">
		<input type="button" value="수정" onclick="modify()">
		<input type="button" value="삭제" onclick="location.href='./freeBoardDelete.ino?num=${freeBoardDto.num }'">

		<input type="button" value="취소" onclick="location.href='./main.ino'">
		&nbsp;&nbsp;&nbsp;
		</div> --%>

</body>
</html>