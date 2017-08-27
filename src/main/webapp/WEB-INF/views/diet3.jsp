<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="X-UA-Compatible" content="ie=edge" />
<title>顧客管理</title>
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
	開始日: <input type="text" id="from"> 
	名称: <input type="text"　id="name">
	興味: <input type="text"　id="name">
	<button type="button" id="btn_search">
		<img src="images/search.png" />
	</button>
	<button type="button" id="btn_memplus">
		<img src="images/memplus.png" />
	</button>
	<button type="button" id="btn_del">
		<img src="images/del.png" />
	</button>
	<button type="button" id="btn_meminfo"><img src="images/kao_small.png"/></button>
</div>
<div id="demo"></div>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="jquery/jquery-gantt-master/dist/jquery-gantt.js"></script>
<script src="jquery/jquery-gantt-master/examples/js/demo-diet.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="js/data.js"></script>
  <script>
  $( function() {
    var array1 = [];
		array1.push(eventsData[1]);
		array1.push(eventsData[0]);
    $('#demo').gantt({
      data: array1,
      startDate: new Date('2017-07-01'),
      endDate: new Date('2017-09-01'),
    });
		$('#btn_plan').click(function(){
   		$( "#tabs_plan" ). dialog( {
    	} );
		});

		$('#btn_memplus').click(function(){
   		$( "#memplus" ). dialog( {
//        height: 600,
//        width: 800
    	} );
		});
		$('#btn_search').click(function(){
			$('#member_detail').css('display','block');
		});
		$('#btn_meminfo').click(function(){
   		$( "#meminfo" ). dialog( {
        height: 600,
        width: 800
    	} );
		});

    $( "#from" ).datepicker();
//    $( "#to" ).datepicker();
//		$( "input" ).checkboxradio();
    $( "#start" ).datepicker();

/*
		var members = [
		    { "lastname": "マツコ", "firstname": "デラックス","email": "matuko@gmail.com", "startDate": "2017/07/01", "memo": "めも" , "status": "4週" , "site": "<a href='file:///L://イフネット/test/person.html' target='_blank'>goto site</a>"},
		    { "lastname": "ブルゾン", "firstname": "ちえみ","email": "chiemi@gmail.com", "startDate": "2017/08/01", "memo": "めも" , "status": "2週" , "site": "<a href='file:///L://イフネット/test/person.html' target='_blank'>goto site</a>"},
		    { "lastname": "石塚", "firstname": "英彦","email": "ishi@gmail.com", "startDate": "2017/08/01", "memo": "めも" , "status": "2週" , "site": "<a href='file:///L://イフネット/test/person.html' target='_blank'>goto site</a>"}
		]
				$("#members1").append(
				    $("<tr></tr>")
				        .append($("<th></th>").text("lastname"))
				        .append($("<th></th>").text("firstname"))
				        .append($("<th></th>").text("email"))
				        .append($("<th></th>").text("startDate"))
				        .append($("<th></th>").text("memo"))
				        .append($("<th></th>").text("status"))
				        .append($("<th></th>").text("site"))
				);

		for(var i in members){
		    //$("#selectable").append("<li class='ui-widget-content'>" + members[i].lastname + members[i].firstname + "</li>");
				$("#members1").append(
				    $("<tr></tr>")
				        .append($("<td></td>").text(members[i].lastname))
				        .append($("<td></td>").text(members[i].firstname))
				        .append($("<td></td>").text(members[i].email))
				        .append($("<td></td>").text(members[i].startDate))
				        .append($("<td></td>").text(members[i].memo))
				        .append($("<td></td>").text(members[i].status))
				        .append($("<td></td>").text(members[i].site))
				);
		}
*/
  });
						

  </script>

<script>
$.ajax({
  type: 'GET',
  url: 'http://localhost:8080/customer/selectall',
  dataType: 'json',
  success: function(json){
    console.log(json)
  }
});
</script>


</body>

<hr>
<ol id="selectable"></ol>
<table id="members1" border="1"></table>
<div id="member_detail" title="memberList">
	<p>会員一覧</p>
	<div id="members">
	<table border="1">
		<tr>
			<th></th>
			<th>名称</th>
			<th>e-mail</th>
			<th>startDate</th>
			<th>興味</th>
			<th>状態</th>
			<th>サイト</th>
			<th>計画</th>
		</tr>
		<tr>
			<td><input type="checkbox" name="checkbox-1" id="checkbox-1"></td>
			<td>マツコデラックス</td>
			<td>matuko@gmail.com</td>
			<td>2017/07/01</td>
      <td>エステ・化粧品</td>
			<td>6週2日</td>
			<td><a href="file:///C://イフネット/test/person.html" target="_blank">click</a></td>
			<td><div id="btn_plan">click<div></td>
		</tr>
		<tr>
			<td><input type="checkbox" name="checkbox-1" id="checkbox-1"></td>
			<td>ブルゾンちえみ</td>
			<td>chiemi@gmail.com</td>
			<td>2017/08/01</td>
      		<td>ファッション</td>
			<td>2週2日</td>
			<td>click</td>
			<td>click</td>
		</tr>
		<tr>
			<td><input type="checkbox" name="checkbox-1" id="checkbox-1"></td>
			<td>石塚英彦</td>
			<td>ishi@gmail.com</td>
			<td>2017/08/01</td>
      		<td>グルメ情報</td>
			<td>2週2日</td>
			<td>click</td>
			<td>click</td>
		</tr>
	</table>
	</div>
<div id="member" title="memberList" style="display: none">
	name:<input id="tags">
	<button type="button" id="btn_search"><img src="images/search.png"/></button>
	<button type="button" id="btn_del"><img src="images/del.png"/></button>
	<br/>
	<br/>
	<div id="members">
	<table border="1">
		<tr>
			<th></th>
			<th>name</th>
			<th>startDate</th>
			<th>status</th>
		</tr>
		<tr>
			<td><input type="checkbox" name="checkbox-1" id="checkbox-1"></td>
			<td>マツコデラックス</td>
			<td>2017/07/01</td>
      <td>normal</td>
		</tr>
		<tr>
			<td><input type="checkbox" name="checkbox-1" id="checkbox-1"></td>
			<td>ブルゾンちえみ</td>
			<td>2017/08/01</td>
      <td>normal</td>
		</tr>
		<tr>
			<td><input type="checkbox" name="checkbox-1" id="checkbox-1"></td>
			<td>石塚英彦</td>
			<td>2016/08/01</td>
      <td>normal</td>
		</tr>
	</table>
	</div>

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
	<div id="meminfo" style="display: none">
		<button type="button" id="btn_save"><img src="images/save.png"/></button>
		<table border="1">
			<tr>
				<th>No</th>
				<th>内容</th>
			</tr>
			<tr>
				<th>1</th>
				<td><div contenteditable="true">なぜダイエットをしたいと思われましたか？いつ頃から太り始めましたでしょうか？ダイエット以外の目的もあれば教えてください。</div></td>
			</tr>
			<tr>
				<th>2</th>
				<td><div contenteditable="true">いつもでどうなりたいですか？（３ヶ月後の目標と最終目標）</div></td>
			</tr>
			<tr>
				<th>3</th>
				<td><div contenteditable="true"></div></td>
			</tr>
			<tr>
				<th>4</th>
				<td><div contenteditable="true"></div></td>
			</tr>
			<tr>
				<th>5</th>
				<td><div contenteditable="true"></div></td>
			</tr>
			<tr>
				<th>6</th>
				<td><div contenteditable="true"></div></td>
			</tr>
			<tr>
				<th>7</th>
				<td><div contenteditable="true"></div></td>
			</tr>
			<tr>
				<th>8</th>
				<td><div contenteditable="true"></div></td>
			</tr>
			<tr>
				<th>9</th>
				<td><div contenteditable="true"></div></td>
			</tr>
			<tr>
				<th>10</th>
				<td><div contenteditable="true"></div></td>
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
			<table border="1">
				<tr>
					<th>週</th>
					<th>計画</th>
				</tr>
				<tr>
					<td>1</td>
					<td><div id="w1_plan" contenteditable="true">タンパク質を摂る</div></td>
				</tr>
				<tr>
					<td>2</td>
					<td><div id="w2_plan" contenteditable="true">ウオーキング</div></td>
				</tr>
				<tr>
					<td>3</td>
					<td><div id="w3_plan" contenteditable="true">非言語コミュニケーション</div></td>
				</tr>
				<tr>
					<td>4</td>
					<td><div id="w4_plan" contenteditable="true">鏡を見る</div></td>
				</tr>
				<tr>
					<td>5</td>
					<td><div id="w5_plan"  contenteditable="true">ケトジェニック</div></td>
				</tr>
				<tr>
					<td>6</td>
					<td><div id="w6_plan"  contenteditable="true">プチ断食</div></td>
				</tr>
				<tr>
					<td>7</td>
					<td><div id="w7_plan" contenteditable="true">ウオーキング</div></td>
				</tr>
				<tr>
					<td>8</td>
					<td><div id="w8_plan" contenteditable="true">失敗の科学</div></td>
				</tr>
				<tr>
					<td>9</td>
					<td><div id="w9_plan" contenteditable="true">ウオーキング</div></td>
				</tr>
				<tr>
					<td>10</td>
					<td><div id="w10_plan" contenteditable="true">ウオーキング</div></td>
				</tr>
				<tr>
					<td>11</td>
					<td><div id="w11_plan" contenteditable="true">ウオーキング</div></td>
				</tr>
				<tr>
					<td>12</td>
					<td><div id="w12_plan" contenteditable="true">ウオーキング</div></td>
				</tr>
			</table>
		</div>
  </div>

</div>
</html>
