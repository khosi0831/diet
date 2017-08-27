<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="ja">
<html lang="jp">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>顧客情報</title>
<link rel="stylesheet"
	href="../jquery/jquery-ui-1.11.4.custom/jquery-ui.css">
<link rel="stylesheet"
	href="../jquery/jquery-gantt-master/examples/css/style.css">

<link href="../jquery/lity-2.3.0/dist/lity.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.3.0/Chart.bundle.min.js"></script>
<script src="jqury/lity-2.3.0/dist/lity.js"></script>
<script>
  $( function() {
    $( "#menu" ).menu();
    $( "#tabs" ).tabs();
    ctx = document.getElementById("canvas").getContext("2d");
    window.myBar = new Chart(ctx, {
        type: 'bar',
        data: barChartData,
        options: complexChartOption
    });
		$(".photo img").bind("load",function(){
			var ImgHeight = $(this).height();
			$('.photo').css('height',ImgHeight);
		});		
		$('.nav a').click(function(){
			if($(this).hasClass('over') == false){
				$('.nav a').removeClass('over');
				$(this).addClass('over');
				$('.photo img').hide().attr('src',$(this).attr('href')).fadeIn();
			};
			return false;
		}).filter(':eq(0)').click();
		$('#btn_weight').click(function(){
   		$( "#dialog_weigt" ).dialog();
		});
	  $('#file').change(function() {
	    var fr = new FileReader();
	    fr.onload = function() {
	    var img = $('<img>').attr('src', fr.result);
	    $('#preview').append(img);
	    };
	  fr.readAsDataURL(this.files[0]);
	  });

		$('#btn_weight').click(function(){
   		$( "#dialog_weigt" ).dialog();
		});
		$('#history_file').click(function(){
   		$( "#file" ).click();
		});

//--------ここからはテストですaaaaaaa
  } );

  </script>
<style>
.ui-menu {
	width: 150px;
}

.box {
	display: inline-block;
	font-size: 16px;
}

.demo {
	width: 500px;
	margin: 0 auto;
	padding: 10px 0;
	font-family: sans-serif;
	font-size: 30px;
	color: black;
}

.heading {
	margin: 10px 0
}

.demo0 .heading {
	position: relative;
	padding-left: 30px;
}

.demo0 .heading:before, .demo0 .heading:after {
	content: "□";
	position: absolute;
	width: 4px;
	height: 4px;
}

.demo0 .heading:before {
	left: 0;
	top: -3px;
}

.demo0 .heading:after {
	left: 5.5px;
	top: 3.5px;
}

$("#week " ).selectmenu ();
	/* チャットレイアウト */ 
	.chat-box {
	width: 60%;
	height: auto;
	overflow: hidden; /*floatの解除*/
	margin-bottom: 20px;
}

.chat-area {
	width: 60%;
	float: left;
}

.chat-hukidashi {
	display: inline-block; /*コメントの文字数に合わせて可変*/
	padding: 15px 20px;
	margin-left: 1px;
	margin-top: 10px;
	border: 1px solid gray;
	border-radius: 10px;
}

.chat-hukidashi2 {
	display: inline-block; /*コメントの文字数に合わせて可変*/
	padding: 15px 20px;
	margin-left: 20px;
	margin-top: 10px;
	border: 1px solid gray;
	border-radius: 10px;
}

h1 {
	color: #6594e0; /*文字色*/
	border-bottom: dashed 2px #6594e0;
	/*線の種類（点線）2px 線色*/ /*線の種類（実線） 太さ 色*/
}
.right {
   text-align: right;
}

</style>
</head>
<body>
	<div class="demo demo0">
		<div class="heading">W1 マツコデラックス様</div>
	</div>
	<label for="week">週</label>
	<select name="week" id="week">
		<option>１週</option>
		<option>２週</option>
		<option selected="selected">３週</option>
		<option>４週</option>
		<option>５週</option>
		<option>まとめ</option>
	</select> おしゃべりはこちら→
	<a href="#tabs_plan">chat work</a>
	<div>
		<div id="tabs">
			<ul>
				<li><a href="#tabs_diary">週まとめ</a></li>
				<li><a href="#tabs_plan">計画</a></li>
				<li><a href="#tabs_member">会員情報</a></li>
			</ul>
			<div id="tabs_diary">
				<div id="tabs_weight">
					<h1>グラフ</h1>
					<div class="box">
						<button type="button" id="btn_weight">
							<img src="images/edit.png" />
						</button>
					</div>
					<div class="container" style="width: 60%">
						<canvas id="canvas"></canvas>
					</div>
					<div>
						<table border="1">
							<tr>
								<th width="10%">週</th>
								<th width="30%">体重</th>
								<th width="30%">マイル</th>
								<th width="30%">差分</th>
							</tr>
							<tr>
								<td>B</td>
								<td contenteditable="true" class="right">90</td>
								<td contenteditable="true" class="right">10</td>
								<td class="right">0</td>
							</tr>
							<tr>
								<td>W1</td>
								<td contenteditable="true" class="right">85</td>
								<td contenteditable="true" class="right">10</td>
								<td class="right">5</td>
							</tr>
							<tr>
								<td>W2</td>
								<td contenteditable="true" class="right">80</td>
								<td contenteditable="true" class="right">15</td>
								<td class="right">5</td>
							</tr>
						</table>
					</div>
				</div>
				<div id="tabs_try">
					<h1>レクチャー</h1>
					<div class="box">
						<button type="button" id="try_save">
							<img src="images/save.png" />
						</button>
					</div>
					<textarea id="try_msg"name="msg" cols=100 rows=20>
●コン食無糖
  コントロールできる食事は炭水化物なしにする。
●炭水化物のグラム数をチェック     
食品のチェックは、カロリーではなく炭水化物（糖質）のグラム数
			</textarea>
					<div id="try_copy" contenteditable="true"></div>

				</div>
				<div id="tabs_history">
					<h1>写真</h1>
					<div class="message">
						<div id="selectable">
							<input type="checkbox" name="checkbox-1" id="checkbox-1"><a
								href="/images/image.jpg" data-lity><img border="0" src="/images/image.jpg"
								width="128" height="128" alt="イラスト1"></a>
						</div>
						<div id="selectable">
							<input type="checkbox" name="checkbox-1" id="checkbox-1"><a
								href="/images/image1.jpg" data-lity><img border="0" src="/images/image1.jpg"
								width="128" height="128" alt="イラスト1"></a>
						</div>
						<span class="fileinput-button"> <input type="file"
							id="file" style="visibility: hidden"> <img src=""
							id="preview">
							<button type="button" id="history_file">
								<img src="images/file.png" />
							</button>
							<button type="button" id="btn_del">
								<img src="images/del.png" />
							</button>
						</span>
					</div>
				</div>
				<div id="tabs_advice">
					<h1>振返り</h1>
					<div class="box">
						<button type="button" id="btn_advice">
							<img src="images/save.png" />
						</button>
					</div>
					<textarea id="advice_msg"name="msg" cols=100 rows=20>
◆今週のつぶやき  
    コーヒ5杯飲んでます。体がギリギリのところまできります。
◆応援エール偶然ですが、ダイエットを始めてよかったと思います。
					</textarea>
				</div>
			</div>
			<div id="tabs_plan">
				<h1>計画</h1>
				<div class="box">
					<button type="button" id="btn_plan">
						<img src="images/save.png" />
					</button>
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
							<td><div id="w5_plan" contenteditable="true">ケトジェニック</div></td>
						</tr>
						<tr>
							<td>6</td>
							<td><div id="w6_plan" contenteditable="true">プチ断食</div></td>
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
			<div id="tabs_member">
				<h1>メンバー登録</h1>
				<div class="box">
					<button type="button" id="btn_plan">
						<img src="images/save.png" />
					</button>
				</div>

				<div class="messgae">
					<table border="1">
						<tr>
							<th>名前</th>
							<td>マツコデラックス
								</div>
							</td>
						</tr>
						<tr>
							<td>email</td>
							<td><div id="w2_plan" contenteditable="true">matuko@gmail.co.jp</div></td>
						</tr>
						<tr>
							<td>パスワード</td>
							<td><div id="w3_plan" contenteditable="true">****</div></td>
						</tr>
						<tr>
							<td>開始日</td>
							<td><div id="w4_plan" contenteditable="true">2017/08/01</div></td>
						</tr>
						<tr>
							<td>興味</td>
							<td><div id="w5_plan" contenteditable="true">映画</div></td>
						</tr>
					</table>
					<hr>
					<div class="chat-box">
						<div class="chat-area">
							<div class="chat-hukidashi">
								<img src="images/woman.png" alt="誰かのチャット画像です。" width="30"
									height="30">
								なぜダイエットをしたいと思われましたか？いつ頃から太り始めましたでしょうか？ダイエット以外の目的もあれば教えてください。
							</div>
						</div>
						<div class="chat-area">
							<div class="chat-hukidashi2">醜いので。４２－４３歳くらいから</div>
						</div>
					</div>
					<div class="chat-box">
						<div class="chat-area">
							<div class="chat-hukidashi">
								<img src="images/woman.png" alt="誰かのチャット画像です。" width="30"
									height="30"> いつもでどうなりたいですか？（３ヶ月後の目標と最終目標）
							</div>
						</div>
						<div class="chat-area">
							<div class="chat-hukidashi2">３ヶ月後に１０キロ減</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div id="dialog_weigt" title="weight&wellness" style="display: none">
			<button type="button" id="btnSave_weight">
				<img src="images/save.png" />
			</button>
			<table>
				<tr>
					<th width="10%">週</th>
					<th width="30%">体重</th>
					<th width="30%">マイル</th>
					<th width="30%">差分</th>
				</tr>
				<tr>
					<td>W1</td>
					<td><input type="text" size="6"></td>
					<td><input type="text" size="6"></td>
					<td>10</td>
				</tr>
				<tr>
					<td>W2</td>
					<td><input type="text" size="6"></td>
					<td><input type="text" size="6"></td>
					<td>10</td>
				</tr>
				<tr>
					<td>W3</td>
					<td><input type="text" size="6"></td>
					<td><input type="text" size="6"></td>
					<td>10</td>
				</tr>
				<tr>
					<td>W4</td>
					<td><input type="text" size="6"></td>
					<td><input type="text" size="6"></td>
					<td>10</td>
				</tr>
				<tr>
					<td>W5</td>
					<td><input type="text" size="6"></td>
					<td><input type="text" size="6"></td>
					<td>10</td>
				</tr>
				<tr>
					<td>W6</td>
					<td><input type="text" size="6"></td>
					<td><input type="text" size="6"></td>
					<td>10</td>
				</tr>
				<tr>
					<td>W7</td>
					<td><input type="text" size="6"></td>
					<td><input type="text" size="6"></td>
					<td>10</td>
				</tr>
				<tr>
					<td>W8</td>
					<td><input type="text" size="6"></td>
					<td><input type="text" size="6"></td>
					<td>10</td>
				</tr>
				<tr>
					<td>W9</td>
					<td><input type="text" size="6"></td>
					<td><input type="text" size="6"></td>
					<td>10</td>
				</tr>
				<tr>
					<td>W10</td>
					<td><input type="text" size="6"></td>
					<td><input type="text" size="6"></td>
					<td>10</td>
				</tr>
				<tr>
					<td>W11</td>
					<td><input type="text" size="6"></td>
					<td><input type="text" size="6"></td>
					<td>10</td>
				</tr>
				<tr>
					<td>W12</td>
					<td><input type="text" size="6"></td>
					<td><input type="text" size="6"></td>
					<td>10</td>
				</tr>
				<tr>
					<td>min</td>
					<td><input type="text" size="6"></td>
					<td><input type="text" size="6"></td>
					<td>10</td>
				</tr>
				<tr>
					<td>max</td>
					<td><input type="text" size="6"></td>
					<td><input type="text" size="6"></td>
					<td>10</td>
				</tr>
				<tr>
					<td>scale</td>
					<td><input type="text" size="6"></td>
					<td><input type="text" size="6"></td>
					<td>10</td>
				</tr>
			</table>
		</div>

		<div id="dialog_try" title="" style="display: none">
			<div>
				<button type="button" id="btnSave_try">
					<img src="images/save.png" />
				</button>
			</div>
			<textarea name="kanso" rows="4">ここに入力してください。</textarea>
		</div>
		<div id="dialog_history" title="" style="display: none">
			<div>
				<button type="button" id="btnSave_history">
					<img src="images/save.png" />
				</button>
			</div>
			<input type="file" id="id_file"> <img src="" id="id_preview"
				style="display: none;">
		</div>
		<div id="dialog_advice" title="" style="display: none">
			<div>
				<button type="button" id="btnSave_try">
					<img src="images/save.png" />
				</button>
			</div>
			<textarea name="kanso" rows="4">ここに入力してください。</textarea>
		</div>
		<div id="dialog_advice" title="" style="display: none">
			<div>
				<button type="button" id="btnSave_try">
					<img src="images/save.png" />
				</button>
			</div>
			<textarea name="kanso" rows="4">ここに入力してください。</textarea>
		</div>
		<div id="dialog_plan" title="" style="display: none">
			<div>
				<button type="button" id="btnSave_try">
					<img src="images/save.png" />
				</button>
			</div>
			<textarea name="kanso" rows="4">ここに入力してください。</textarea>
		</div>
</body>
<script>
var barChartData1 = {
    labels: ['W1','W2','W3','W4','W5','W6','W7',
        'W8','W9','W10','W11','W12'
    ],
    datasets: [
    {
        type: 'bar',
        label: '体重',
        data: ['90','85','80','75','70','65','60',
            '55','50','45','40','36'
        ],
        borderColor : "rgba(54,164,235,0.8)",
        backgroundColor : "rgba(54,164,235,0.5)",
        yAxisID: "y-axis-1",
    },
    {
        type: 'line',
        label: '人生の質',
        data: ['0','5','10','15','20','25','30',
            '35','40','45','50','55'
        ],
        borderColor : "rgba(254,97,132,0.8)",
                pointBackgroundColor    : "rgba(254,97,132,0.8)",
                fill: false,
        yAxisID: "y-axis-2",// 追加
    }

    ],
};
var barChartData = {
    labels: ['W1','W2'
    ],
    datasets: [
    {
        type: 'bar',
        label: '体重',
        data: ['90','89'
        ],
        borderColor : "rgba(54,164,235,0.8)",
        backgroundColor : "rgba(54,164,235,0.5)",
        yAxisID: "y-axis-1",
    },
    {
        type: 'line',
        label: '人生の質',
        data: ['0','5'
        ],
        borderColor : "rgba(254,97,132,0.8)",
                pointBackgroundColor    : "rgba(254,97,132,0.8)",
                fill: false,
        yAxisID: "y-axis-2",// 追加
    }

    ],
};

</script>



<script>
var complexChartOption = {
    responsive: true,
    scales: {
        yAxes: [{
            id: "y-axis-1",
            type: "linear", 
            position: "left",
            ticks: {
                max: 90,
                min: 85,
                stepSize: 1
            },
        }, {
            id: "y-axis-2",
            type: "linear", 
            position: "right",
            ticks: {
                max: 12,
                min: 0,
                stepSize: 1
            },
            gridLines: {
                drawOnChartArea: false, 
            },
        }],
    }
};
</script>

</html>