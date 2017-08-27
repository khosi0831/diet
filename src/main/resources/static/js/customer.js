  $( function() {
	  $(document).on('change', ':file', function() {
		    var input = $(this),
		    numFiles = input.get(0).files ? input.get(0).files.length : 1,
		    label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
		    input.parent().parent().next(':text').val(label);

		    var files = !!this.files ? this.files : [];
		    if (!files.length || !window.FileReader) return; // no file selected, or no FileReader support
		    if (/^image/.test( files[0].type)){ // only image file
		        var reader = new FileReader(); // instance of the FileReader
		        reader.readAsDataURL(files[0]); // read the local file
		        reader.onloadend = function(){ // set image data as background of div
		            input.parent().parent().parent().prev('.imagePreview').css("background-image", "url("+this.result+")").css("width",128).css("height",128);
		        }
		    }
		});	  
	 $("#customer_startdate").keydown(function(event){
		    return false;
	 });	
	 $("#customer_birth").keydown(function(event){
		    return false;
	 });	
	  
	 
	 
     var dateFormat = 'yy/mm/dd';
     $('.datepicker').datepicker({
         dateFormat: dateFormat
     });
	$( "#week_select" ).val($("#week").text());
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
		
		planlist();
		customerlist();
		mindlist();
		reportlist();
		lecturelist();
		advicelist();
		photolist();
		weightlist();
		role();
		$("#location").click(function () {
		      var pram="week="+$("#week_select").val();
		      window.location.href= "/" + $("#id").text() + "?" + pram;	
		}).change();		
		

	    // アップロードボタンを押下した
	    $("#data_upload_form").submit(function(event){
	        // 要素規定の動作をキャンセルする
	        event.preventDefault();
	        var ajaxUrl = "/photo/upload?";
	        ajaxUrl += "userid=" + $("#id").text();
	        ajaxUrl += "&week=" + $("#week").text();

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
		            	$("#upload_file").val("");
				        $("#response").html(JSON.stringify(data));
//		                var photo = data;
//  					    var photo_area = $("<div></div>").addClass(photo.id);
//  					    var photo_area1 = photo_area.append($('<input type="checkbox"></input>').addClass("delete").attr('value', photo.id));
//  					    var photo_area1_1 = photo_area1.append($("<a>").attr("href", photo.url).attr("data-lity", ""));
//  					    var photo_area2 = photo_area1_1.append($("<img>").attr("src", photo.url).attr("width",128).attr("height",128));
//  					  	$("#photo_area").append(photo_area2);
//		                createPhoto(data);
  					  	photolist();
				         // 現在表示されているページをリロードする
//			            location.reload();
		            },
		            error : function(data) {
		                // Error
		                //alert("error");
		                //alert(JSON.stringify(data));
		                $("#response").html(JSON.stringify(data));
			            disp_alert("エラーが発生しました。管理者に連絡して下さい。");
		            }
	            });
	        }else{
	        	disp_alert("アップロードに対応できていないブラウザです。");
	        }
	    });
	    
  } );
  function week_select_change() {
      var pram="week="+$("#week_select").val();
      window.location.href= "/" + $("#id").text() + "?" + pram;	
  }
  function weightlist() {
		//体重ここから
		$.ajax({
			  type: 'GET',
			  url: '/weight/'+ $("#id").text(),
			  dataType: 'json',
			  success: function(data){
		          $("#response").html(JSON.stringify(data));
				  label_data = [];
				  weight_data = [];
				  mile_data = [];
				  barChartData = ""; 
				  complexChartOption = "";
				  
				  dataset(data);
				  label();
				  graphset();
				  disp_graph();
				  diff();
			  },
		      error : function(data) {
		            // Error
		            //alert("error");
		            //alert(JSON.stringify(data));
		            $("#response").html(JSON.stringify(data));
		            disp_alert("エラーが発生しました。管理者に連絡して下さい。");
		      }
		});
  }
  function photolist() {
		//写真ここから
		var url = '/photo/'+ $("#id").text() + "?week=" + $("#week").text();
		$.ajax({
			  type: 'GET',
			  url: url,
			  dataType: 'json',
			  success: function(json){
				  $("#photo_area").empty();
				  var photos = json;
			      for(var i in photos){
			    		var item = $.extend(true, {}, $("#data-lity").clone());
					    var photo_area = $("<div id='img-container'></div>").addClass(photos[i].id);
					    var photo_area1 = photo_area.append($('<input type="checkbox"></input>').addClass("delete").attr('value', photos[i].id));
//					    var photo_area1_1 = photo_area1.append(item.attr("href", photos[i].url));
//					    var photo_area1_1 = photo_area1.append(item);
					    var photo_area1_1 = photo_area1.append($("<a>").attr("href", photos[i].url).attr("data-lity", "data-lity")
					    		.append($("<img>").attr("src", photos[i].url).attr("width",200).attr("height",150)));
//					    var photo_area2 = photo_area1_1.append($("<img>").attr("src", photos[i].url).attr("width",128).attr("height",128));
					  	$("#photo_area").append(photo_area1_1);
			      }
			      role();			  
			      $('[id^=img-container]').each(function(){
			    	  $(this).imgLiquid({ fill: false });	 
			      });
			      
			  },
		      error : function(data) {
		            // Error
		            //alert("error");
		            //alert(JSON.stringify(data));
		            $("#response").html(JSON.stringify(data));
		            disp_alert("エラーが発生しました。管理者に連絡して下さい。");
		      }
		});
					    
		//写真ここまで
  }
  function advicelist() {
		//アドバイスここから
		var url = '/advice/'+ $("#id").text() + "?week=" + $("#week").text();
		$.ajax({
			  type: 'GET',
			  url: url,
//			  url: "/advice/15?week=1",
			  dataType: 'json',
			  success: function(data){
		          $("#response").html(JSON.stringify(data));
				  disp_advice(data)
//				  $("#advice_textarea").val(lecture.memo);
//				  $("#advice_id").text(lecture.id);
			  },
		      error : function(data) {
		            // Error
		            //alert("error");
		            //alert(JSON.stringify(data));
		            $("#response").html(JSON.stringify(data));
		            disp_alert("エラーが発生しました。管理者に連絡して下さい。");
		      }
		});
		//アドバイスここまで
	  
  }
  function lecturelist() {
		//レクチャーここから
		var url = '/lecture/'+ $("#id").text() + "?week=" + $("#week").text();
		$.ajax({
			  type: 'GET',
			  url: url,
			  dataType: 'json',
			  success: function(data){
				  disp_lecture(data)
//				  var lecture = json;				  
//				  $("#lecture_textarea").val(lecture.memo);
//				  $("#lecture_id").text(lecture.id);
			  },
		      error : function(data) {
		            // Error
		            //alert("error");
		            //alert(JSON.stringify(data));
		            $("#response").html(JSON.stringify(data));
		            disp_alert("エラーが発生しました。管理者に連絡して下さい。");
		      }
		});
		//レクチャーここまで		
  }
  function reportlist() {
		//レポートここから
		$.ajax({
			  type: 'GET',
			  url: '/report/'+ $("#id").text(),
			  dataType: 'json',
			  success: function(json){
				  var reports = json;
				    for(var i in reports){
				    	chatmsg(reports[i], "question");
				    	chatmsg(reports[i], "answer");
				    }
			  },
		      error : function(data) {
		            // Error
		            //alert("error");
		            //alert(JSON.stringify(data));
		            $("#response").html(JSON.stringify(data));
		            disp_alert("エラーが発生しました。管理者に連絡して下さい。");
		      }
		});
		//レポートここまで
  }
  function mindlist() {
		//マインドここから
		var url = '/mind/'+ $("#id").text() + "?week=" + $("#week").text();
		$.ajax({
			  type: 'GET',
			  url: url,
			  dataType: 'json',
			  success: function(data){
				  var mind = data;
				  disp_mind(data)
//				  $("#mind_textarea").val(mind.memo);
//				  $("#mind_id").text(mind.id);
			  },
		      error : function(data) {
		            // Error
		            //alert("error");
		            //alert(JSON.stringify(data));
		            $("#response").html(JSON.stringify(data));
		            disp_alert("エラーが発生しました。管理者に連絡して下さい。");
		      }
		});
		//マインドここまで
  }
  function customerlist() {
		//顧客ここから
		$.ajax({
			  type: 'GET',
			  url: '/customer/'+ $("#id").text(),
			  dataType: 'json',
			  success: function(json){
				  var customer = json;
					$( "#title_week" ).text($("#week").text() + "週");
				    if ( parseInt($("#week").text()) > 12) {
						$( "#title_week" ).text("まとめ");
				    }
					$( "#title_name" ).text(customer.name);
					$( "#customer_name" ).val(customer.name)
					$( "#customer_password" ).val(customer.password)
					$( "#customer_email" ).val(customer.email)
					$( "#customer_birth" ).val(customer.birth)
					$( "#customer_startdate" ).val(customer.startdate)
					$( "#customer_memo" ).val(customer.memo)
					$( "#customer_favorite" ).val(customer.favorite)
			  },
		      error : function(data) {
		            // Error
		            //alert("error");
		            //alert(JSON.stringify(data));
		            $("#response").html(JSON.stringify(data));
		            disp_alert("エラーが発生しました。管理者に連絡して下さい。");
		      }
		});
		//顧客ここまで
	  
  }
  function planlist() {
		//計画 ここから
		$.ajax({
			  type: 'GET',
			  url: '/plan/'+ $("#id").text(),
			  dataType: 'json',
			  success: function(json){
				  var plans = json;
					$("#plan_table").append(
						 $("<tr></tr>")
//						        .append($("<th></th>").text("i").attr())
//						        .append($("<th></th>").text("u"))
						        .append($("<th></th>").text("週").css("width","10%"))
						        .append($("<th></th>").text("計画").css("width","90%"))
					);
				    for(var i in plans){
				    	var item = $.extend(true, {}, $("#plan").clone());
				    	item.text(plans[i].plan)
				    	//item.id(plans[i].week)
						$("#plan_table").append(
						    $("<tr></tr>")
//						        .append($("<td></td>").text(plans[i].id).append("<input></input>").val(plans[i].id))
//						        .append($("<td></td>").text(plans[i].userId))
						        .append($("<td></td>").text(plans[i].week).append("<input type='hidden'></input>").attr("id", "planid_" + plans[i].id).val(plans[i].id))
								.append($("<td></td>").append(item).append("<input type='hidden'></input>").attr("id", "userid_" + plans[i].id).val(plans[i].userId))
						);
				    }
			  },
		      error : function(data) {
		            // Error
		            //alert("error");
		            //alert(JSON.stringify(data));
		            $("#response").html(JSON.stringify(data));
		            disp_alert("エラーが発生しました。管理者に連絡して下さい。");
		      }
		});
		//計画 ここまで
  }
  function createPhoto(url) {
		var date = {"userId":$("#id").text(),"week":$("#week").text(),"url":url};
	    $.ajax({
	        type : 'POST',
	        url : "/photo/save",
	        data : JSON.stringify(date),
	        contentType: 'application/JSON',
	        dataType : 'JSON',
	        scriptCharset: 'utf-8',
	        success : function(data) {
	            // Success
	            //alert("success");
	            //alert(JSON.stringify(data));
	            $("#response").html(JSON.stringify(data));
	        },
	        error : function(data) {
	            // Error
	            //alert("error");
	            //alert(JSON.stringify(data));
	            $("#response").html(JSON.stringify(data));
	            disp_alert("エラーが発生しました。管理者に連絡して下さい。");
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
	  var week = parseInt($("#week").text());
	  week = week == 13 ? 12 : week;	//まとめの場合は12週
	  
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
	  var week = $("#week").text() == '13' ? '12' : $("#week").text();
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
		        label: '人生の質(mile)',
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
  
  function btn_mind_save_click () {
	var date = {"id":$("#mind_id").text(),"userId":$("#id").text(),"week":$("#week").text(),"memo":$("#mind_textarea").val()};
    $.ajax({
        type : 'POST',
        url : "/mind/save",
        data : JSON.stringify(date),
        contentType: 'application/JSON',
        dataType : 'JSON',
        scriptCharset: 'utf-8',
        success : function(data) {
            // Success
            //alert("success");
            //alert(JSON.stringify(data));
            $("#response").html(JSON.stringify(data));
            disp_alert("登録しました。");
            disp_mind(data);
        },
        error : function(data) {
            // Error
            //alert("error");
            //alert(JSON.stringify(data));
            $("#response").html(JSON.stringify(data));
            disp_alert("エラーが発生しました。管理者に連絡して下さい。");
        }
    });
  }
function disp_mind(mind) {
	  $("#mind_textarea").val(mind.memo);
	  $("#mind_id").text(mind.id);
}
  function btn_lecture_save_click() {
		var date = {"id":$("#lecture_id").text(),"userId":$("#id").text(),"week":$("#week").text(),"memo":$("#lecture_textarea").val()};
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
	            //alert("success");
	            //alert(JSON.stringify(data));
	            $("#response").html(JSON.stringify(data));
	            disp_alert("登録しました。");
	        },
	        error : function(data) {
	            // Error
	            //alert("error");
	            //alert(JSON.stringify(data));
	            $("#response").html(JSON.stringify(data));
	            disp_alert("エラーが発生しました。管理者に連絡して下さい。");
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
		if ( data.length == 0 ) {
            disp_alert("削除対象を選択してください。");
		}
		$.ajax({
			type: 'POST',
			url: '/photo/delete',
            data : JSON.stringify(data),
            contentType: 'application/JSON',
            dataType : 'JSON',
            scriptCharset: 'utf-8',
	            success : function(data) {
	                // Success
	                //alert("success");
	                //alert(JSON.stringify(data));
	                $("#response").html(JSON.stringify(data));
	                disp_alert("削除しました。");
	                photolist();
	            },
	            error : function(data) {
	                // Error
	                //alert("error");
	                //alert(JSON.stringify(data));
	                $("#response").html(JSON.stringify(data));
	                disp_alert("エラーが発生しました。管理者に連絡して下さい。");
	            }
		});
  }
  function btn_advice_save_click() {
		var date = {"id":$("#advice_id").text(),"userId":$("#id").text(),"week":$("#week").text(),"memo":$("#advice_textarea").val()};
	    $.ajax({
	        type : 'POST',
	        url : "/advice/save",
	        data : JSON.stringify(date),
	        contentType: 'application/JSON',
	        dataType : 'JSON',
	        scriptCharset: 'utf-8',
	        success : function(data) {
	            // Success
	            //alert("success");
	            //alert(JSON.stringify(data));
	            $("#response").html(JSON.stringify(data));
	            disp_alert("登録しました。");
	            disp_advice(data);
	        },
	        error : function(data) {
	            // Error
	            //alert("error");
	            //alert(JSON.stringify(data));
	            $("#response").html(JSON.stringify(data));
	            disp_alert("エラーが発生しました。管理者に連絡して下さい。");
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
			    	,"userId":$("#id").text()
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
	            //alert("success");
	            //alert(JSON.stringify(data));
	            $("#response").html(JSON.stringify(data));
	            disp_alert("登録しました。");
	        },
	        error : function(data) {
	            // Error
	            //alert("error");
	            //alert(JSON.stringify(data));
	            $("#response").html(JSON.stringify(data));
	            disp_alert("エラーが発生しました。管理者に連絡して下さい。");
	        }
	    });
  }
  function btn_plan_save_click() {
	  var ids = [];
      $('[id^=planid]').each(function(){ // 各要素のidと前方一致するidが_oldで終わる要素のvalueを、
    	  ids.push($(this).val()); // _newに挿入する
      });
		var data = [];
		var tr = $("#plan_table tr");//全行を取得
		for(var i=0, l=tr.length; i<l;i++ ){ //行数分回す
			if ( i == 0 ) continue;
			var cells = tr.eq(i).children();//1行目から順にth、td問わず列を取得
			if ( cells.eq(1).text().length > 0) {
				//data[i] = cells.eq(1).text();//i行目j列の文字列を取得
				var addData = {"id":ids[i - 1],"userId":$("#id").text(), "week":cells.eq(0).text(),"plan":cells.eq(1).text()};
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
                //alert("success");
                //alert(JSON.stringify(data));
                $("#response").html(JSON.stringify(data));
                disp_alert("登録しました。");
            },
            error : function(data) {
                // Error
                //alert("error");
                //alert(JSON.stringify(data));
                $("#response").html(JSON.stringify(data));
                disp_alert("エラーが発生しました。管理者に連絡して下さい。");
            }
        });
  }
  function btn_customer_save_click() {
      $.ajax({
          type : 'POST',
          url : "/customer/save",
          data : JSON.stringify({
	            "id" : $("#id").text(),
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
              //alert("success");
              //alert(JSON.stringify(data));
              $("#response").html(JSON.stringify(data));
        	  disp_alert("登録しました。");
          },
          error : function(data) {
              // Error
              //alert("error");
              //alert(JSON.stringify(data));
              $("#response").html(JSON.stringify(data));
        	  disp_alert("エラーが発生しました。管理者に連絡して下さい。");
          }
      });
	  
  }
  function btn_weight_save_click() {
	  	var week = $("#week").text();
	  	
		$("#wmin" + week).text($("#wmin").val());
		$("#mmin" + week).text($("#mmin").val());
		$("#wmax" + week).text($("#wmax").val());
		$("#mmax" + week).text($("#mmax").val());
		$("#wscale" + week).text($("#wscale").val());
		$("#mscale" + week).text($("#mscale").val());
	  
		var wdata = {
				"id":$("#weight_id").text()
				,"userId":$("#id").text()
				,"week":$("#week").text()
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
	            //alert(JSON.stringify(data));
	            $("#response").html(JSON.stringify(data));
	        	disp_alert("登録しました");

	            label_data = [];
				weight_data = [];
				mile_data = [];
				barChartData = ""; 
				complexChartOption = "";
	            
			　　   label();
			    dataset(data);
			    graphset();
			    disp_graph();
			    diff();
	        },
	        error : function(data) {
	            // Error
	            //alert("error");
	            //alert(JSON.stringify(data));
	            $("#response").html(JSON.stringify(data));
	        	disp_alert("エラーが発生しました。管理者に連絡して下さい。");
	        }
	    });
  }
  function disp_alert(msg)  {
		$("#alert_msg").text("");
	    $("#alert_msg").text(msg);
	    $("#alert_dialog").dialog({
	        buttons: {
	            'OK': function() {
	                jQuery( this ).dialog( 'close' );
	            }
	        }
	    });
	    dialogCentering();
	}
  function dialogCentering(){
		//スクロール分を取得
		var sclLeft = document.body.scrollLeft || document.documentElement.scrollLeft;
		var sclTop = document.body.scrollTop || document.documentElement.scrollTop;

		//画面幅取得
		var width = window.innerWidth;
		var height = window.innerHeight;

		//ダイアログ幅取得
		var d_w = $("div.ui-dialog.ui-widget.ui-widget-content.ui-corner-all").width();
		var d_h = $("div.ui-dialog.ui-widget.ui-widget-content.ui-corner-all").height();

		//画面の中での真ん中位置
		var left = (width - d_w) / 2 ;
		var top = (height - d_h) / 2 ;

		//スクロール幅を足す
		left = left + parseInt(sclLeft);
		top = top + parseInt(sclTop);

		$("div.ui-dialog.ui-widget.ui-widget-content.ui-corner-all").css("left", left + "px");
		$("div.ui-dialog.ui-widget.ui-widget-content.ui-corner-all").css("top", top + "px");
	}  
  function role() {
		 if ( "user" == $("#role").text()) {
	 	     $("[id^=save_btn]").css("display","none");
	 	     $("[id$=_textarea]").prop("disabled",true);
	 	     $("#tabs").find(':input').attr('disabled', true);
	 	     $("#weight_id").find(':input').attr('disabled', true);
	 	    
	 	     $("[id^=plan]").attr('contenteditable', false);
	 	     $("[id^=plan]").css('background-color', "#f5f5f5");
	 	     $("checkbox").css("display","none");
	 	     $("[class^='delete']").css("display","none");
	 	     $("[class^='chat-hukidashi2']").attr('contenteditable', false);
	 	     $("[class^='chat-hukidashi']").attr('contenteditable', false);
		 }
  }
