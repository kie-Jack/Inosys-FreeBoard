<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글 상세 보기</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.11.1/jquery.validate.js"></script>
<link rel="shortcut icon" href="#">
</head>
<script type="text/javascript">

	$(document).ready(function(){
		
		function setType(){
		const codeType = document.getElementById("codeType").value;
			if(codeType =='자유'){
			
				$('#c01').attr('selected','selected');
		
			}else if(codeType =='익명'){
				
				$('#c02').attr('selected','selected');
			
			}else{
				$('#c03').attr('selected','selected');
			}			
			
		}
		
		setType();
		
		});
	
		$(document).on("click","#delete_btn", function(){
			var yn = confirm("정말 삭제하시겠습니까?");
			if(yn){
				delItem();
				
			}
		});
		
		function delItem(){
			
			$.ajax({
				url : "./freeBoardDelete.ino",
				type: 'POST',
				data : {
					num : $("#num").val()
				},
				success: function(data){
					if(data.status == "SUCCESS"){
						alert(data.message);
						location.replace("./main.ino");
					}else{
						alert(data.message);
						location.reload();
					}
				}/* ,
				error : function(request, status, error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				} */
			});
		}
		$(document).on("click","#modify_btn", function(){
			const title = $("#title").val();
			const content = $("#content").val();
			const num = $("#num").val();
			
			if(title === ''){
				alert('제목을 입력해주세요.');
				document.frm1.title.focus();
				return;
			}
			if(content === ''){
				alert('내용을 입력해주세요.');
				document.frm1.content.focus();
				return;
			}
			
			var yn = confirm("게시글을 수정하시겠습니까?");
			if(yn){	
				$.ajax({
					url : "./freeBoardModify.ino",
					data : {
							num : $("#num").val(),
							title : $("#title").val(),
							content : $("#content").val()
					},
					success : function(data){
						
						if(data != null){
							alert('게시글 수정 완료');
							
							var result = confirm('메인화면으로 이동하시겠습니까?');
							if(result){
								location.href ='./main.ino';
							}else{
								location.href = './freeBoardDetail.ino?num='+data;
							}
						}
					},
					error : function(request, status, error){
						alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
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
	<form id = "frm1" name="insertForm">
		<input type="hidden" id="codeType" value="${freeBoardDto.codeType }" />
		<input type="hidden" id="num" value="${freeBoardDto.num }" />
		<table border="1">
			<tbody>
				<tr>
					<td style="width: 150px;" align="center">타입 :</td>
					<td style="width: 400px;">
						<select id="code">
							<option value="01" id="c01">자유</option>
							<option value="02" id="c02">익명</option>
							<option value="03" id="c03">QnA</option>
						</select>
					</td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">이름 :</td>
					<td style="width: 400px;"><input type="text" id = "name" name="name" value="${freeBoardDto.name }" readonly/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">제목 :</td>
					<td style="width: 400px;"><input type="text" id = "title" name="title"  value="${freeBoardDto.title }"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">내용 :</td>
					<td style="width: 400px;"><textarea id = "content" name="content" rows="25" cols="65"  >${freeBoardDto.content }</textarea></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
					<td align="right">
					<input type="button" value="수정" id = "modify_btn">
					<input type="button" value="삭제" id = "delete_btn" >
					<input type="button" value="취소" onclick="location.href='./main.ino'">
					&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
			</tfoot>
		</table>

	</form>


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