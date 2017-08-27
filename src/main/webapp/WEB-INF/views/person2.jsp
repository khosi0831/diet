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
<script src="jquery/lity-2.3.0/dist/lity.js"></script>
<script>
  $( function() {
     var dateFormat = 'yy/mm/dd';
     $('.datepicker').datepicker({
         dateFormat: dateFormat
     });
	$( "#week_select" ).val($("#week").val());
    $( "#menu" ).menu();
    $( "#tabs" ).tabs();
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

		//計画 ここから
		$.ajax({
			  type: 'GET',
			  url: '/plan/'+ $("#id").val(),
			  dataType: 'json',
			  success: function(json){
				  var plans = json;
					$("#plan_table").append(
						 $("<tr></tr>")
						        .append($("<th></th>").text("i"))
						        .append($("<th></th>").text("u"))
						        .append($("<th></th>").text("週"))
						        .append($("<th></th>").text("計画"))
					);
				    for(var i in plans){
				    	var item = $.extend(true, {}, $("#plan").clone());
				    	item.text(plans[i].plan)
				    	//item.id(plans[i].week)
						$("#plan_table").append(
						    $("<tr></tr>")
						        .append($("<td></td>").text(plans[i].id))
						        .append($("<td></td>").text(plans[i].userId))
						        .append($("<td></td>").text(plans[i].week))
								.append($("<td></td>").append(item))
						);
				    }
			  }
		});
		//計画 ここまで
		//顧客ここから
		$.ajax({
			  type: 'GET',
			  url: '/customer/'+ $("#id").val(),
			  dataType: 'json',
			  success: function(json){
				  var customer = json;
					$( "#title_week" ).text($("#week").val() + "週");
					$( "#title_name" ).text(customer.name);
					$( "#customer_name" ).val(customer.name)
					$( "#customer_password" ).val(customer.password)
					$( "#customer_email" ).val(customer.email)
					$( "#customer_birth" ).val(customer.birth)
					$( "#customer_startdate" ).val(customer.startdate)
					$( "#customer_memo" ).val(customer.memo)
					$( "#customer_favorite" ).val(customer.favorite)
					/*
					$("#customer_table").append(
					    $("<tr></tr>")
						    .append($("<th></th>").text("名前"))
					        .append($("<td></td>")
					        .append($.extend(true, {}, $("#customer").clone().text(customer.name).attr("id", "name"))))
					);
					$("#customer_table").append(
						    $("<tr></tr>")
						        .append($("<th></th>").text("パスワード"))
						        .append($("<td></td>")
						        .append($.extend(true, {}, $("#customer").clone().text(customer.password).attr("id", "password"))))
					);
					$("#customer_table").append(
						    $("<tr></tr>")
						        .append($("<th></th>").text("メール"))
						        .append($("<td></td>")
						        .append($.extend(true, {}, $("#customer").clone().text(customer.email).attr("id", "email"))))
					);
					$("#customer_table").append(
						    $("<tr></tr>")
						        .append($("<th></th>").text("誕生日"))
						        .append($("<td></td>")
						        .append($.extend(true, {}, $("#customer").clone().text(customer.birth).attr("id", "birth"))))
					);
					$("#customer_table").append(
						    $("<tr></tr>")
						        .append($("<th></th>").text("開始日"))
						        .append($("<td></td>")
						        .append($.extend(true, {}, $("#customer").clone().text(customer.startdate).attr("id", "startdate"))))
					);
					$("#customer_table").append(
						    $("<tr></tr>")
						        .append($("<th></th>").text("メモ"))
						        .append($("<td></td>")
						        .append($.extend(true, {}, $("#customer").clone().text(customer.memo).attr("id", "memo"))))
					);
					$("#customer_table").append(
						    $("<tr></tr>")
						        .append($("<th></th>").text("興味"))
						        .append($("<td></td>")
						        .append($.extend(true, {}, $("#customer").clone().text(customer.favorite).attr("id", "favorite"))))
					);
					*/
			  }
		});
		//顧客ここまで
		//レポートここから
		$.ajax({
			  type: 'GET',
			  url: '/report/'+ $("#id").val(),
			  dataType: 'json',
			  success: function(json){
				  var reports = json;
				    for(var i in reports){
				    	chatmsg(reports[i], "question");
				    	chatmsg(reports[i], "answer");
				    }
			  }
		});
		//レポートここまで
		//マインドここから
		var url = '/mind/'+ $("#id").val() + "?week=" + $("#week").val();
		$.ajax({
			  type: 'GET',
			  url: url,
			  dataType: 'json',
			  success: function(data){
				  var mind = data;
				  disp_mind(data)
//				  $("#mind_textarea").val(mind.memo);
//				  $("#mind_id").text(mind.id);
			  }
		});
		//マインドここまで
		//レクチャーここから
		var url = '/lecture/'+ $("#id").val() + "?week=" + $("#week").val();
		$.ajax({
			  type: 'GET',
			  url: url,
			  dataType: 'json',
			  success: function(data){
				  disp_lecture(data)
//				  var lecture = json;				  
//				  $("#lecture_textarea").val(lecture.memo);
//				  $("#lecture_id").text(lecture.id);
			  }
		});
		//レクチャーここまで		
		//アドバイスここから
		var url = '/advice/'+ $("#id").val() + "?week=" + $("#week").val();
		$.ajax({
			  type: 'GET',
			  url: url,
//			  url: "/advice/15?week=1",
			  dataType: 'json',
			  success: function(data){
				  disp_advice(data)
//				  $("#advice_textarea").val(lecture.memo);
//				  $("#advice_id").text(lecture.id);
			  }
		});
		//アドバイスここまで
		//写真ここから
		var url = '/photo/'+ $("#id").val() + "?week=" + $("#week").val();
		$.ajax({
			  type: 'GET',
			  url: url,
			  dataType: 'json',
			  success: function(json){
				  var photos = json;
  			      for(var i in photos){
  			    		var item = $.extend(true, {}, $("#data-lity").clone());
  					    var photo_area = $("<div></div>").addClass(photos[i].id);
  					    var photo_area1 = photo_area.append($('<input type="checkbox"></input>').addClass("delete").attr('value', photos[i].id));
//  					    var photo_area1_1 = photo_area1.append(item.attr("href", photos[i].url));
//  					    var photo_area1_1 = photo_area1.append(item);
  					    var photo_area1_1 = photo_area1.append($("<a>").attr("href", photos[i].url).attr("data-lity", ""));
  					    var photo_area2 = photo_area1_1.append($("<img>").attr("src", photos[i].url).attr("width",128).attr("height",128));
  					  	$("#photo_area").append(photo_area2);
  			      }
			  }
		});
  					    
		//写真ここまで
		//体重ここから
		$.ajax({
			  type: 'GET',
			  url: '/weight/'+ $("#id").val(),
			  dataType: 'json',
			  success: function(data){
				  /*
				  var graph = json;
				  var week = $("#week").val()
				  $("#weight_id").text(graph.id);
				  $("#w0").val(graph.w0);
				  $("#m0").val(graph.m0);
				  $("#w1").val(graph.w1);
				  $("#m1").val(graph.m1);
				  $("#w2").val(graph.w2);
				  $("#m2").val(graph.m2);
				  $("#w3").val(graph.w3);
				  $("#m3").val(graph.m3);
				  $("#w4").val(graph.w4);
				  $("#m4").val(graph.m4);
				  $("#w5").val(graph.w5);
				  $("#m5").val(graph.m5);
				  $("#w6").val(graph.w6);
				  $("#m6").val(graph.m6);
				  $("#w7").val(graph.w7);
				  $("#m7").val(graph.m7);
				  $("#w8").val(graph.w8);
				  $("#m8").val(graph.m8);
				  $("#w9").val(graph.w9);
				  $("#m9").val(graph.m9);
				  $("#w10").val(graph.w10);
				  $("#m10").val(graph.m10);
				  $("#w11").val(graph.w11);
				  $("#m11").val(graph.m11);
				  $("#w12").val(graph.w12);
				  $("#m12").val(graph.m12);
				  $("#wmin1").text(graph.wmin1);
				  $("#wmin2").text(graph.wmin2);
				  $("#wmin3").text(graph.wmin3);
				  $("#wmin4").text(graph.wmin4);
				  $("#wmin5").text(graph.wmin5);
				  $("#wmin6").text(graph.wmin6);
				  $("#wmin7").text(graph.wmin7);
				  $("#wmin8").text(graph.wmin8);
				  $("#wmin9").text(graph.wmin9);
				  $("#wmin10").text(graph.wmin10);
				  $("#wmin11").text(graph.wmin11);
				  $("#wmin12").text(graph.wmin12);
				  $("#mmin1").text(graph.mmin1);
				  $("#mmin2").text(graph.mmin2);
				  $("#mmin3").text(graph.mmin3);
				  $("#mmin4").text(graph.mmin4);
				  $("#mmin5").text(graph.mmin5);
				  $("#mmin6").text(graph.mmin6);
				  $("#mmin7").text(graph.mmin7);
				  $("#mmin8").text(graph.mmin8);
				  $("#mmin9").text(graph.mmin9);
				  $("#mmin10").text(graph.mmin10);
				  $("#mmin11").text(graph.mmin11);
				  $("#mmin12").text(graph.mmin12);
				  $("#wmax1").text(graph.wmax1);
				  $("#wmax2").text(graph.wmax2);
				  $("#wmax3").text(graph.wmax3);
				  $("#wmax4").text(graph.wmax4);
				  $("#wmax5").text(graph.wmax5);
				  $("#wmax6").text(graph.wmax6);
				  $("#wmax7").text(graph.wmax7);
				  $("#wmax8").text(graph.wmax8);
				  $("#wmax9").text(graph.wmax9);
				  $("#wmax10").text(graph.wmax10);
				  $("#wmax11").text(graph.wmax11);
				  $("#wmax12").text(graph.wmax12);
				  $("#mmax1").text(graph.mmax1);
				  $("#mmax2").text(graph.mmax2);
				  $("#mmax3").text(graph.mmax3);
				  $("#mmax4").text(graph.mmax4);
				  $("#mmax5").text(graph.mmax5);
				  $("#mmax6").text(graph.mmax6);
				  $("#mmax7").text(graph.mmax7);
				  $("#mmax8").text(graph.mmax8);
				  $("#mmax9").text(graph.mmax9);
				  $("#mmax10").text(graph.mmax10);
				  $("#mmax11").text(graph.mmax11);
				  $("#mmax12").text(graph.mmax12);
				  $("#wscale1").text(graph.wscale1);
				  $("#wscale2").text(graph.wscale2);
				  $("#wscale3").text(graph.wscale3);
				  $("#wscale4").text(graph.wscale4);
				  $("#wscale5").text(graph.wscale5);
				  $("#wscale6").text(graph.wscale6);
				  $("#wscale7").text(graph.wscale7);
				  $("#wscale8").text(graph.wscale8);
				  $("#wscale9").text(graph.wscale9);
				  $("#wscale10").text(graph.wscale10);
				  $("#wscale11").text(graph.wscale11);
				  $("#wscale12").text(graph.wscale12);
				  $("#mscale1").text(graph.mscale1);
				  $("#mscale2").text(graph.mscale2);
				  $("#mscale3").text(graph.mscale3);
				  $("#mscale4").text(graph.mscale4);
				  $("#mscale5").text(graph.mscale5);
				  $("#mscale6").text(graph.mscale6);
				  $("#mscale7").text(graph.mscale7);
				  $("#mscale8").text(graph.mscale8);
				  $("#mscale9").text(graph.mscale9);
				  $("#mscale10").text(graph.mscale10);
				  $("#mscale11").text(graph.mscale11);
				  $("#mscale12").text(graph.mscale12);
				  $("#wmin").val( $("#wmin" + week).text());
				  $("#mmin").val( $("#mmin" + week).text());
				  $("#wmax").val( $("#wmax" + week).text());
				  $("#mmax").val( $("#mmax" + week).text());
				  $("#wscale").val( $("#wscale" + week).text());
				  $("#mscale").val( $("#mscale" + week).text());
				  */
				  label_data = [];
				  weight_data = [];
				  mile_data = [];
				  barChartData = ""; 
				  complexChartOption = "";
				  
				  dataset(data);
				  diff();
				  label();
				  graphset();
				  disp_graph();
				  
/*
			    ctx = document.getElementById("canvas").getContext("2d");
			    window.myBar = new Chart(ctx, {
			        type: 'bar',
			        data: barChartData,
			        options: complexChartOption
			    });
*/				
			  },
		      error : function(data) {
		            // Error
		            alert("error");
		            alert(JSON.stringify(data));
		            $("#response").html(JSON.stringify(data));
		      }
		});

		$("#location").click(function () {
		      var pram="week="+$("#week_select").val();
		      window.location.href= "/" + $("#id").val() + "?" + pram;	
		}).change();		
		
		//--------ここからはテストですaaaaaaa
		$('#try_save').click(function(){
	        $.ajax({
	            type : 'post',
	            url : "http://localhost:8080/lecture/save",
	            data : JSON.stringify({"id":1,"userId":1,"dspweek":1,"seqno":1,"memo":$("#try_msg").val()}),
	            contentType: 'application/JSON',
	            dataType : 'JSON',
	            scriptCharset: 'utf-8',
	            success : function(data) {
	                // Success
	                alert("success");
	                alert(JSON.stringify(data));
	            },
	            error : function(data) {
	                // Error
	                alert("error");
	                alert(JSON.stringify(data));
	                $("#response").html(JSON.stringify(data));
	            }
	        });
		});

	    // アップロードボタンを押下した
	    $("#data_upload_form").submit(function(event){
	        // 要素規定の動作をキャンセルする
	        event.preventDefault();
	        var ajaxUrl = "/photo/upload?";
	        ajaxUrl += "userid=" + $("#id").val();
	        ajaxUrl += "&week=" + $("#week").val();

	        if(window.FormData){
	            var formData = new FormData($(this)[0]);
	            $.ajax({
	                type : "POST",                  // HTTP通信の種類
	                url  : ajaxUrl,                 // リクエストを送信する先のURL
	                dataType : "text",              // サーバーから返されるデータの型
	                data : formData,                // サーバーに送信するデータ
	                processData : false,
	                contentType: false,
		            success : function(data) {
		                var photo = data;
//		                alert("success");
//		                alert(JSON.stringify(data));
  					    var photo_area = $("<div></div>").addClass(photo.id);
  					    var photo_area1 = photo_area.append($('<input type="checkbox"></input>').addClass("delete").attr('value', photo.id));
  					    var photo_area1_1 = photo_area1.append($("<a>").attr("href", photo.url).attr("data-lity", ""));
  					    var photo_area2 = photo_area1_1.append($("<img>").attr("src", photo.url).attr("width",128).attr("height",128));
  					  	$("#photo_area").append(photo_area2);
//		                createPhoto(data);
		            },
		            error : function(data) {
		                // Error
		                alert("error");
		                alert(JSON.stringify(data));
		                $("#response").html(JSON.stringify(data));
		            }
	            });
	        }else{
	            alert("アップロードに対応できていないブラウザです。");
	        }
	    });

		var data = {
		    "try": "<p>メモ</p><br>できたかな？",
		    "advice": "<p>アドバイス</p><br>できたかな？",

		}
		var plan = {
    	 "w1": "タンパク質を摂る。できたかな？",
    	 "w2": "ウオーキング できたかな？",
    	 "w3": "非言語コミュニケーション"
		}

//   	$('#try_copy').html(data.try);
//   	$('#copy_advice').html(data.advice);
//   	$('#w1_plan').html(plan.w1);
//   	$('#w2_plan').html(plan.w2);
	
  } );

  function createPhoto(url) {
		var date = {"userId":$("#id").val(),"week":$("#week").val(),"url":url};
	    $.ajax({
	        type : 'POST',
	        url : "/photo/save",
	        data : JSON.stringify(date),
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
	  
  }
  function chatmsg(report, prefix) {
	   var classname;
	   var imgurl;
	   var text;
	   var idname;
	   
	   idname = "reportid_" + report.id;
		var chat_box = $("<div></div>").addClass("chat-box");
	   if ( prefix == "question") {
		   classname = "chat-hukidashi";
		   imgurl = "images/woman.png";
		   text = report.question;
		   chat_box.attr('id', idname);
	   } else {
		   classname= "chat-hukidashi2";
		   imgurl = "images/man.jpg";
		   text = report.answer;
	   }
		var chat_area = chat_box.append($("<div></div>").addClass("chat-area"));
		var chat_area1 = chat_area.append($
	    	      ("<img>").attr("src", imgurl).attr("width",30)
	    	      .attr("height",30));
		var itemvalue = prefix + "_" +  report.id;
		var chat_hukidashi = chat_area1.append($("<div></div>").addClass(classname).attr('contentEditable', true).attr('id', itemvalue).text(text));
		$("#report").append(chat_hukidashi);
  }

  function diff() {
	  for(var i = 0 ; i < 12; i++) {
		  var now = i.toString();
		  var after = (i + 1).toString();
		  if ($("#w" + now ).val() != 0 && $("#w" + after).val()  !=  0) {
			  $("#diff" + after).text(parseInt($("#w" + now).val()) - parseInt($("#w" + after).val()));
		  }
	  }
	  
  }

  var label_data = [];
  var weight_data = [];
  var mile_data = [];
  var barChartData; 
  var complexChartOption;
 
  function label() {
	  var week = parseInt($("#week").val());
	  for(var i = 0; i < 13; i++) {
		  $("#wtr" + i.toString()).hide();
	  }
	  
	  for(var i = 0; i < week + 1; i++) {
		  label_data.push('w' + i.toString());
		  weight_data.push($("#w" + i.toString()).val());
		  mile_data.push($("#m" + i.toString()).val());
		  $("#wtr" + i.toString()).show();
	  }
	  $("#wmin1").hide();
	  /*
	  for(var i = 1; i < 13; i++) {
		  $("#wmin" + i.toString()).hide();
		  $("#mmin" + i.toString()).hide();
		  $("#wmax" + i.toString()).hide();
		  $("#mmax" + i.toString()).hide();
		  $("#wscale" + i.toString()).hide();
		  $("#mscale" + i.toString()).hide();
	  }
	  */
	  
  }
  function dataset(graph) {
	  var week = $("#week").val()
	  $("#weight_id").text(graph.id);
	  $("#w0").val(graph.w0);
	  $("#m0").val(graph.m0);
	  $("#w1").val(graph.w1);
	  $("#m1").val(graph.m1);
	  $("#w2").val(graph.w2);
	  $("#m2").val(graph.m2);
	  $("#w3").val(graph.w3);
	  $("#m3").val(graph.m3);
	  $("#w4").val(graph.w4);
	  $("#m4").val(graph.m4);
	  $("#w5").val(graph.w5);
	  $("#m5").val(graph.m5);
	  $("#w6").val(graph.w6);
	  $("#m6").val(graph.m6);
	  $("#w7").val(graph.w7);
	  $("#m7").val(graph.m7);
	  $("#w8").val(graph.w8);
	  $("#m8").val(graph.m8);
	  $("#w9").val(graph.w9);
	  $("#m9").val(graph.m9);
	  $("#w10").val(graph.w10);
	  $("#m10").val(graph.m10);
	  $("#w11").val(graph.w11);
	  $("#m11").val(graph.m11);
	  $("#w12").val(graph.w12);
	  $("#m12").val(graph.m12);
	  $("#wmin1").text(graph.wmin1);
	  $("#wmin2").text(graph.wmin2);
	  $("#wmin3").text(graph.wmin3);
	  $("#wmin4").text(graph.wmin4);
	  $("#wmin5").text(graph.wmin5);
	  $("#wmin6").text(graph.wmin6);
	  $("#wmin7").text(graph.wmin7);
	  $("#wmin8").text(graph.wmin8);
	  $("#wmin9").text(graph.wmin9);
	  $("#wmin10").text(graph.wmin10);
	  $("#wmin11").text(graph.wmin11);
	  $("#wmin12").text(graph.wmin12);
	  $("#mmin1").text(graph.mmin1);
	  $("#mmin2").text(graph.mmin2);
	  $("#mmin3").text(graph.mmin3);
	  $("#mmin4").text(graph.mmin4);
	  $("#mmin5").text(graph.mmin5);
	  $("#mmin6").text(graph.mmin6);
	  $("#mmin7").text(graph.mmin7);
	  $("#mmin8").text(graph.mmin8);
	  $("#mmin9").text(graph.mmin9);
	  $("#mmin10").text(graph.mmin10);
	  $("#mmin11").text(graph.mmin11);
	  $("#mmin12").text(graph.mmin12);
	  $("#wmax1").text(graph.wmax1);
	  $("#wmax2").text(graph.wmax2);
	  $("#wmax3").text(graph.wmax3);
	  $("#wmax4").text(graph.wmax4);
	  $("#wmax5").text(graph.wmax5);
	  $("#wmax6").text(graph.wmax6);
	  $("#wmax7").text(graph.wmax7);
	  $("#wmax8").text(graph.wmax8);
	  $("#wmax9").text(graph.wmax9);
	  $("#wmax10").text(graph.wmax10);
	  $("#wmax11").text(graph.wmax11);
	  $("#wmax12").text(graph.wmax12);
	  $("#mmax1").text(graph.mmax1);
	  $("#mmax2").text(graph.mmax2);
	  $("#mmax3").text(graph.mmax3);
	  $("#mmax4").text(graph.mmax4);
	  $("#mmax5").text(graph.mmax5);
	  $("#mmax6").text(graph.mmax6);
	  $("#mmax7").text(graph.mmax7);
	  $("#mmax8").text(graph.mmax8);
	  $("#mmax9").text(graph.mmax9);
	  $("#mmax10").text(graph.mmax10);
	  $("#mmax11").text(graph.mmax11);
	  $("#mmax12").text(graph.mmax12);
	  $("#wscale1").text(graph.wscale1);
	  $("#wscale2").text(graph.wscale2);
	  $("#wscale3").text(graph.wscale3);
	  $("#wscale4").text(graph.wscale4);
	  $("#wscale5").text(graph.wscale5);
	  $("#wscale6").text(graph.wscale6);
	  $("#wscale7").text(graph.wscale7);
	  $("#wscale8").text(graph.wscale8);
	  $("#wscale9").text(graph.wscale9);
	  $("#wscale10").text(graph.wscale10);
	  $("#wscale11").text(graph.wscale11);
	  $("#wscale12").text(graph.wscale12);
	  $("#mscale1").text(graph.mscale1);
	  $("#mscale2").text(graph.mscale2);
	  $("#mscale3").text(graph.mscale3);
	  $("#mscale4").text(graph.mscale4);
	  $("#mscale5").text(graph.mscale5);
	  $("#mscale6").text(graph.mscale6);
	  $("#mscale7").text(graph.mscale7);
	  $("#mscale8").text(graph.mscale8);
	  $("#mscale9").text(graph.mscale9);
	  $("#mscale10").text(graph.mscale10);
	  $("#mscale11").text(graph.mscale11);
	  $("#mscale12").text(graph.mscale12);
	  $("#wmin").val( $("#wmin" + week).text());
	  $("#mmin").val( $("#mmin" + week).text());
	  $("#wmax").val( $("#wmax" + week).text());
	  $("#mmax").val( $("#mmax" + week).text());
	  $("#wscale").val( $("#wscale" + week).text());
	  $("#mscale").val( $("#mscale" + week).text());
	  
  }
  function graphset() {
  	barChartData = {
		    labels: label_data,
		    datasets: [
		    {
		        type: 'bar',
		        label: '体重',
		        data: weight_data,
		        borderColor : "rgba(54,164,235,0.8)",
		        backgroundColor : "rgba(54,164,235,0.5)",
		        yAxisID: "y-axis-1",
		    },
		    {
		        type: 'line',
		        label: '人生の質',
		        data: mile_data,
		        borderColor : "rgba(254,97,132,0.8)",
		                pointBackgroundColor    : "rgba(254,97,132,0.8)",
		                fill: false,
		        yAxisID: "y-axis-2",// 追加
		    }

		    ],
		};
  	
  	complexChartOption = {
  		    responsive: true,
  		    scales: {
  		        yAxes: [{
  		            id: "y-axis-1",
  		            type: "linear", 
  		            position: "left",
  		            ticks: {
  		                max: parseInt($("#wmax").val()),
  		                min: parseInt($("#wmin").val()),
  		                stepSize: parseInt($("#wscale").val())
  		            },
  		        }, {
  		            id: "y-axis-2",
  		            type: "linear", 
  		            position: "right",
  		            ticks: {
  		                max: parseInt($("#mmax").val()),
  		                min: parseInt($("#mmin").val()),
  		                stepSize: parseInt($("#mscale").val())
  		            },
  		            gridLines: {
  		                drawOnChartArea: false, 
  		            },
  		        }],
  		    }
  		};

  	}
  function disp_graph() {
    ctx = document.getElementById("canvas").getContext("2d");
    window.myBar = new Chart(ctx, {
        type: 'bar',
        data: barChartData,
        options: complexChartOption
    });
  }
/*	var chat_box = $("<div></div>").addClass("chat-box");
	var chat_area = chat_box.append($("<div></div>").addClass("chat-area"));
	var chat_area1 = chat_area.append($
    	      ("<img>").attr("src", "images/man.jpg").attr("width",30)
    	      .attr("height",30));
	
	var chat_hukidashi = chat_area1.append($("<div></div>").addClass("chat-hukidashi2").attr('contentEditable', true).text("みにくいので"));
	$("#report").append(chat_hukidashi);
*/
  
  function btn_mind_save_click () {
	var date = {"id":$("#mind_id").text(),"userId":$("#id").val(),"week":$("#week").val(),"memo":$("#mind_textarea").val()};
    $.ajax({
        type : 'POST',
        url : "/mind/save",
        data : JSON.stringify(date),
        contentType: 'application/JSON',
        dataType : 'JSON',
        scriptCharset: 'utf-8',
        success : function(data) {
            // Success
            alert("success");
            alert(JSON.stringify(data));
            $("#response").html(JSON.stringify(data));
            disp_mind(data);
        },
        error : function(data) {
            // Error
            alert("error");
            alert(JSON.stringify(data));
            $("#response").html(JSON.stringify(data));
        }
    });
  }
function disp_mind(mind) {
	  $("#mind_textarea").val(mind.memo);
	  $("#mind_id").text(mind.id);
}
  function btn_lecture_save_click() {
		var date = {"id":$("#lecture_id").text(),"userId":$("#id").val(),"week":$("#week").val(),"memo":$("#lecture_textarea").val()};
	    $.ajax({
	        type : 'POST',
	        url : "/lecture/save",
	        data : JSON.stringify(date),
	        contentType: 'application/JSON',
	        dataType : 'JSON',
	        scriptCharset: 'utf-8',
	        success : function(data) {
	        	disp_lecture(data);	        	
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
  }
  function disp_lecture(lecture) {
	  $("#lecture_textarea").val(lecture.memo);
	  $("#lecture_id").text(lecture.id);
  }
  function btn_photo_del_click(){
		
		var data = [];
		$($('.delete:checked')).each(function(){
				var addData = {"id":$(this).val()};
				data.push(addData);
			console.log($(this).val());
		});
		
		$.ajax({
			  type: 'POST',
			  url: '/photo/delete',
            data : JSON.stringify(data),
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
  }
  function btn_advice_save_click() {
		var date = {"id":$("#advice_id").text(),"userId":$("#id").val(),"week":$("#week").val(),"memo":$("#advice_textarea").val()};
	    $.ajax({
	        type : 'POST',
	        url : "/advice/save",
	        data : JSON.stringify(date),
	        contentType: 'application/JSON',
	        dataType : 'JSON',
	        scriptCharset: 'utf-8',
	        success : function(data) {
	            // Success
	            alert("success");
	            alert(JSON.stringify(data));
	            $("#response").html(JSON.stringify(data));
	            disp_advice(data);
	        },
	        error : function(data) {
	            // Error
	            alert("error");
	            alert(JSON.stringify(data));
	            $("#response").html(JSON.stringify(data));
	        }
	    });
  }
  function disp_advice(advice) {
	  $("#advice_textarea").val(advice.memo);
	  $("#advice_id").text(advice.id);
  }
  
  function btn_report_save_click() {
	    var questions = $("[id^=question]");
	    var answers = $("[id^=answer]");
	    var reportids = $("[id^=reportid]");
	    
	    var datas = [];
	    var seqno = 1;
	    for(var i = 0; i < questions.length; i++){
	    	console.log(questions[i].text);
	    	var id = reportids[i].id;
	    	id = parseInt(String(id).replace("reportid_", ""));
	    	seqno++;
			var data = {
			    	"id":id
			    	,"userId":$("#id").val()
			    	,"seqno":seqno
			    	,"question":questions[i].innerText
			    	,"answer":answers[i].innerText
			};
			datas.push(data);
	    }
	    $.ajax({
	        type : 'POST',
	        url : "/report/save",
	        data : JSON.stringify(datas),
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
  }
  function btn_plan_save_click() {
		var data = [];
		var tr = $("#plan_table tr");//全行を取得
		for(var i=0, l=tr.length; i<l;i++ ){ //行数分回す
			if ( i == 0 ) continue;
			var cells = tr.eq(i).children();//1行目から順にth、td問わず列を取得
			if ( cells.eq(1).text().length > 0) {
				//data[i] = cells.eq(1).text();//i行目j列の文字列を取得
				var addData = {"id":cells.eq(0).text(),"userId":cells.eq(1).text(),"week":cells.eq(2).text(),"plan":cells.eq(3).text()};
				data.push(addData);
			}
		}
		console.log(JSON.stringify(data));
        $.ajax({
            type : 'POST',
            url : "/plan/save",
            data : JSON.stringify(data),
            contentType: 'application/JSON',
            dataType : 'JSON',
            scriptCharset: 'utf-8',
            success : function(data) {

                // Success
                alert("success");
                alert(JSON.stringify(data));
                $("#response").html(JSON.stringify(data));
                customersList();
            },
            error : function(data) {
                // Error
                alert("error");
                alert(JSON.stringify(data));
                $("#response").html(JSON.stringify(data));
            }
        });
  }
  function btn_customer_save_click() {
      $.ajax({
          type : 'POST',
          url : "/customer/save",
          data : JSON.stringify({
	            "id" : $("#id").val(),
	            "name" : $("#customer_name").val(),
	            "password" : $("#customer_password").val(),
	            "email": $("#customer_email").val(),
	            "startdate" : $("#customer_startdate").val(),
	            "birth" : $("#customer_birth").val(),
	            "favorite" : $("#customer_favorite").val(),
	            "memo": $("#customer_memo").val()
          }),
          contentType: 'application/JSON',
          dataType : 'JSON',
          scriptCharset: 'utf-8',
          success : function(data) {

              // Success
              alert("success");
              alert(JSON.stringify(data));
//              $("#response").html(JSON.stringify(data));
          },
          error : function(data) {

              // Error
              alert("error");
              alert(JSON.stringify(data));
//              $("#response").html(JSON.stringify(data));
          }
      });
	  
  }
  function btn_weight_save_click() {
	  	var week = $("#week").val();
	  	
		$("#wmin" + week).text($("#wmin").val());
		$("#mmin" + week).text($("#mmin").val());
		$("#wmax" + week).text($("#wmax").val());
		$("#mmax" + week).text($("#mmax").val());
		$("#wscale" + week).text($("#wscale").val());
		$("#mscale" + week).text($("#mscale").val());
	  
		var wdata = {
				"id":$("#weight_id").text()
				,"userId":$("#id").val()
				,"week":$("#week").val()
				,"w0":$("#w0").val()
				,"m0":$("#m0").val()
				,"w1":$("#w1").val()
				,"m1":$("#m1").val()
				,"w2":$("#w2").val()
				,"m2":$("#m2").val()
				,"w3":$("#w3").val()
				,"m3":$("#m3").val()
				,"w4":$("#w4").val()
				,"m4":$("#m4").val()
				,"w5":$("#w5").val()
				,"m5":$("#m5").val()
				,"w6":$("#w6").val()
				,"m6":$("#m6").val()
				,"w7":$("#w7").val()
				,"m7":$("#m7").val()
				,"w8":$("#w8").val()
				,"m8":$("#m8").val()
				,"w9":$("#w9").val()
				,"m9":$("#m9").val()
				,"w10":$("#w10").val()
				,"m10":$("#m10").val()
				,"w11":$("#w11").val()
				,"m11":$("#m11").val()
				,"w12":$("#w12").val()
				,"m12":$("#m12").val()
				,"wmin1":$("#wmin1").text()
				,"wmax1":$("#wmax1").text()
				,"mmin1":$("#mmin1").text()
				,"mmax1":$("#mmax1").text()
				,"wscale1":$("#wscale1").text()
				,"mscale1":$("#mscale1").text()

				,"wmin2":$("#wmin2").text()
				,"wmax2":$("#wmax2").text()
				,"mmin2":$("#mmin2").text()
				,"mmax2":$("#mmax2").text()
				,"wscale2":$("#wscale2").text()
				,"mscale2":$("#mscale2").text()

				,"wmin3":$("#wmin3").text()
				,"wmax3":$("#wmax3").text()
				,"mmin3":$("#mmin3").text()
				,"mmax3":$("#mmax3").text()
				,"wscale3":$("#wscale3").text()
				,"mscale3":$("#mscale3").text()

				,"wmin4":$("#wmin4").text()
				,"wmax4":$("#wmax4").text()
				,"mmin4":$("#mmin4").text()
				,"mmax4":$("#mmax4").text()
				,"wscale4":$("#wscale4").text()
				,"mscale4":$("#mscale4").text()

				,"wmin5":$("#wmin5").text()
				,"wmax5":$("#wmax5").text()
				,"mmin5":$("#mmin5").text()
				,"mmax5":$("#mmax5").text()
				,"wscale5":$("#wscale5").text()
				,"mscale5":$("#mscale5").text()

				,"wmin6":$("#wmin6").text()
				,"wmax6":$("#wmax6").text()
				,"mmin6":$("#mmin6").text()
				,"mmax6":$("#mmax6").text()
				,"wscale6":$("#wscale6").text()
				,"mscale6":$("#mscale6").text()

				,"wmin7":$("#wmin7").text()
				,"wmax7":$("#wmax7").text()
				,"mmin7":$("#mmin7").text()
				,"mmax7":$("#mmax7").text()
				,"wscale7":$("#wscale7").text()
				,"mscale7":$("#mscale7").text()

				,"wmin8":$("#wmin8").text()
				,"wmax8":$("#wmax8").text()
				,"mmin8":$("#mmin8").text()
				,"mmax8":$("#mmax8").text()
				,"wscale8":$("#wscale8").text()
				,"mscale8":$("#mscale8").text()

				,"wmin9":$("#wmin9").text()
				,"wmax9":$("#wmax9").text()
				,"mmin9":$("#mmin9").text()
				,"mmax9":$("#mmax9").text()
				,"wscale9":$("#wscale9").text()
				,"mscale9":$("#mscale9").text()

				,"wmin10":$("#wmin10").text()
				,"wmax10":$("#wmax10").text()
				,"mmin10":$("#mmin10").text()
				,"mmax10":$("#mmax10").text()
				,"wscale10":$("#wscale10").text()
				,"mscale10":$("#mscale10").text()

				,"wmin11":$("#wmin11").text()
				,"wmax11":$("#wmax11").text()
				,"mmin11":$("#mmin11").text()
				,"mmax11":$("#mmax11").text()
				,"wscale11":$("#wscale11").text()
				,"mscale11":$("#mscale11").text()

				,"wmin12":$("#wmin12").text()
				,"wmax12":$("#wmax12").text()
				,"mmin12":$("#mmin12").text()
				,"mmax12":$("#mmax12").text()
				,"wscale12":$("#wscale12").text()
				,"mscale12":$("#mscale12").text()
		};
	    $.ajax({
	        type : 'POST',
	        url : "/weight/save",
	        data : JSON.stringify(wdata),
	        contentType: 'application/JSON',
	        dataType : 'JSON',
	        scriptCharset: 'utf-8',
	        success : function(data) {
	            // Success
	            alert("success");
	            alert(JSON.stringify(data));
	            $("#response").html(JSON.stringify(data));

	            label_data = [];
				weight_data = [];
				mile_data = [];
				barChartData = ""; 
				complexChartOption = "";
	            
			    diff();
			　　   label();
			    dataset(data);
			    graphset();
			    disp_graph();
	        },
	        error : function(data) {
	            // Error
	            alert("error");
	            alert(JSON.stringify(data));
	            $("#response").html(JSON.stringify(data));
	        }
	    });
	  
  }
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

$("#week_select" ).selectmenu ();
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
<input type='hidden' name='id' value='${id}' id="id"/>
<input type='hidden' name='week' value='${week}' id="week"/>
	<div class="demo demo0">
		<div class="heading"><span id="title_week"></span> <span id="title_name"></span></div>
	</div>
	<select name="select" id="week_select">
		<option value="1">1週</option>
		<option value="2">2週</option>
		<option value="3">3週</option>
		<option value="4">4週</option>
		<option value="5">5週</option>
		<option value="6">6週</option>
		<option value="7">7週</option>
		<option value="8">8週</option>
		<option value="9">9週</option>
		<option value="10">10週</option>
		<option value="11">11週</option>
		<option value="12">12週</option>
		<option>まとめ</option>
	</select><input type="button" id="location" value="移動">
	おしゃべりはこちら→
	
	<a href="#tabs_plan">chat work</a>
	<div id="tabs">
			<ul>
				<li><a href="#tabs_diary">週まとめ</a></li>
				<li><a href="#tabs_plan">計画</a></li>
				<li><a href="#tabs_customer">会員情報</a></li>
			</ul>
			<div id="tabs_diary">
				<div id="tabs_weight">
					<h1>グラフ</h1>
					<div class="box">
						<button type="button" id="btn_weight" onclick="btn_weight_save_click();">
							<img src="images/save.png" />
						</button>
					</div>
					<div id="weight_id"></div>
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
							<tr id="wtr0">
								<td>B</td>
								<td contenteditable="true" class="right"><input type="text" id="w0" onChange="diff('0w')"></input></td>
								<td contenteditable="true" class="right"><input type="text" id="m0" onChange="diff()"></input></td>
								<td class="right" id="diff0">0</td>
							</tr>
							<tr id="wtr1">
								<td>W1</td>
								<td contenteditable="true" class="right"><input type="text" id="w1" onChange="diff()"></input></td>
								<td contenteditable="true" class="right"><input type="text" id="m1" onChange="diff()"></input></td>
								<td class="right" id="diff1">5</td>
							</tr>
							<tr id="wtr2">
								<td>W2</td>
								<td contenteditable="true" class="right"><input type="text" id="w2" onChange="diff()"></input></td>
								<td contenteditable="true" class="right"><input type="text" id="m2" onChange="diff()"></input></td>
								<td class="right" id="diff2">5</td>
							</tr>
							<tr id="wtr3">
								<td>W3</td>
								<td contenteditable="true" class="right"><input type="text" id="w3" onChange="diff()"></input></td>
								<td contenteditable="true" class="right"><input type="text" id="m3" onChange="diff()"></input></td>
								<td class="right" id="diff3">5</td>
							</tr>
							<tr id="wtr4">
								<td>W4</td>
								<td contenteditable="true" class="right"><input type="text" id="w4" onChange="diff()"></input></td>
								<td contenteditable="true" class="right"><input type="text" id="m4" onChange="diff()"></input></td>
								<td class="right" id="diff4">5</td>
							</tr>
							<tr id="wtr5">
								<td>W5</td>
								<td contenteditable="true" class="right"><input type="text" id="w5" onChange="diff()"></input></td>
								<td contenteditable="true" class="right"><input type="text" id="m5" onChange="diff()"></input></td>
								<td class="right" id="diff5">5</td>
							</tr>
							<tr id="wtr6">
								<td>W6</td>
								<td contenteditable="true" class="right"><input type="text" id="w6" onChange="diff()"></input></td>
								<td contenteditable="true" class="right"><input type="text" id="m6" onChange="diff()"></input></td>
								<td class="right" id="diff6">5</td>
							</tr>
							<tr id="wtr7">
								<td>W7</td>
								<td contenteditable="true" class="right"><input type="text" id="w7" onChange="diff()"></input></td>
								<td contenteditable="true" class="right"><input type="text" id="m7" onChange="diff()"></input></td>
								<td class="right" id="diff7">5</td>
							</tr>
							<tr id="wtr8">
								<td>W8</td>
								<td contenteditable="true" class="right"><input type="text" id="w8" onChange="diff()"></input></td>
								<td contenteditable="true" class="right"><input type="text" id="m8" onChange="diff()"></input></td>
								<td class="right" id="diff8">5</td>
							</tr>
							<tr id="wtr9">
								<td>W9</td>
								<td contenteditable="true" class="right"><input type="text" id="w9" onChange="diff()"></input></td>
								<td contenteditable="true" class="right"><input type="text" id="m9" onChange="diff()"></input></td>
								<td class="right" id="diff9">5</td>
							</tr>
							<tr id="wtr10">
								<td>W10</td>
								<td contenteditable="true" class="right"><input type="text" id="w10" onChange="diff()"></input></td>
								<td contenteditable="true" class="right"><input type="text" id="m10" onChange="diff()"></input></td>
								<td class="right" id="diff10">5</td>
							</tr>
							<tr id="wtr11">
								<td>W11</td>
								<td contenteditable="true" class="right"><input type="text" id="w11" onChange="diff()"></input></td>
								<td contenteditable="true" class="right"><input type="text" id="m11" onChange="diff()"></input></td>
								<td class="right" id="diff11">5</td>
							</tr>
							<tr id="wtr12">
								<td>W12</td>
								<td class="right"><input type="text" id="w12" onChange="diff()"></input></td>
								<td class="right"><input type="text" id="m12" onChange="diff()"></input></td>
								<td class="right" id="diff12">5</td>
							</tr>
							<tr>
								<td>min</td>
								<td class="right"><input type="text" id="wmin"></input></td>
								<td class="right"><input type="text" id="mmin"></input></td>
								<td class="right"></td>
							</tr>
							<tr>
								<td>max</td>
								<td class="right"><input type="text" id="wmax"></input></td>
								<td class="right"><input type="text" id="mmax"></input></td>
								<td class="right"></td>
							</tr>
							<tr>
								<td>scale</td>
								<td class="right"><input type="text" id="wscale"></input></td>
								<td class="right"><input type="text" id="mscale"></input></td>
								<td class="right"></td>
							</tr>
						</table>
					</div>
				</div>
				<div id="tabs_mind">
					<h1>ダイエットのマインドセット</h1>
					<div class="box">
						<button type="button" id="btn_mind" onclick="btn_mind_save_click()">
							<img src="images/save.png" />
						</button>
					</div>
					<textarea id="mind_textarea"name="msg" cols=100 rows=20>
					</textarea>
					<div id="mind_id"></div>					
				</div>				
				<div id="tabs_lecture">
					<h1>レクチャー</h1>
					<div class="box">
						<button type="button" id="try_save" onclick="btn_lecture_save_click()">
							<img src="images/save.png" />
						</button>
					</div>
					<textarea id="lecture_textarea"name="msg" cols=100 rows=20></textarea>
					<div id="lecture_id"></div>					
				</div>
				<div id="tabs_history">
					<h1>写真</h1>
					<div class="message">
							<div id="photo_area"></div>>
							<span class="fileinput-button"> 
							<input type="file"
								id="file" style="visibility: hidden"> <img src=""
								id="preview">
								<button type="button" id="history_file">
									<img src="images/file.png" />
								</button>
								<button type="button" id="btn_del" onclick="btn_photo_del_click()">
									<img src="images/del.png" />
								</button>
							</span>

                    	<form id="data_upload_form" enctype="multipart/form-data" method="post">
                            	<input type="file" id="upload_file" name="upload_file" required="" />
								<input id="data_upload_button" type="submit" value="アップロード" />								
						</form>
						<div id="photo_id"></div>					
					</div>
				</div>
				<div id="tabs_advice">
					<h1>振返り</h1>
					<div class="box">
						<button type="button"  onclick="btn_advice_save_click()">
							<img src="images/save.png" />
						</button>
					</div>
					<div id="advice_messgae" contenteditable="true">
						<textarea id="advice_textarea"name="msg" cols=100 rows=20></textarea>
						<div id="advice_id"></div>					
					</div>
				</div>
				<div id="advice_id"></div>					
			</div>
			<div id="tabs_plan">
				<h1>計画</h1>
				<div class="box">
					<button type="button" onclick="btn_plan_save_click()"　id="btn_plan">
						<img src="images/save.png" />
					</button>
				</div>
				<div class="messgae">
					<table id="plan_table" border="1"></table>
				</div>
			</div>
			<div id="tabs_customer">
				<h1>メンバー登録</h1>
				<div class="box">
					<button type="button" id="btn_customer" onclick="btn_customer_save_click()">
						<img src="images/save.png" />
					</button>
				</div>
				<div class="messgae">
					<table id="customer_table" border="1">
						<tr>
							<th>名称</th>
							<td><input type="text" id="customer_name" /></td>
						</tr>
						<tr>
							<th>パスワード</th>
							<td><input type="text" id="customer_password" /></td>
						</tr>
						<tr>
							<th>メール</th>
							<td><input type="text" id="customer_email" /></td>
						</tr>
						<tr>
							<th>開始日</th>
							<td><input type="text" id="customer_startdate" class="datepicker"></td>
						</tr>
						<tr>
							<th>誕生日</th>
							<td><input type="text" id="customer_birth" class="datepicker"></td>
						</tr>
						<tr>
							<th>興味</th>
							<td><textarea id="customer_favorite" rows="4"></textarea></td>
						</tr>
						<tr>
							<th>メモ</th>
							<td><textarea id="customer_memo" rows="4"></textarea></td>
						</tr>
					</table>
					
					
				</div>
				<hr>
				<h1>レポート</h1>
				<div class="box">
					<button type="button" id="btn_report" onclick="btn_report_save_click()">
						<img src="images/save.png" />
					</button>
				</div>
				<div id="report"></div>
			</div>
	</div>
<!-- ダイアログ関連 -->
		<a href="/images/image.jpg" data-lity id="data-lity"></a>
		<div id="plan" contenteditable="true"></div>
		<div id="customer" contenteditable="true"></div>
		<div id="wmin1"></div>
		<div id="wmin2"></div>
		<div id="wmin3"></div>
		<div id="wmin4"></div>
		<div id="wmin5"></div>
		<div id="wmin6"></div>
		<div id="wmin7"></div>
		<div id="wmin8"></div>
		<div id="wmin9"></div>
		<div id="wmin10"></div>
		<div id="wmin11"></div>
		<div id="wmin12"></div>
		<div id="mmin1"></div>
		<div id="mmin2"></div>
		<div id="mmin3"></div>
		<div id="mmin4"></div>
		<div id="mmin5"></div>
		<div id="mmin6"></div>
		<div id="mmin7"></div>
		<div id="mmin8"></div>
		<div id="mmin9"></div>
		<div id="mmin10"></div>
		<div id="mmin11"></div>
		<div id="mmin12"></div>
		<div id="wmax1"></div>
		<div id="wmax2"></div>
		<div id="wmax3"></div>
		<div id="wmax4"></div>
		<div id="wmax5"></div>
		<div id="wmax6"></div>
		<div id="wmax7"></div>
		<div id="wmax8"></div>
		<div id="wmax9"></div>
		<div id="wmax10"></div>
		<div id="wmax11"></div>
		<div id="wmax12"></div>
		<div id="mmax1"></div>
		<div id="mmax2"></div>
		<div id="mmax3"></div>
		<div id="mmax4"></div>
		<div id="mmax5"></div>
		<div id="mmax6"></div>
		<div id="mmax7"></div>
		<div id="mmax8"></div>
		<div id="mmax9"></div>
		<div id="mmax10"></div>
		<div id="mmax11"></div>
		<div id="mmax12"></div>
		<div id="wscale1"></div>
		<div id="wscale2"></div>
		<div id="wscale3"></div>
		<div id="wscale4"></div>
		<div id="wscale5"></div>
		<div id="wscale6"></div>
		<div id="wscale7"></div>
		<div id="wscale8"></div>
		<div id="wscale9"></div>
		<div id="wscale10"></div>
		<div id="wscale11"></div>
		<div id="wscale12"></div>
		<div id="mscale1"></div>
		<div id="mscale2"></div>
		<div id="mscale3"></div>
		<div id="mscale4"></div>
		<div id="mscale5"></div>
		<div id="mscale6"></div>
		<div id="mscale7"></div>
		<div id="mscale8"></div>
		<div id="mscale9"></div>
		<div id="mscale10"></div>
		<div id="mscale11"></div>
		<div id="mscale12"></div>

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
var barChartData_org = {
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
var complexChartOption_org = {
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