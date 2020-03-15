<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta charset="UTF-8">
		<title>id</title>
		<script type="text/javascript"
				src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
		<script type="text/javascript">
			function pwAction(){
				$.ajax({
					url: "/etc/emailAuth.td",
					method: "POST",
					data: {
						"selectFunc": $("#selectFunc").val(),
						"hm_empnum": $("#hm_empnum").val(),
						"hm_email": $("#hm_email").val()
					},
					success: eventSuccess,
					error: eventError
				});
				function eventSuccess(data){
					var message = $(data).find("message").text();
					var checker = $(data).find("checker").text();
					
					// 분기해서 성공하면 팝업닫고 아니면 나두기
					if(checker == '0'){
						alert(message);
						self.close();
					}else{
						alert(message);
					}
				}
				function eventError(err){
					alert(err);
				}
			}			
		</script>		
	</head>
	<body>
		<form name="pwForm" id="pwForm">			
			<p><h3 align="center">비밀번호찾기</h3></p>			
			<table align="center" border="1">
				<tr>
					<td colspan="2" align="center">사원번호를 입력하세요.</td>
				</tr>
				<tr>
					<td align="center">사원번호</td>
					<td>&nbsp;<input type="text" id="hm_empnum" name="hm_empnum" size="20" maxlength="20"></td>
				</tr>
				<tr>
					<td align="center">가입 이메일</td>
					<td>&nbsp;<input type="text" id="hm_email" name="hm_email" size="20" maxlength="20"></td>
				</tr>
				<tr>
					<td colspan="2" >&nbsp;가입한 이메일에서 새로운 비밀번호를 확인하세요.</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="hidden" id="selectFunc" name="selectFunc" value="2">
						<input type="button" value="확인" onclick="pwAction();">
						<input type="reset" value="다시">
					</td>
				</tr>
			</table>
		</form>	
	</body>
</html>