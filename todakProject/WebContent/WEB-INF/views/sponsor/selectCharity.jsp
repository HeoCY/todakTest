<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java142.todak.sponsor.vo.CharityVO" %>
<%@ include file="/WEB-INF/views/commons/bindSession.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% 
	String message = (String)request.getAttribute("message");
	//System.out.println(" message >>> " + message);
	if (message != null){
		%>
		<script type="text/javascript">
			var message = '<%= message %>';
			if (message != null && message != ''){
				alert(message);
			}
		</script>
		<%
	}
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
		<title>�񿵸���ü ��ȸ</title>
		<script type="text/javascript"
				src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
		<!-- 
		<script type="text/javascript" 
				src="/include/js/jquery-1.11.0.min.js" ></script> -->
		<script type="text/javascript">
			$(function(){
				/* �۾��� ��ư Ŭ�� �� ó�� �̺�Ʈ */
				$("#registerForm").click(function(){
					location.href = "/sponsor/moveIUCharity.td";
				});
				
				/* ���� Ŭ���� �� ������ �̵��� ���� ó�� �̺�Ʈ */
				$(".goDetail").click(function(){
					var sc_num = $(this).parents("tr").attr("data-num");
					$("#sc_num").val(sc_num);
					// �� �������� �̵��ϱ� ���� form �߰� (id : detailForm)
					$("#detailForm").prop({
						"method" : "post",
						"action" : "/sponsor/selectCharity.td"
					}).submit();
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
         
		<% System.out.println(sManager.getUserID(session.getId())); %>
		<div id="context-container">
			<div id="boardTit"><h3>��ü���</h3></div>
			<form name="detailForm" id="detailForm">
				<input type="hidden" name="sc_num" id="sc_num">
				<input type="hidden" name="selectFunc" id="selectFunc" value="search">
				<input type="hidden" name="message" id="message" value="">
			</form>
			<%-- =========== �˻���� ���� (�� �κ� ��ü �߰�) =========== --%>
			<div id="boardSearch">
				<form id="f_search" name="f_search">
					<table summary="�˻�">
						<colgroup>
							<col width="70%"></col>
							<col width="30%"></col>
						</colgroup>
						<tr>
							<td id="btd1">
								<label>�˻�����</label>
								<select id="search" name="search">
									<option value="all">��ü</option>
									<option value="sc_bizfield">����о�</option>
									<option value="sc_bizcontents">�������</option>
									<option value="sc_name">��ü��</option>
								</select>
								<input type="text" name="keyword" id="keyword" value="�˻���Է��ϼ���" />
								<input type="button" value="�˻�" id="searchData" />
							</td>
							<td id="btd2">����������
								<select id="pageSize" name="pageSize">
									<option value="5">5��</option>
									<option value="10">10��</option>
									<option value="20">20��</option>
									<option value="30">30��</option>
									<option value="50">50��</option>
									<option value="100">100��</option>
								</select>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<%-- ================== �˻���� ���� ================== --%>
			<%-- =================== ����Ʈ ���� =================== --%>
			<div id="charityList">
				<table summary="�񿵸���ü ����Ʈ">
					<colgroup>
						<col width = "10%" />
						<col width = "10%" />
						<col width = "10%" />
						<col width = "60%" />
						<col width = "10%" />
					</colgroup>
					<thead>
						<tr>
							<th>��ü��ȣ</th>
							<th>��ü��</th>
							<th class="borcle">����о�</th>
							<th>�������</th>
							<th>��ü�����</th>
						</tr>
					</thead>
					<tbody>
						<%
							List<CharityVO> charityList = (List<CharityVO>)request.getAttribute("charityList");
							if (charityList != null && !charityList.isEmpty()){
								Iterator<CharityVO> iter = charityList.iterator();
								while(iter.hasNext()){
									CharityVO scvo = (CharityVO)iter.next();
						%>
						<!-- ������ ��� -->
									<tr align="center" data-num="<%= scvo.getSc_num() %>">
										<td><%= scvo.getSc_num() %></td>
										<td><span class="goDetail"><%= scvo.getSc_name() %></span></td>
										<td><%= scvo.getSc_bizfield() %></td>
										<td><%= scvo.getSc_bizcontents() %></td>
										<td><%= new StringBuffer(scvo.getSc_registrationdate()).insert(6, "-").insert(4, "-").toString() %></td>
									</tr>
						<%
								}
							}else{
						%>
								<tr>
									<td colspan="5" align="center">��ϵ� �Խù��� �������� �ʽ��ϴ�.</td>
								</tr>
						<%
							}
						%>
					</tbody>
				</table>
			</div>
			<%-- =================== ����Ʈ ���� =================== --%>
			
			<%-- ================ �۾��� ��ư ��� ���� ================ --%>
			<div id="charityBtn">
				<input type="button" value="��ü���" id="registerForm">
			</div>
			<%-- ================ �۾��� ��ư ��� ���� ================ --%>
			
		</div>
	</body>
</html>