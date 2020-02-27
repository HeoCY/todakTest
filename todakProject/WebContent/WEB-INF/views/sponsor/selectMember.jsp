<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java142.todak.sponsor.vo.MemberVO" %>
<%@ page import="java142.todak.sponsor.vo.SponsorshipVO" %>
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
		<title>�񿵸��Ŀ��� ��ȸ</title>
		<script type="text/javascript"
				src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
		<!-- 
		<script type="text/javascript" 
				src="/include/js/jquery-1.11.0.min.js" ></script> -->
		<script type="text/javascript">
			$(function(){
				/* �۾��� ��ư Ŭ�� �� ó�� �̺�Ʈ */
				$("#registerForm").click(function(){
					location.href = "/sponsor/moveIUMember.td";
				});
				
				/* ���� Ŭ���� �� ������ �̵��� ���� ó�� �̺�Ʈ */
				$(".goDetail").click(function(){
					var sm_num = $(this).parents("tr").attr("data-num");
					$("#sm_num").val(sm_num);
					// �� �������� �̵��ϱ� ���� form �߰� (id : detailForm)
					$("#detailForm").prop({
						"method" : "post",
						"action" : "/sponsor/selectMember.td"
					}).submit();
				});
			});
		</script>
	</head>
	<body>
         <header class="header"> 
            <%@ include file="/WEB-INF/views/commons/header.jsp" %>
         </header>
		
		<section class="body">
	         <aside class="sidebar">
	            <%@ include file="/WEB-INF/views/commons/sidebar.jsp" %>
	         </aside>
	
			<% System.out.println(sManager.getUserID(session.getId())); %>
			<div class="context-container">
				<div id="boardTit"><h3>�Ŀ��θ��</h3></div>
				<form name="detailForm" id="detailForm">
					<input type="hidden" name="sm_num" id="sm_num">
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
										<option value="sm_num">�Ŀ��ι�ȣ</option>
										<option value="sm_name">�Ŀ����̸�</option>
										<option value="sm_insertdate">������</option>
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
				<div id="memberList">
					<table summary="�Ŀ��θ���Ʈ">
						<colgroup>
							<col width = "10%" />
							<col width = "10%" />
								<%-- 
							<col width = "10%" />
							<col width = "60%" />
								--%>
							<col width = "10%" />
						</colgroup>
						<thead>
							<tr>
								<th>�Ŀ��ι�ȣ</th>
								<th>�Ŀ��θ�</th>
								<%-- 
								<th>�ֱ��Ŀ���</th>
								<th>�� �Ŀ��ݾ�</th> 
								--%>
								<th>������</th>
							</tr>
						</thead>
						<tbody>
							<%
								List<MemberVO> memberList = (List<MemberVO>)request.getAttribute("memberList");
								//List<SponsorshipVO> sponsorshipList = (List<SponsorshipVO>)request.getAttribute("sponsorshipList");
								if (memberList != null && !memberList.isEmpty()
										//&&	sponsorshipList != null && !sponsorshipList.isEmpty()
									){
									Iterator<MemberVO> iter = memberList.iterator();
									while(iter.hasNext()){
										MemberVO smvo = iter.next();
							%>
							<!-- ������ ��� -->
										<tr align="center" data-num="<%= smvo.getSm_num() %>">
											<td><%= smvo.getSm_num() %></td>
											<td><span class="goDetail"><%= smvo.getSm_name() %></span></td>
								<%-- 
											<td><%= smvo.getSm_bizfield() %></td>
											<td><%= smvo.getSm_bizcontents() %></td>
								--%>
											<td><%= new StringBuffer(smvo.getSm_insertdate()).insert(6, "-").insert(4, "-").toString() %></td>
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
				<div id="memberBtn">
					<input type="button" value="�Ŀ��ε��" id="registerForm">
				</div>
				<%-- ================ �۾��� ��ư ��� ���� ================ --%>
				
			</div>
		</section>
	</body>
</html>