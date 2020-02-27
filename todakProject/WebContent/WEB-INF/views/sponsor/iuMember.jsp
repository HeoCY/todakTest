<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.List" %>
<%@ page import="java142.todak.sponsor.vo.MemberVO" %>
<%@ page import="java142.todak.sponsor.vo.MemberCardVO" %>
<%@ page import="java142.todak.sponsor.vo.MemberAccountVO" %>
<%@ include file="/WEB-INF/views/commons/bindSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
		<title>�Ŀ���</title>
		</script>
		<script type="text/javascript"
				src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
		<!-- <script type="text/javascript"
				src="../js/jquery-1.11.0.min.js"></script> -->
		<script type="text/javascript">
			$(document).ready(function(){
				//alert("(log) jQuery executed");
				var enctype = 'application/x-www-form-urlencoded';
				$("#confirm").click(function(){
					var domain = $("#emailDomainSlctr").val();
					if (domain == 'bySelf'){
						domain = $("#emailDomain").val();
					}
					var email = $("#emailId").val() + '@' + domain;
					$("#sm_email").prop("value", email);
					
					executeFunc(enctype);
					
				});

				$("#emailDomainSlctr").change(function(){
					//alert("changed");
					//alert($("#rgstEmailDomainSlctr").val());
					var domain = $("#emailDomainSlctr").val();
					if (domain == 'bySelf'){
						$("#emailDomain").val('');
						$("#emailDomain").prop("disabled", false);
					}else{
						$("#emailDomain").val($("#emailDomainSlctr").val());
						$("#emailDomain").prop("disabled", true);
					}
				});
				
			});
			5
			function executeFunc(enctype){
				//http://localhost:8088/Model2_MVC/KcmMemberServlet
				$("#registerForm").prop("method", "POST")
				.prop("enctype", enctype)
				.submit();
			}
		</script>
		
	</head>
	<body>
         <header class="header"> 
            <%@ include file="/WEB-INF/views/commons/header.jsp" %>
         </header>

         <aside class="sidebar">
            <%@ include file="/WEB-INF/views/commons/sidebar.jsp" %>
         </aside>
         <div class="context-container">
			<%
				MemberVO smvo = new MemberVO();
				MemberCardVO smcvo = new MemberCardVO();
				MemberAccountVO smavo = new MemberAccountVO();
				String emailId = "";
				String emailDomain = "";
				List<MemberVO> memberList = (List<MemberVO>)request.getAttribute("memberList");
				List<MemberCardVO> cardList = (List<MemberCardVO>)request.getAttribute("cardList");
				List<MemberAccountVO> accountList = (List<MemberAccountVO>)request.getAttribute("accountList");
				if (memberList != null && !memberList.isEmpty() &&
					cardList != null && !cardList.isEmpty() &&
					accountList != null && !accountList.isEmpty()){
					smvo = memberList.get(0);
					smcvo = cardList.get(0);
					smavo = accountList.get(0);
					int index = smvo.getSm_email().indexOf("@");
					emailId = smvo.getSm_email().substring(0, index);
					emailDomain = smvo.getSm_email().substring(index+1);
			%>
				<script type="text/javascript">
					// ������Ʈ�� ���
					$(document).ready(function(){
						alert("update");
						$("#registerForm").prop("action", "/sponsor/updateMember.td");
					});
				</script>
			<%
				}else{
			%>
				<script type="text/javascript">
					// �μ�Ʈ�� ���
					$(document).ready(function(){
						alert("insert");
						$("#registerForm").prop("action", "/sponsor/insertMember.td");
					});
				</script>
			<%		
				}
			%>
			<form id="registerForm">
				<table align="center" border="1">
					<tr><td colspan="3" align="center">�Ŀ�������</td></tr>
					<tr>
						<td align="center" width="140" align="center">�̸�</td>
						<td colspan="2" width="250">
							<input type="text" name="sm_name" id="sm_name" value=<%= smvo.getSm_name() %>>
						</td>
					</tr>
					<tr>
						<td align="center">�޴�����ȣ</td>
						<td colspan="2"><input type="text" name="sm_hp" id="sm_hp" value=<%= smvo.getSm_hp() %>>&nbsp;&nbsp;* '-'������ ���� ���� 11�ڸ�</td>
					</tr>
					<tr>
						<td align="center">�̸���</td>
						<td colspan="2"><input type="text" name="emailId" id="emailId" value=<%= emailId %>> @
							<input type="text" name="emailDomain" id="emailDomain" size="10" value=<%= emailDomain %>>
							<select name="emailDomainSlctr" id="emailDomainSlctr">
								<option value="bySelf">�����Է�</option>
								<option value="naver.com">naver.com</option>
								<option value="gmail.com">gmail.com</option>
								<option value="hanmail.net">hanmail.net</option>
							</select>
						</td>
					</tr>
					<tr>
						<td align="center">�����Ŀ�����</td>
						<td colspan="2">
							<select name="sm_regularYN" id="sm_regularYN" value=<%= smvo.getSm_regularYN() %>>
								<option value="Y">����</option>
								<option value="N">�ź�</option>
							</select>
						</td>
					</tr>
					<tr>
						<td align="center">�Ŀ�����</td>
						<td>
							<select name="sm_means" id="sm_means" value=<%= smvo.getSm_means() %>>
								<option value="39">ī��</option>
								<option value="40">����</option>
							</select>
						</td>
					</tr>
					<tr>
						<td align="center">���þ�����ǿ���</td>
						<td>
							<select name="sm_optionalterms" id="sm_optionalterms" value=<%= smvo.getSm_optionalterms() %>>
								<option value="Y">����</option>
								<option value="N">�ź�</option>
							</select>
						</td>
					</tr>
					<tr><td colspan="3" align="center">ī������</td></tr>
					<tr>
						<td align="center">ī���</td>
						<td colspan="2">
							<select name="smc_cardcorp" id="smc_cardcorp" value=<%= smcvo.getSmc_cardcorp() %>>
								<option value="33">��ī��</option>
								<option value="34">�Ｚī��</option>
								<option value="35">����ī��</option>
								<option value="36">����ī��</option>
								<option value="37">�츮ī��</option>
							</select>
						</td>
					</tr>
					<tr>
						<td align="center">ī���ȣ</td>
						<td colspan="2"><input type="text" name="smc_cardnum" id="smc_cardnum" value=<%= smcvo.getSmc_cardnum() %>></td>
					</tr>
					<tr>
						<td align="center">ī�������</td>
						<td colspan="2"><input type="text" name="smc_cardowner" id="smc_cardowner" value=<%= smcvo.getSmc_cardowner() %>></td>
					</tr>
					<tr>
						<td align="center">ī�常�ᳯ¥</td>
						<td colspan="2"><input type="text" name="smc_cardexpired" id="smc_cardexpired" value=<%= smcvo.getSmc_cardexpired() %>>&nbsp;&nbsp;* MMYYYY</td>
					</tr>
					<tr>
						<td align="center">cvc</td>
						<td colspan="2"><input type="text" name="smc_cardcvc" id="smc_cardcvc" value=<%= smcvo.getSmc_cardcvc() %>>&nbsp;&nbsp;* ī�� cvc ���� 3�ڸ�</td>
					</tr>
					<tr><td colspan="3" align="center">��������</td></tr>
					<tr>
						<td align="center">����</td>
						<td colspan="2">
							<select name="sma_bank" id="sma_bank">
								<option value="38">��������</option>
							</select>
						</td>
					</tr>
					<tr>
						<td align="center">���¹�ȣ</td>
						<td colspan="2"><input type="text" name="sma_accountnum" id="sma_accountnum" value=<%= smavo.getSma_accountnum() %>>&nbsp;&nbsp;* '-'������ ���� ���� 14�ڸ�</td>
					</tr>
					<tr>
						<td align="center">�����ָ�</td>
						<td colspan="2"><input type="text" name="sma_depositor" id="sma_depositor" value=<%= smavo.getSma_depositor() %>></td>
					</tr>
					<tr>
						<td colspan="5" align="center">
							<input type="hidden" id="sm_num" name="sm_num" value=<%= smvo.getSm_num() %>>
							<input type="hidden" id="sm_email" name="sm_email">
							<input type="button" value="Ȯ��" id="confirm">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="reset" value="�ʱ�ȭ">
						</td>
					</tr>
				</table>
			</form>
         </div>
         
	</body>
</html>