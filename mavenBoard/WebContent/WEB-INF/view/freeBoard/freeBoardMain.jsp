<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Inosys Sample Web HomePage</title>
</head>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.11.1/jquery.validate.js"></script>
<script type="text/javascript">
	$(function(){
		var chkBox = document.getElementsByName("RowCheck");
		var cntAll = chkBox.length;
		
		$("input[name='allCheck']").click(function(){
			var chkBoxList = $("input[name='RowCheck']");
			for(var i=0; i<chkBoxList.length; i++){
				chkBoxList[i].checked = this.checked;
			}
		});
		$("input[name='RowCheck']").click(function(){
			if($("input[name='RowCheck']:checked").length == cntAll){
				$("input[name='allCheck']")[0].checked = true;
			}else{
				$("input[name='allCheck']")[0].checked = false;
			}
		});
		
	});
		function deleteChecked(){
			var valueArr = new Array();
			const list = $("input[name='RowCheck']");
			for(var i=0; i< list.length; i++){
				if(list[i].checked){
					valueArr.push(list[i].value);
					console.log("저장된 값들" + valueArr);
				}
			}
			if(valueArr.length == 0){
				alert("최소 하나의 글은 선택 되어야 합니다.");
			}else{
					var yn = confirm("정말 선택된 항목(들)을 삭제하시겠습니까?");
					if(yn){
						$.ajax({
							url : './freeBoardMultiDelete.ino',
							data : {
								valueArr : valueArr
							},
							success : function(data){
								if(data.status){
									alert("선택 항목(들)이 삭제되었습니다.")
									location.reload();
								}else if(data.status = false){
									alert(data.message);
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
	<form id = "searchForm" name = "searchForm" onsubmit="return false;" method="GET">
	<div id = "divSearch" name = "divSearch" class = "divSearch">
		<select name="searchType" id="searchType" onchange="getSearchType();">
			<option value="0" selected="selected">전체</option>
			<option value="1">타입</option> <!-- selectbox -->
			<option value="2">글쓴이</option> <!-- input type text -->
			<option value="3">글제목</option> <!-- input type text -->
			<option value="4">글내용</option> <!-- input type text -->
			<option value="5">글번호</option> <!-- input type text 검색버튼 클릭시 숫자인지 체크할것, -->
			<option value="6">기간</option> <!-- input type text X 2 검색버튼 클릭시 숫자인지 체크할것,자릿수 8자리 ex)20220620 -->
		</select>
			<select name="s_selectCode" id="s_selectCode">
				<option value="01">자유</option>
				<option value="02">익명</option>
				<option value="03">QnA</option>
			</select>
			
			<input type = "text" name = "searchByKeyword" id = "searchByKeyword"/>
			<input type = "text" name = "searchByNum" id = "searchByNum" placeholder="글 번호로 검색"/>
			
			<div class = "divDate" id = "divDate" name = "divDate">
			<input type="text" name="sDate" id="sDate" maxlength='8' placeholder="ex.20201127"/>
			~
			<input type="text" name="eDate" id="eDate" maxlength='8' placeholder="ex.20220620"/>
			</div>
		<button name="btnSearch" id="btnSearch">검색</button>
	</div>
	</form>
	<hr style="width: 600px;">
	<div style="padding-bottom: 10px;">
		<table border="1">
			<thead>
				<tr>
					<th scope="col"><input type="checkbox" name="allCheck"/></th>
					<th style="width: 55px; padding-left: 30px;" align="center">타입</th>
					<th style="width: 50px; padding-left: 10px;" align="center">글번호</th>
					<th style="width: 125px;" align="center">글제목</th>
					<th style="width: 48px; padding-left: 50px;" align="center">글쓴이</th>
					<th style="width: 100px; padding-left: 95px;" align="center">작성일시</th>
				</tr>
			</thead>
		</table>
	</div>
	<hr style="width: 600px;">

	<div>
		<table id="listTable" border="1">
			<tbody id="tb" name="tb">
					<c:forEach var="dto" items="${freeBoardList }">
						<tr>
							<td><input name="RowCheck" type="checkbox" value="${dto.num }"/></td>
							<td style="width: 55px; padding-left: 30px;" align="center">${dto.codeType }</td>
							<td style="width: 50px; padding-left: 10px;" align="center">${dto.num }</td>
							<td style="width: 125px;  align="center"><a href="./freeBoardDetail.ino?num=${dto.num }">${dto.title }</a></td>
							<td style="width: 48px; padding-left: 50px;" align="center">${dto.name }</td>
							<td style="width: 100px; padding-left: 95px;" align="center">${dto.regdate }</td>
						<tr>
					</c:forEach>
			</tbody>
		</table>
		<input type="button" value="선택 항목(들) 삭제" class="deleteChecked" style="margin-top: 10px; float: right;"  onclick="deleteChecked();">
	</div>

</body>
<script>
function getSearchType(){
	
	const selBox = $("#searchType option:selected").val();
	
	 if(selBox == 1){
		$("#s_selectCode").show();
	}else{
		$("#s_selectCode").hide();
	}
	
	if(selBox == 2 || selBox == 3 || selBox == 4){
		$("#searchByKeyword").show();
	}else{
		$("#searchByKeyword").hide();
	}
	
	if(selBox == 5){
		$("#searchByNum").show();
	}else{
		$("#searchByNum").hide();
	}
	if(selBox == 6){
		$("#divDate").show();
	}else{
		$("#divDate").hide();
	} 
}
getSearchType();	

$(document).on('click','#btnSearch', function(e){

	const selBox = document.getElementById("searchType").value;
	
	const codeType = $("#s_selectCode option:selected").val();
	const num = $("#searchByNum").val().trim();
	var sDate = $("#sDate").val();
	var eDate = $("#eDate").val();
	
	if(selBox == 2 || selBox == 3 || selBox == 4){
		if($("#searchByKeyword").val() === ''){
			alert("아무것도 입력되지 않았습니다.");
			selBox = 0;
			return;
		}
	}
	if(selBox == 5){
		if(num === ''){
			alert("아무것도 입력되지 않았습니다.");
			selBox = 0;
			return;
		}
		if(isNaN(num)){
			alert("숫자만 입력가능합니다.");
			selBox = 0;
			return;
		}
	}
	if(selBox == '6'){
		if(isNaN(sDate) || isNaN(eDate)){
			alert("숫자만 입력가능합니다.");
			location.href = "./main.ino";
		}
		if(sDate == '' || sDate.length != 8 || eDate =='' || eDate.length != 8){
			alert("8자리 모두 입력되어야합니다");
			location.href = "./main.ino";
		}
		
	}
		/* $("input:text[numberOnly]").on("keyup", function() {
	      $(this).val($(this).val().replace(/[^0-9]/g,""));					입력되는값 바로 받아서 숫자만 남기는 함수
	   }); */
	
	$.ajax({
		url : './getSearchList.ino',
		data : $('#searchForm').serialize(),
		async : true,
		success : function(data){
			$('#listTable > tbody').empty();
			if((data.list).length>=1){
					(data.list).forEach(function(item){
						str = '<tr>'
						str += "<td style='width: 55px; padding-left: 5px;' align='center' ><input name='RowCheck'type='checkbox'value='" + item.num+"''/></td>";
						str += "<td style='width: 55px; padding-left: 30px;' align='center'>" + item.codeType + "</td>";
						str += "<td style='width: 50px; padding-left: 10px;' align='center'>" + item.num + "</td>";
						str += "<td style='width: 125px;'  align='center'><a href='./freeBoardDetail.ino?num=" + item.num + "'>"+ item.title + "</td>";
						str += "<td style='width: 48px; padding-left: 50px;' align='center'>" + item.name + "</td>";
						str += "<td style='width: 100px; padding-left: 95px;' align='center'>" + item.regdate + "</td>";
						str += "</tr>"
							$('#listTable').append(str);
					});
					
			}else{
				alert("검색어와 일치하는 글이 없습니다.");
				location.href="./main.ino";
				
			}
		},
		error:function(){
			alert("검색타입에 맞지 않습니다 타입에 맞게 입력해주세요 \n ex)기간=8자리숫자");
			location.href="./main.ino";
			
		}
	});   
	   
	   
});
</script>
</html>