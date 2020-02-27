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
		<script type="text/javascript"
				src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
		<script type="text/javascript">
			$(document).ready(function(){
				$("#U").click(function(){
					//alert("update");
					$("#form").prop("action", "/sponsor/moveIUMember.td").submit();
				});
				$("#D").click(function(){
					//alert("delete");
					var bool = confirm('���� �����Ͻðڽ��ϱ�?');
					if (bool){
						$("#form").prop("action", "/sponsor/deleteMember.td").submit();
					}
				});
			});
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
				MemberVO smvo = null;
				MemberCardVO smcvo = null;
				MemberAccountVO smavo = null;
				String smc_cardexpired = "";
				List<MemberVO> memberList = (List<MemberVO>)request.getAttribute("memberList");
				List<MemberCardVO> cardList = (List<MemberCardVO>)request.getAttribute("cardList");
				List<MemberAccountVO> accountList = (List<MemberAccountVO>)request.getAttribute("accountList");
				if (memberList != null && !memberList.isEmpty() &&
					cardList != null && !cardList.isEmpty() &&
					accountList != null && !accountList.isEmpty()){
					smvo = memberList.get(0);
					smcvo = cardList.get(0);
					smc_cardexpired = smcvo.getSmc_cardexpired();
					if (smc_cardexpired != null && !smc_cardexpired.equals(""))
						smc_cardexpired = new StringBuffer(smcvo.getSmc_cardexpired()).insert(2, "-").toString();
					smavo = accountList.get(0);
				}
			%>
			<form id="form">
				<table align="center" border="1">
					<tr><td colspan="3" align="center">�Ŀ�������</td></tr>
					<tr>
						<td align="center" width="140" align="center">�̸�</td>
						<td colspan="2" width="250">
							<%= smvo.getSm_name() %>
						</td>
					</tr>
					<tr>
						<td align="center">�޴�����ȣ</td>
						<td colspan="2"><%= smvo.getSm_hp() %></td>
					</tr>
					<tr>
						<td align="center">�̸���</td>
						<td colspan="2"><%= smvo.getSm_email() %></td>
					</tr>
					<tr>
						<td align="center">�����Ŀ�����</td>
						<td colspan="2">
							<%= smvo.getSm_regularYN() %>
						</td>
					</tr>
					<tr>
						<td align="center">�Ŀ�����</td>
						<td colspan="2"><%= smvo.getSm_means() %></td>
					</tr>
					<tr>
						<td align="center">���þ�����ǿ���</td>
						<td colspan="2"><%= smvo.getSm_optionalterms() %></td>
					</tr>
					<tr><td colspan="3" align="center">ī������</td></tr>
					<tr>
						<td align="center">ī���</td>
						<td colspan="2"><%= smcvo.getSmc_cardcorp() %></td>
					</tr>
					<tr>
						<td align="center">ī���ȣ</td>
						<td colspan="2"><%= smcvo.getSmc_cardnum() %></td>
					</tr>
					<tr>
						<td align="center">ī�������</td>
						<td colspan="2"><%= smcvo.getSmc_cardowner() %></td>
					</tr>
					<tr>
						<td align="center">ī�常�ᳯ¥</td>
						<td><%= smc_cardexpired %></td>
					</tr>
					<tr>
						<td align="center">cvc</td>
						<td colspan="2"><%= smcvo.getSmc_cardcvc() %></td>
					</tr>
					<tr><td colspan="3" align="center">��������</td></tr>
					<tr>
						<td align="center">����</td>
						<td colspan="2">��������</td>
					</tr>
					<tr>
						<td align="center">���¹�ȣ</td>
						<td colspan="2"><%= smavo.getSma_accountnum() %></td>
					</tr>
					<tr>
						<td align="center">�����ָ�</td>
						<td colspan="2"><%= smavo.getSma_depositor() %></td>
					</tr>
					<tr>
						<td colspan="5" align="center">
							<input type="hidden" name="sm_num" id="sm_num" value="<%= smvo.getSm_num() %>">
							<input type="hidden" name="smc_num" id="smc_num" value="<%= smcvo.getSmc_num() %>">
							<input type="hidden" name="sma_num" id="sma_num" value="<%= smavo.getSma_num() %>">
							<input type="button" value="����" id="U">
							<input type="button" value="����" id="D">
						</td>
					</tr>
				</table>
			</form>
         </div>
         
	</body>
</html>