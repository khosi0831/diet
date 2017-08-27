<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html lang="ja">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="ie=edge" />
<title>Basic</title>
<link href="/css/sampleCss.css" href="@{/css/sampleCss.css}" rel="stylesheet"></link>
<link rel="stylesheet"
	href="../jquery/jquery-gantt-master/dist/jquery-gantt.css">
<!-- Demo stylesheet -->
<link rel="stylesheet"
	href="../jquery/jquery-gantt-master/examples/css/style.css">
<link rel="stylesheet"
	href="../jquery/jquery-ui-1.11.4.custom/jquery-ui.css">
</head>
<div class="box">
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
<div id="demo"></div>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="jquery/jquery-gantt-master/dist/jquery-gantt.js"></script>
<script src="jquery/jquery-gantt-master/examples/js/demo-diet.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="js/data.js"></script>
<script>
	$(function() {
		
		var array1 = [];
		var addData1 =
		{
		    "title": "マツコデラックス",
		    "startdate": "2017/07/1",
		    "enddate": "2017/08/11",
		    "url": "person.html",
		    "minNight": "41",
		    "price": {
		        "original": {
		            "price": 6,
		            "priceType": "マツコデラックス"
		        },
		        "converted": {
		            "price": 2673,
		            "priceType": "TL"
		        }
		    },
		    "tooltipData": {
		        "title": "Zaporojie Turu",
		        "image": "http://cdn.gezinomi.com//zaporojie-turu-1126--1-29.06.2016101219-b4.jpg",
		        "desc": ["Atlas Global Havayolları Tarifeli Seferi ile ", " Türkçe Rehber ", " Vizesiz ", " 3 Gece - 4 Gün ", " Zaporojie (3)"],
		        "dates": {
		            "begin": "21 Temmuz 2016 Perşembe",
		            "end": "24 Temmuz 2016 Pazar"
		        },
		        "url": null
		    },
		    "dateorder": "\/Date(1469048400000)\/"
		}
		addData1.title="まつこ";
		addData1.startdate="2017/07/15";
		addData1.enddate="2017/08/11";
		addData1.minNight="30";
		addData1.price.original.price="デラックス";
		array1.push(addData1);
		
		var addData2 = $.extend(true, {}, addData1);

		addData2.title="ほし";
		addData2.startdate="2017/08/15";
		addData2.enddate="2017/08/30";
		addData2.minNight="15";
		addData2.price.original.price="ほし";
		array1.push(addData2);
		
		$('#demo').gantt({
			data : array1,
			startDate : new Date('2017-07-01'),
			endDate : new Date('2017-09-01'),
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

		$("#from").datepicker();
		//    $( "#to" ).datepicker();
		//		$( "input" ).checkboxradio();
		$("#start").datepicker();
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
			    	item.id(plans[i].week)
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
</body>
<hr>
<div id="plan" contenteditable="true">ウオーキング</div>
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
　　<tr>
</div>
  <div id="tabs_plan">
    計画
		<div class="box">
				<button type="button" id="btn_plan"><img src="images/save.png"/></button>
		</div>
		<div class="messgae">
			<table id="plan111" border="1"></table></table>
		</div>
	</div>
</html>
