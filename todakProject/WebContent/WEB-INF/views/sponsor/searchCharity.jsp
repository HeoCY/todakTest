<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.List" %>
<%@ page import="java142.todak.sponsor.vo.CharityVO" %>
<%@ include file="/WEB-INF/views/commons/bindSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
		<title>�񿵸���ü</title>
		<script type="text/javascript"
				src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
		<script type="text/javascript">
			$(document).ready(function(){
				$("#U").click(function(){
					//alert("update");
					$("#form").prop("action", "/sponsor/moveIUCharity.td").submit();
				});
				$("#D").click(function(){
					//alert("delete");
					var bool = confirm('���� �����Ͻðڽ��ϱ�?');
					if (bool){
						$("#form").prop("action", "/sponsor/deleteCharity.td").submit();
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
				CharityVO scvo = null;
				List<CharityVO> charityList = (List<CharityVO>)request.getAttribute("charityList");
				if (charityList != null && !charityList.isEmpty()){
					scvo = charityList.get(0);
				}
			%>
			<form id="form">
				<table align="center" border="1">
					<tr><td colspan="3" align="center">��ü����</td></tr>
					<tr>
						<td align="center" width="140" align="center">��ü��</td>
						<td colspan="2" width="250">
							<%= scvo.getSc_name() %>
						</td>
					</tr>
					<tr>
						<td align="center">��ǥ��</td>
						<td colspan="2">
							<%= scvo.getSc_ceo()%>
						</td>
					</tr>
					<tr>
						<td align="center">�޴�����ȣ</td>
						<td colspan="2"><%= scvo.getSc_hp() %></td>
					</tr>
					<tr>
						<td align="center">�̸���</td>
						<td colspan="2"><%= scvo.getSc_email() %></td>
					</tr>
					<tr>
						<td align="center">������</td>
						<td colspan="2">
							<%= scvo.getSc_addr() %>>
						</td>
					</tr>
					<tr>
						<td align="center">��ü ��Ϲ�ȣ</td>
						<td colspan="2"><%= scvo.getSc_registration() %></td>
					</tr>
					<tr>
						<td align="center">��ü �����</td>
						<td><%= new StringBuffer(scvo.getSc_registrationdate()).insert(6, "-").insert(4, "-").toString() %></td>
					</tr>
					<tr>
						<td align="center">����о�</td>
						<td><%= scvo.getSc_bizfield() %></td>
					</tr>
					<tr>
						<td align="center">�������</td>
						<td colspan="2" rows="4" cols="60"><%= scvo.getSc_bizcontents() %></td>
					</tr>
					<tr>
						<td align="center">��ǥ��ݾ�</td>
						<td colspan="2"><%= scvo.getSc_targetamount() %></td>
					</tr>
					<tr>
						<td align="center">��ݱⰣ</td>
						<td><%= new StringBuffer(scvo.getSc_amountingstart()).insert(6, "-").insert(4, "-").toString() %> - <%= new StringBuffer(scvo.getSc_amountingend()).insert(6, "-").insert(4, "-").toString() %></td>
					</tr>
					<tr>
						<td align="center">����</td>
						<td colspan="2">��������</td>
					</tr>
					<tr>
						<td align="center">���¹�ȣ</td>
						<td colspan="2"><%= scvo.getSc_accountnum() %></td>
					</tr>
					<tr>
						<td align="center">�����ָ�</td>
						<td colspan="2"><%= scvo.getSc_depositor() %></td>
					</tr>
					<tr>
						<td colspan="5" align="center">
							<input type="hidden" name="sc_num" id="sc_num" value="<%= scvo.getSc_num() %>">
							<input type="button" value="����" id="U">
							<input type="button" value="����" id="D">
						</td>
					</tr>
				</table>
			</form>
         </div>
	</body>
</html>