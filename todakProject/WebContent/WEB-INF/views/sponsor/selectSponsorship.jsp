<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
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

<%
	List<List> dataList = new ArrayList<List>();
	List<SponsorshipVO> sList = (List<SponsorshipVO>)request.getAttribute("sponsorshipList");
	if(sList != null){
		Iterator<SponsorshipVO> iter = sList.iterator();
		while (iter.hasNext()){
			SponsorshipVO ssvo = iter.next();
			List tmpList = new ArrayList<List>();
			tmpList.add(Integer.parseInt(ssvo.getSs_sponsoreddate()));
			tmpList.add(Integer.parseInt(ssvo.getSs_amount()));
			
			dataList.add(tmpList);
			tmpList = null;
		}
	}
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
				
		<script language="javascript" type="text/javascript" src="/include/js/sponsor/source/jquery.js"></script>
		<script language="javascript" type="text/javascript" src="/include/js/sponsor/lib/jquery.event.drag.js"></script>
	    <script language="javascript" type="text/javascript" src="/include/js/sponsor/lib/jquery.mousewheel.js"></script>
		<script language="javascript" type="text/javascript" src="/include/js/sponsor/source/jquery.canvaswrapper.js"></script>
		<script language="javascript" type="text/javascript" src="/include/js/sponsor/source/jquery.colorhelpers.js"></script>
		<script language="javascript" type="text/javascript" src="/include/js/sponsor/source/jquery.flot.js"></script>
		<script type="text/javascript"
				src="https://cdnjs.cloudflare.com/ajax/libs/flot/0.8.3/jquery.flot.time.min.js"></script>
		<script type="text/javascript"
				src="https://cdnjs.cloudflare.com/ajax/libs/timezone-js/0.4.13/date.min.js"></script>
		<script language="javascript" type="text/javascript" src="/include/js/sponsor/source/jquery.flot.saturated.js"></script>
		<script language="javascript" type="text/javascript" src="/include/js/sponsor/source/jquery.flot.browser.js"></script>
		<script language="javascript" type="text/javascript" src="/include/js/sponsor/source/jquery.flot.drawSeries.js"></script>
		<script language="javascript" type="text/javascript" src="/include/js/sponsor/source/jquery.flot.uiConstants.js"></script>
		<script language="javascript" type="text/javascript" src="/include/js/sponsor/source/jquery.flot.navigate.js"></script>
		<script language="javascript" type="text/javascript" src="/include/js/sponsor/source/jquery.flot.touchNavigate.js"></script>
		<script language="javascript" type="text/javascript" src="/include/js/sponsor/source/jquery.flot.hover.js"></script>
		<script language="javascript" type="text/javascript" src="/include/js/sponsor/source/jquery.flot.touch.js"></script>
		<script language="javascript" type="text/javascript" src="/include/js/sponsor/source/jquery.flot.selection.js"></script>
		<script language="javascript" type="text/javascript" src="/include/js/sponsor/source/jquery.flot.stack.js"></script>
		<script type="text/javascript">
			$(function(){
				//alert("start!!!");
				
				drawPlot();
				
				$('#dateCriteria input').on('change', function() {
					drawPlot();
		        });
				
			});

			function drawPlot(){
	            var dateCriteriaVal = $('input[name="dateCriteria"]:checked', '#dateCriteria').val();

				var data = updateData(dateCriteriaVal);

				var options = updateOptions(dateCriteriaVal);

				var plot = $.plot($("#placeholder"), data, options);
				
			}
			
			function updateData(dateCriteriaVal){
				var data = [];
				<%
					System.out.println(dataList);
					for (int i=0; i < dataList.size(); i++){
				%>
							var tmpDates = <%=dataList.get(i).get(0)%>;
							var dates = tmpDates.toString();
							var year = dates.slice(0, 4);
							var month = dates.slice(4, 6);
							var day = dates.slice(6, 8);
							
							if (dateCriteriaVal == 'year'){
								var dates2 = year;
							}
							if (dateCriteriaVal == 'month'){
								var dates2 = year + "/" + month;
							}
							if (dateCriteriaVal == 'day'){
								var dates2 = year + "/" + month + "/" + day;
							}

							var dates3 = new Date(dates2);

							var tmpAmount = <%=dataList.get(i).get(1)%>;
							
							var amount = tmpAmount.toString();
							
							var tmp = [ Date.parse(dates3), parseInt(amount)];
							
							var count = 1;
							// 데이터 리스트에 데이터가 있는지 확인
							if (data.length == 0){
								// 없으면 새로운 리스트를 생성해서 데이터 push
								data.push([tmp]);
							}else{
								count++;
								// 있으면 리스트 안에 같은날짜의 데이터가 있는지 확인
								for (var i=0; i<data.length; i++){
									var checker = false;
									for (var j=0; j<data[i].length; j++){
										if (tmp[0] == data[i][j][0]){
											// 똑같은 날짜의 데이터가 있으면 checker는 true
											checker = true;
											break;
										}
									}
									
									// checker가 true이면 다음 리스트 확인
									if (checker){
										// 다음 리스트 존재하는지 확인
										if (data.length == (i+1)){
											// 없으면 새로운 리스트를 생성해서 데이터 push
											data.push([tmp]);
											break;
										}else{
											// 다음 리스트 있으면 다음으로 이동
										}
									}else{
									// checker가 false이면 똑같은 날짜의 데이터가 없으면 해당 리스트에 push하고 break
										data[i].push(tmp);
										break;
									}
								}
							}
							
				<%
					}
				%>
				//alert(data.length);

				return data;
			}
			
			function updateOptions(dateCriteriaVal){
				var tickSize = [];
				var timeformat = "";
				var autoScale = "none";

				
				if (dateCriteriaVal == 'year'){
					tickSize = [1, "year"];
					timeformat = "%y";
				}
				if (dateCriteriaVal == 'month'){
					tickSize = [1, "month"];
					timeformat = "%y.%m";
				}
				if (dateCriteriaVal == 'day'){
					tickSize = [1, "year"];
					timeformat = "%y.%m.%d";
					autoScale = "true";
				}
				//alert("113333");
				var options = 
					{ 
						yaxis: {
							min: 0,
							tickFormatter: formatter,
							axisPan: false,
							plotPan: false,
							zoomRange: [0, 10]
						},
						xaxis: {
							min: Date.parse(new Date("2018/07/01")),
							max: Date.parse(new Date("2020/04/01")),
							tickSize: tickSize,
							mode: "time",
							timeBase: "milliseconds",
							timeformat: timeformat,
							autoScale: autoScale
						},
						series: {
							stack: 0,
							bars: {
								show: true,
								barWidth: 0.6,
								align: "center", 
								fill: true, 
								fillColor: "rgba(122, 155, 122, 0.8)",
								lineWidth: 0
							}
						},
						zoom: {
							interactive: true
						},
						pan: {
							interactive: true,
							enableTouch: true
						}
				 	 };
				return options;
				
				
			}

			
			function formatter(val, axis) {
				var tmp = val.toFixed(axis.tickDecimals);
				var amount = tmp.split("");
				for(var i=0; i<4; i++){
					amount.pop();
				}
				var word = "";
				var count = 1;
				while(amount.length > 0){
					if (count == 5) word = "," + word;
					var tmpWord = amount.pop();
					word = tmpWord.toString() + word;
					count++;
				}
			    return word; 
			}
			
			
		</script>
		<%--
		<link rel="stylesheet" href="/include/css/sponsor/sponsorship.css">
		 --%>
		<title>Insert title here</title>
	</head>
	<body>
         <header class="header"> 
            <%@ include file="/WEB-INF/views/commons/header.jsp" %>
         </header>

         <aside class="sidebar">
            <%@ include file="/WEB-INF/views/commons/sidebar.jsp" %>
         </aside>
         
		<% System.out.println(sManager.getUserID(session.getId())); %>
		<div class="context-container">
		
			
			<!-- graph -->
			<div id="placeholder" style="width:1200px;height:600px">
			
			</div>
			
			<fieldset id="dateCriteria">
	            <legend> 연, 월, 일 표기 </legend>
	            <input type="radio" name="dateCriteria" value="year" /> 연 <br />
	            <input type="radio" name="dateCriteria" value="month" checked="checked"/> 월 <br />
	            <input type="radio" name="dateCriteria" value="day" /> 일 <br />
	        </fieldset>
	        
		</div>
	</body>
</html>