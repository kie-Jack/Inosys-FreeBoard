<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Inosys Sample Web InsertPage</title>
</head>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.11.1/jquery.validate.js"></script>
<script type="text/javascript">

$(document).on('click','#btnInsert', function(e){
	
		const codeType = $("#codeType option:selected").val();
		const name = $("#name").val().trim();
		const title = $("#title").val().trim();
		const content = $("#content").val().trim();
		
		if(name === ''){
			alert("이름을 입력해주세요");
			return;
		}
		if(title === ''){
			alert("제목을 입력해주세요");
			return;
		}
		if(content === ''){
			alert("내용을 입력해주세요");
			return;
		}
		
		var yn = confirm("게시물을 등록하시겠습니까?");
		
		if(yn){
			$.ajax({
				url: "./freeBoardInsertPro.ino",
				data:{
					codeType: $("#codeType option:selected").val(),
					name : $("#name").val(),
					title : $("#title").val(),
					content : $("#content").val()
				},
				success: function(data){
					if(data.status){
						alert("게시물이 등록되었습니다.")
						var after = confirm("메인화면으로 가시겠습니까?")
						if(after){
							location.href="./main.ino";
						}else{
							location.href="./freeBoardDetail.ino?num="+data.num;
						}
					}else if(data.status = false){
						alert(data.message);
					}
				}
			});
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


		<table border="1">
			<tbody>
				<tr>
					<td style="width: 150px;" align="center">타입 :</td>
					<td style="width: 400px;">
						<select id="codeType">
							<option value="01">자유</option>
							<option value="02">익명</option>
							<option value="03">QnA</option>
						</select>
					</td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">이름 :</td>
					<td style="width: 400px;"><input type="text" name="name" id="name"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">제목 :</td>
					<td style="width: 400px;"><input type="text" name="title" id="title"/></td>
				</tr>
				<tr>
					<td style="width: 150px;"align="center">내용 :</td>
					<td style="width: 400px;"><textarea name="content" rows="25" cols="65" id="content"></textarea></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td></td>
					<td align="right">
					<input type="button" value="글쓰기" id="btnInsert">
					<input type="button" value="다시쓰기" onclick="reset()">
					<input type="button" value="취소" onclick="location.href='javascript:history.back()'">
					&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
			</tfoot>
		</table>




</body>
</html>