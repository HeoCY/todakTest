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
		<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
		<script>
			//�� ���������� ���θ� �ּ� ǥ�� ��Ŀ� ���� ���ɿ� ����, �������� �����͸� �����Ͽ� �ùٸ� �ּҸ� �����ϴ� ����� �����մϴ�.
			function sample4_execDaumPostcode() {
				new daum.Postcode({
					oncomplete: function(data) {
						// �˾����� �˻���� �׸��� Ŭ�������� ������ �ڵ带 �ۼ��ϴ� �κ�.

						// ���θ� �ּ��� ���� ��Ģ�� ���� �ּҸ� �����Ѵ�.
						// �������� ������ ���� ���� ��쿣 ����('')���� �����Ƿ�, �̸� �����Ͽ� �б� �Ѵ�.
						var fullRoadAddr = data.roadAddress; // ���θ� �ּ� ����
						var extraRoadAddr = ''; // ���θ� ������ �ּ� ����

						// ���������� ���� ��� �߰��Ѵ�. (�������� ����)
						// �������� ��� ������ ���ڰ� "��/��/��"�� ������.
						if(data.bname !== '' && /[��|��|��]$/g.test(data.bname)){
							extraRoadAddr += data.bname;
						}
						// �ǹ����� �ְ�, ���������� ��� �߰��Ѵ�.
						if(data.buildingName !== '' && data.apartment === 'Y'){
						   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
						}
						// ���θ�, ���� ������ �ּҰ� ���� ���, ��ȣ���� �߰��� ���� ���ڿ��� �����.
						if(extraRoadAddr !== ''){
							extraRoadAddr = ' (' + extraRoadAddr + ')';
						}
						// ���θ�, ���� �ּ��� ������ ���� �ش� ������ �ּҸ� �߰��Ѵ�.
						if(fullRoadAddr !== ''){
							fullRoadAddr += extraRoadAddr;
						}

						// �ּ� ������ �ش� �ʵ忡 �ִ´�.
						document.getElementById('sc_addr').value = fullRoadAddr;
					}
				}).open();
			}
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
					$("#sc_email").prop("value", email);
					
					var sc_registrationdate = $("#sc_registrationdate").prop("value");
					sc_registrationdate = sc_registrationdate.replace(/\-/g,'');
					$("#sc_registrationdate").prop("value", sc_registrationdate);
					

					var sc_amountingstart = $("#sc_amountingstart").prop("value");
					sc_amountingstart = sc_amountingstart.replace(/\-/g,'');
					$("#sc_amountingstart").prop("value", sc_amountingstart);
					

					var sc_amountingend = $("#sc_amountingend").prop("value");
					sc_amountingend = sc_amountingend.replace(/\-/g,'');
					$("#sc_amountingend").prop("value", sc_amountingend);
					
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
		
		<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
		<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
		<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.9.2/i18n/jquery.ui.datepicker-ko.min.js"></script>
		<script type="text/javascript">
			//<![CDATA[
			$(function(){
				$("#sc_registrationdate").datepicker({
					showOn: "button",
			        //buttonImage: "images/calendar.gif",
				    buttonImageOnly: false,
					buttonText: "Select date"
				});

				$("#sc_amountingstart").datepicker({
					showOn: "button",
			        //buttonImage: "images/calendar.gif",
				    buttonImageOnly: false,
					buttonText: "Select Start date"
				});

				$("#sc_amountingend").datepicker({
					showOn: "button",
			        //buttonImage: "images/calendar.gif",
				    buttonImageOnly: false,
					buttonText: "Select End date"
				});
			});
			//]]>
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
				CharityVO scvo = new CharityVO();
				String emailId = "";
				String emailDomain = "";
				String registrationdate = "";
				String amountingstart = "";
				String amountingend = "";
				List<CharityVO> charityList = (List<CharityVO>)request.getAttribute("charityList");
				if (charityList != null && !charityList.isEmpty()){
					scvo = charityList.get(0);
					int index = scvo.getSc_email().indexOf("@");
					emailId = scvo.getSc_email().substring(0, index);
					emailDomain = scvo.getSc_email().substring(index+1);
					registrationdate = new StringBuffer(scvo.getSc_registrationdate()).insert(6, "-").insert(4, "-").toString();
					amountingstart = new StringBuffer(scvo.getSc_amountingstart()).insert(6, "-").insert(4, "-").toString();
					amountingend = new StringBuffer(scvo.getSc_amountingend()).insert(6, "-").insert(4, "-").toString();
			%>
				<script type="text/javascript">
					// ������Ʈ�� ���
					$(document).ready(function(){
						//alert("update");
						$("#registerForm").prop("action", "/sponsor/updateCharity.td");
					});
				</script>
			<%
				}else{
			%>
				<script type="text/javascript">
					// �μ�Ʈ�� ���
					$(document).ready(function(){
						//alert("insert");
						$("#registerForm").prop("action", "/sponsor/insertCharity.td");
					});
				</script>
			<%		
				}
			%>
			<form id="registerForm">
				<table align="center" border="1">
					<tr><td colspan="3" align="center">��ü����</td></tr>
					<tr>
						<td align="center" width="140" align="center">��ü��</td>
						<td colspan="2" width="250">
							<input type="text" name="sc_name" id="sc_name" value=<%= scvo.getSc_name() %>>
						</td>
					</tr>
					<tr>
						<td align="center">��ǥ��</td>
						<td colspan="2">
							<input type="text" name="sc_ceo" id="sc_ceo" value=<%= scvo.getSc_ceo()%>>
						</td>
					</tr>
					<tr>
						<td align="center">�޴�����ȣ</td>
						<td colspan="2"><input type="text" name="sc_hp" id="sc_hp" value=<%= scvo.getSc_hp() %>>&nbsp;&nbsp;* '-'������ ���� ���� 11�ڸ�</td>
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
						<td align="center">������</td>
						<td colspan="2">
							<input type="text" name="sc_addr" id="sc_addr" size="50" value=<%= scvo.getSc_addr() %>>
							<input type="button" onclick="sample4_execDaumPostcode()" value="�ּ� ã��">
						</td>
					</tr>
					<tr>
						<td align="center">��ü ��Ϲ�ȣ</td>
						<td colspan="2"><input type="text" name="sc_registration" id="sc_registration" value=<%= scvo.getSc_registration() %>>&nbsp;&nbsp;* '-'������ ���� ���� 10�ڸ�</td>
					</tr>
					<tr>
						<td align="center">��ü �����</td>
						<td><input type="text" name="sc_registrationdate" id="sc_registrationdate" size="12"  value=<%= registrationdate %>></td>
					</tr>
					<tr>
						<td align="center">����о�</td>
						<td>
							<select name="sc_bizfield" id="sc_bizfield" value=<%= scvo.getSc_bizfield() %>>
								<option value="41">��ȭ����</option>
								<option value="42">�αǿ</option>
								<option value="43">����������</option>
								<option value="44">�ù��ǽİ���</option>
								<option value="45">ȯ�溸��</option>
								<option value="46">��Ÿ���ͻ��</option>
							</select>
						</td>
					</tr>
					<tr>
						<td align="center">�������</td>
						<td colspan="2">
							<textarea name="sc_bizcontents" id="sc_bizcontents" rows="4" cols="60"><%= scvo.getSc_bizcontents() %></textarea>
						</td>
					</tr>
					<tr>
						<td align="center">��ǥ��ݾ�</td>
						<td colspan="2"><input type="text" name="sc_targetamount" id="sc_targetamount" value=<%= scvo.getSc_targetamount() %>>��</td>
					</tr>
					<tr>
						<td align="center">��ݱⰣ</td>
						<td><input type="text" name="sc_amountingstart" id="sc_amountingstart" size="12"  value=<%= amountingstart %>> - 
							<input type="text" name="sc_amountingend" id="sc_amountingend" size="12"  value=<%= amountingend %>></td>
					</tr>
					<tr>
						<td align="center">����</td>
						<td colspan="2">
							<select name="sc_bank" id="sc_bank">
								<option value="38">��������</option>
							</select>
						</td>
					</tr>
					<tr>
						<td align="center">���¹�ȣ</td>
						<td colspan="2"><input type="text" name="sc_accountnum" id="sc_accountnum" value=<%= scvo.getSc_accountnum() %>>&nbsp;&nbsp;* '-'������ ���� ���� 14�ڸ�</td>
					</tr>
					<tr>
						<td align="center">�����ָ�</td>
						<td colspan="2"><input type="text" name="sc_depositor" id="sc_depositor" value=<%= scvo.getSc_depositor() %>></td>
					</tr>
					<tr>
						<td colspan="5" align="center">
							<input type="hidden" id="sc_num" name="sc_num" value=<%= scvo.getSc_num() %>>
							<input type="hidden" id="sc_email" name="sc_email">
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