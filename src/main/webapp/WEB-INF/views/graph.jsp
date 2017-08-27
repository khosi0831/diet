<%@ page language="java" contentType="text/html; charset=UTf-8"
	pageEncoding="UTf-8"%>
<html lang="jp">
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="ie=edge" />
<head>
<link rel="stylesheet" type="text/css"
	href="/jquery/jquery.ganttView-master/lib/jquery-ui-1.8.4.css" />
<link rel="stylesheet" type="text/css"
	href="/jquery/jquery.ganttView-master/example/reset.css" />
<link rel="stylesheet" type="text/css"
	href="/jquery/jquery.ganttView-master/jquery.ganttView.css" />
<link rel="stylesheet"
	href="../jquery/jquery-ui-1.11.4.custom/jquery-ui.css">
<style type="text/css">
body {
	font-family: tahoma, verdana, helvetica;
	font-size: 0.8em;
	padding: 10px;
}
</style>
<script type="text/javascript"
	src="jquery/jquery.ganttView-master/lib/jquery-1.4.2.js"></script>
<script type="text/javascript"
	src="jquery/jquery.ganttView-master/lib/date.js"></script>
<script type="text/javascript"
	src="jquery/jquery.ganttView-master/lib/jquery-ui-1.8.4.js"></script>
<script type="text/javascript"
	src="jquery/jquery.ganttView-master/jquery.ganttView.js"></script>
<link type="text/css" href="/jquery/jquery-ui-1.8.4/themes/base/jquery.ui.all.css" rel="stylesheet" />
<script type="text/javascript" src="jquery/jquery-ui-1.8.4/ui/jquery.ui.core.js"></script>
<script type="text/javascript" src="jquery/jquery-ui-1.8.4/ui/jquery.ui.widget.js"></script>
<script type="text/javascript" src="jquery/jquery-ui-1.8.4/ui/jquery.ui.datepicker.js"></script>
<link type="text/css" href="/jquery/jquery-ui-1.8.4/demos/demos.css" rel="stylesheet" />
	<script type="text/javascript" src="/jquery/jquery-ui-1.8.4/jquery-1.4.2.js"></script>

<script>
	$(function() {
		$("#datepicker").datepicker();
		$("#from").datepicker();
		
		var ganttData = [
			{
				id: 1, name: "マツコ", series: [
					{ name: "4週1日", start: new Date(2017,07,01), end: new Date(2017,07,30) }
				]
			},
			{
				id: 1, name: "星", series: [
					{ name: "4週1日", start: new Date(2017,08,01), end: new Date(2017,08,30) }
				]
			}
		];		
		$("#ganttChart").ganttView(
				{
					data : ganttData,
					slideWidth : 900,
					behavior : {
						onClick : function(data) {
							var msg = "You clicked on an event: { start: "
									+ data.start.toString("M/d/yyyy")
									+ ", end: "
									+ data.end.toString("M/d/yyyy") + " }";
							$("#eventMessage").text(msg);
						},
						onResize : function(data) {
							var msg = "You resized an event: { start: "
									+ data.start.toString("M/d/yyyy")
									+ ", end: "
									+ data.end.toString("M/d/yyyy") + " }";
							$("#eventMessage").text(msg);
						},
						onDrag : function(data) {
							var msg = "You dragged an event: { start: "
									+ data.start.toString("M/d/yyyy")
									+ ", end: "
									+ data.end.toString("M/d/yyyy") + " }";
							$("#eventMessage").text(msg);
						}
					}
				});

		
		$('#btn_plan').click(function() {
			$("#tabs_plan").dialog({});
		});

		$('#btn_memplus').click(function() {
	        $.ajax({
	            type : 'post',
	            url : "http://localhost:8080/counter/test",
	            data : JSON.stringify({"id":1,"title":$("#demo11").val(),"count":1}),
	            contentType: 'application/JSON',
	            dataType : 'JSON',
	            scriptCharset: 'utf-8',
	            success : function(data) {

	                // Success
	                alert("success");
	                alert(JSON.stringify(data));
	                $("#response").html(JSON.stringify(data));
	            },
	            error : function(data) {

	                // Error
	                alert("error");
	                alert(JSON.stringify(data));
	                $("#response").html(JSON.stringify(data));
	            }
	        });
			
			//$("#memplus").dialog({
			//        height: 600,
			//        width: 800
			//});
		});
		$('#btn_search').click(function() {
			$('#member_detail').css('display', 'block');
		});

		//    $( "#to" ).datepicker();
		//		$( "input" ).checkboxradio();
		//$("#start").datepicker();
		$.ajax({
			  type: 'GET',
			  url: '/customer/selectall',
			  dataType: 'json',
			  success: function(json){
				//$("#message11").text(json[0].name);
				var members = json;
				$("#members11").append(
					 $("<tr></tr>")
					        .append($("<th></th>").text("名前"))
					        .append($("<th></th>").text("メール"))
					        .append($("<th></th>").text("開始日"))
					        .append($("<th></th>").text("メモ"))
					        .append($("<th></th>").text("興味"))
					        .append($("<th></th>").text("状態"))
					        .append($("<th></th>").text("サイト"))
					        .append($("<th></th>").text("計画"))
				);

			    for(var i in members){
					$("#members11").append(
					    $("<tr></tr>")
					        .append($("<td></td>").text(members[i].name))
					        .append($("<td></td>").text(members[i].email))
					        .append($("<td></td>").text(members[i].startdateStr))
					        .append($("<td></td>").text(members[i].memo))
					        .append($("<td></td>").text(members[i].favorite))
					        .append($("<td></td>").text(members[i].status))
					        .append($("<td></td>").text(members[i].site))
					        .append($("<td></td>").text(members[i].plan))
					);
			    }
				
			  }
			});
		//計画
		$.ajax({
			  type: 'GET',
			  url: '/plan/selectall',
			  dataType: 'json',
			  success: function(json){
			  var plans = json;
				$("#plan111").append(
					 $("<tr></tr>")
					        .append($("<th></th>").text("週"))
					        .append($("<th></th>").text("計画"))
				);
			    for(var i in plans){
			    	var item = $.extend(true, {}, $("#plan").clone());
			    	item.text(plans[i].plan)
//			    	item.id(plans[i].week)
					$("#plan111").append(
					    $("<tr></tr>")
					        .append($("<td></td>").text(plans[i].week))
							.append($("<td></td>").append(item))
					);
			    }
			  }
			});
		
	});
</script>
<title>jQuery Gantt</title>
</head>
<body>
	<div class="box">
	<input type="text" id="datepicker" size="30"/>
		from: <input type="text" id="from"> name: <input type="text"
			id="name">
		<button type="button" id="btn_search">
			<img src="images/search.png" />
		</button>
		<button type="button" id="btn_memplus">
			<img src="images/memplus.png" />
		</button>
		<button type="button" id="btn_del">
			<img src="images/del.png" />
		</button>
	</div>


	<div id="ganttChart"></div>
	<br />
	<br />
<hr>
<div id="plan" contenteditable="true">ウオーキング</div>>
<div id="demo111" contenteditable="true">aa</div>
<textarea name="ta" id="demo11"></textarea>
<table id="members11" border="1"></table>
	<div id="memplus" style="display: none">
		<button type="button" id="btn_save"><img src="images/save.png"/></button>
		<table border="1">
			<tr>
				<th>名称</th>
				<td><input name="firstname" /></td>
			</tr>
			<tr>
				<th>パスワード</th>
				<td><input name="password" /></td>
			</tr>
			<tr>
				<th>e-mail</th>
				<td><input name="e-mail" /></td>
			</tr>
			<tr>
				<th>開始日</th>
				<td><input type="text" id="to"></td>
			</tr>
			<tr>
				<th>興味</th>
				<td><textarea name="kanso" rows="4">ここにメモを記入してください。</textarea></td>
			</tr>
		</table>
</div>
  <div id="tabs_plan">
    計画
		<div class="box">
				<button type="button" id="btn_plan"><img src="images/save.png"/></button>
		</div>
		<div class="messgae">
			<table id="plan111" border="1"></table>
		</div>
	</div>
	<div id="eventMessage"></div>
</body>
</html>
