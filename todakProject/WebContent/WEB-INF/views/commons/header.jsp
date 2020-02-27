<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
		<script src="https://kit.fontawesome.com/a076d05399.js"></script>
		<link rel="stylesheet" href="../../../include/css/commons/menu.css">
		<!-- 
		<script type="text/javascript"
				src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
		<script type="text/javascript" 
				src="/include/js/jquery-1.11.0.min.js" ></script> -->
		<script type="text/javascript">
			$(function(){
				// ���θ޴� Ŭ����
				$(".header-main-menu").click(function(){
					var sbList = [];
					var main = $(this).find('input').val();
					var sidebar_width = 15;
					var container_width = 84;
					var display = 'grid';
					
					if (main == "1") sbList = [['��� ���/��ȸ', '/human/selectMember.td', 'far fa-address-card'], 
					                           ['�߷� ���/��ȸ', '/human/selectPersonAppt.td', 'fas fa-suitcase']];
					else if (main == "2") sbList = [['���缭�� �ۼ�', '/ework/mainPage.td', 'fas fa-edit'], 
					                                ['�ӽ�������', '/eworkForm/selectAuthBox.td', 'far fa-save'], 
					                                ['����', '/ework/selectAuth.td', 'fas fa-pen-fancy'], 
					                                ['���� �� ����', '/ework/selectSignStamp.td', 'fas fa-stamp']];
					else if (main == "3") sbList = [['��ݾ�', '/sponsor/selectSponsorship.td', 'fas fa-won-sign'],
					                                ['�Ŀ���', '/sponsor/selectMember.td', 'fas fa-user'], 
					                                ['�񿵸���ü', '/sponsor/selectCharity.td', 'fas fa-users']];
					else if (main == "4") sbList = [['��������', '/board/selectNotice.td', 'fas fa-bullhorn'], 
					                                ['���ǻ���', '/board/selectSuggestion.td', 'far fa-comments']];
					else {
						sbList = [];
						sidebar_width = 0;
						container_width = 100;
						display = 'none';
					}
					$(".sidebar").css("display", display).css("width", sidebar_width+'%');
					$(".context-container").css("width", container_width+'%');
					sideBar(sbList);
				});
				
			});
			
			// ���̵�޴� ����
			function sideBar(sbList){
				$(".sidebar-menu-content").html("");
				var sidebar = "<ul>";
				for (var i=0; i<sbList.length; i++){
					sidebar += "<li class='sidebar-menu'><a href="+sbList[i][1]+"?message=&selectFunc=><i class='"+sbList[i][2]+"'>&nbsp;"+sbList[i][0]+"</i></a></li>";
				}
				sidebar += "</ul>";
				//alert(sidebar);
				$(".sidebar-menu-content").html(sidebar);
			}
			
		</script>
	</head>
	<body>
		<!-- header wrap -->
		<div class="header-wrap">
			
			<!-- header-wrap -->
			<div class="header-wrap">
			
				<!-- header inner -->
				<ul class="header-inner">
				
					<!-- header-main-menu -->
					<li><a href="#">
						<i class="header-main-menu">
							<i class="far fa-calendar">&nbsp;<span>����ǥ</span></i>
							<input type="hidden" value="0"/>
						</i>
					</a></li>
					
					<li><a href="#">
						<i class="header-main-menu">
							<i class="far fa-user">&nbsp;<span>�λ����</span></i>
							<input type="hidden" value="1"/></i>
					</a></li>
		
					<li><a href="#">
						<i class="header-main-menu">
							<i class="far fa-edit">&nbsp;<span>���ڰ���</span></i>
							<input type="hidden" value="2"/></i>
					</a></li>
		
					<li><a href="#">
						<i class="header-main-menu">
							<i class="far fa-heart">&nbsp;<span>�Ŀ�����</span></i>
							<input type="hidden" value="3"/></i>
					</a></li>
					
					<li><a href="#">
						<i class="header-main-menu">
							<i class="fas fa-chalkboard">&nbsp;<span>�Խ���</span></i>
							<input type="hidden" value="4"/></i>
					</a></li>
					
				</ul>
				
			</div>
			
		</div>
	</body>
</html>