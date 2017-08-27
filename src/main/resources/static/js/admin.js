$(function() {
	
	$(document).on("click", ".ui-dialog .dialog-button-close", function(){
	    $(this).closest(".ui-dialog-content").dialog("close");
	});
	
	 $("#startdate").keydown(function(event){
		    return false;
	 });	
	 $("#birth").keydown(function(event){
		    return false;
	 });	
	$('tr:nth-child(odd)').addClass('odd');        	
    var dateFormat = 'yy/mm/dd';
    $('.datepicker').datepicker({
        dateFormat: dateFormat
    });

    $( "#datepicker" ).datepicker();
    $( "#startdate" ).datepicker();
    $( "#birth" ).datepicker();
    
	$('#btn_memplus').click(function() {
		$("#memplus_dialog").dialog({
		});
	});
	
	$('#btn_question').click(function() {
		$("#question_dialog").dialog({
			width: 500
		});
	});
	customersList();
});
function close_dialog(obj) {
//    jQuery( this ).dialog( 'close' );
	
	jQuery(obj).dialog( 'close' );
}
function btn_customer_del_click() {
	
	var data = [];
	$($('.delete:checked')).each(function(){
		var addData = {"id":$(this).val()};
		data.push(addData);
		console.log($(this).val());
	});
	if ( data.length == 0 ) {
    	disp_alert("削除対象を選択して下さい。");
		return;
	}
	$.ajax({
		  type: 'POST',
		  url: '/customer/delete',
          data : JSON.stringify(data),
          contentType: 'application/JSON',
          dataType : 'JSON',
          scriptCharset: 'utf-8',
            success : function(data) {
                // Success
                //alert("success");
                //alert(JSON.stringify(data));
            	disp_alert("削除しました。");
                $("#response").html(JSON.stringify(data));
                customersList();
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
function btn_search_click() {
/*
    		var test = unescape(encodeURIComponent("あ"));
    		$.ajax({
    			  type: 'GET',
    			  url: "/customer/search?startDate=" + $("#search_startDate").val() + "&name=" + test + "&keyword=" + $("#search_keyword").val(),
    			  dataType: 'json',
    			  success: function(json){
    				  customres = json;
    			  }
    		});
*/
    $.ajax({
        type : 'POST',
        url : "/customer/search",
        data : JSON.stringify({
            "startdate" : $("#search_startDate").val(),
            "name" : $("#search_name").val(),
            "memo": $("#search_keyword").val()
        }),
        contentType: 'application/JSON',
        dataType : 'JSON',
        scriptCharset: 'utf-8',
        success : function(data) {
            // Success
            //alert("success");
            //alert(JSON.stringify(data));
            $("#response").html(JSON.stringify(data));
            
			var results = data;
			$("#customers").empty();    				
			$("#customers").append(
				 $("<tr></tr>")
				        .append($("<th></th>").text(""))
				        .append($("<th></th>").text("名前"))
				        .append($("<th></th>").text("メール"))
				        .append($("<th></th>").text("開始日"))
				        .append($("<th></th>").text("メモ"))
				        .append($("<th></th>").text("興味"))
				        .append($("<th></th>").text("状態"))
				        .append($("<th></th>").text("サイト"))
				        .append($("<th></th>").text("計画"))
			);

		    for(var i in results){
		    	var item = $.extend(true, {}, $("#plan_col").clone());  			    	
		    	var link = $.extend(true, {}, $("#link_text").clone());  			    	
				$("#customers").append(
				    $("<tr></tr>")
				    	.append($("<td></td>").append($('<input type="checkbox"></input>').addClass("delete").attr('value', results[i].id)))
				        .append($("<td></td>").text(results[i].name))
				        .append($("<td></td>").text(results[i].email))
				        .append($("<td></td>").text(results[i].startdate))
				        .append($("<td></td>").text(results[i].memo))
				        .append($("<td></td>").text(results[i].favorite))
				        .append($("<td></td>").text(results[i].state))
				        .append($("<td></td>").append(link.attr("href", results[i].site)))
				        .append($("<td></td>").append(item).attr("onclick", "plan_dialog_click(" + results[i].id + ")"))
				);
		    }
		    
		    
    		var sources = [];
		    $(".gantt").empty();
		    var searchs = data;
		    for(var i in searchs){
		    	var search = searchs[i]
            	var today = moment(search.from);
            	var andTwoDates = moment(search.to);
		    
           		var today_friendly = "/Date(" + today.valueOf() + ")/";
            	var next_friendly = "/Date(" + andTwoDates.valueOf() + ")/";
		    
            	var data1 = {
                       name: search.name,
                       desc: search.state,
                       values: [{
                           from: today_friendly,
                           to: next_friendly,
                           label: search.name + " " + search.state,
                           customClass: "ganttRed"
                       }]
              	};
            	sources.push(data1);
		    }
            $(".gantt").gantt({
                source: sources,
                scale: "dates",
                minScale: "dates",
                navigate: "scroll"
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
	
}
function btn_plan_save_click ( customId ) {
	  var ids = [];
	  var userids = [];
      $('[id^=planid]').each(function(){ // 各要素のidと前方一致するidが_oldで終わる要素のvalueを、
    	  ids.push($(this).val()); // _newに挿入する
      });
      $('[id^=plan_userId]').each(function(){ // 各要素のidと前方一致するidが_oldで終わる要素のvalueを、
    	  userids.push($(this).val()); // _newに挿入する
      });
	var data = [];
	var tr = $("#plan_table tr");//全行を取得
	for(var i=0, l=tr.length; i<l;i++ ){ //行数分回す
		if ( i == 0 ) continue;
		var cells = tr.eq(i).children();//1行目から順にth、td問わず列を取得
		if ( cells.eq(1).text().length > 0) {
			//data[i] = cells.eq(1).text();//i行目j列の文字列を取得
//			var addData = {"id":cells.eq(0).text(),"userId":cells.eq(1).text(),"week":cells.eq(2).text(),"plan":cells.eq(3).text()};
			var addData = {"id":ids[i - 1],"userId":userids[i - 1], "week":cells.eq(0).text(),"plan":cells.eq(1).text()};
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
        	$("#plan_dialog").dialog("close");
            // Success
            //alert("success");
            //alert(JSON.stringify(data));
            $("#response").html(JSON.stringify(data));
            disp_alert("登録しました。");
//            customersList();
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
function plan_dialog_click( customId ) {
	$("#plan_table").empty();
	//計画
	$.ajax({
		  type: 'GET',
		  url: '/plan/'+ customId,
		  dataType: 'json',
		  success: function(json){
			  var plans = json;
				$("#plan_table").append(
					 $("<tr></tr>")
//					        .append($("<th></th>").text("i").css("display", 'none'))
//					        .append($("<th></th>").text("u"))
					        .append($("<th></th>").text("週").css("width", '10%'))
					        .append($("<th></th>").text("計画").css("width", '90%'))
				);
			    for(var i in plans){
			    	var item = $.extend(true, {}, $("#plan").clone());
			    	item.text(plans[i].plan)
			    	//item.id(plans[i].week)
					$("#plan_table").append(
					    $("<tr></tr>")
//					        .append($("<td></td>").text(plans[i].id))
//					        .append($("<td></td>").text(plans[i].userId))
					        .append($("<td></td>").text(plans[i].week)
					        		.append("<input type='hidden'></input>").attr("id", "planid_" + plans[i].id).val(plans[i].id))
//					        .append($("<td></td>").text(plans[i].week))
							.append($("<td></td>").append(item).append("<input type='hidden'></input>").attr("id", "plan_userId_" + plans[i].id).val(plans[i].userId))
					);
			    }
				$("#plan_dialog").dialog({
			        width: 400
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
}
function btn_save_question() {
	
	var data = [];
	var tr = $("#table_question tr");//全行を取得
	for(var i=0, l=tr.length; i<l;i++ ){ //行数分回す
		if ( i == 0 ) continue;
		var cells = tr.eq(i).children();//1行目から順にth、td問わず列を取得
		if ( cells.eq(1).text().length > 0) {
			//data[i] = cells.eq(1).text();//i行目j列の文字列を取得
			var addData = {"seqno":i,"question":cells.eq(1).text()};
			data.push(addData);
		}
	}
	console.log(JSON.stringify(data));
	
    $.ajax({
        type : 'POST',
        url : "/question/save",
        data : JSON.stringify(data),
        contentType: 'application/JSON',
        dataType : 'JSON',
        scriptCharset: 'utf-8',
        success : function(data) {
        	$("#question_dialog").dialog("close");
            // Success
            //alert("success");
            //alert(JSON.stringify(data));
            $("#response").html(JSON.stringify(data));
            disp_alert("登録しました。");
            //$("#alert_msg").text("登録しました。");
            //$("#alert_dialog").dialog({
            //    buttons: {
            //        'OK': function() {
            //            jQuery( this ).dialog( 'close' );
            //         }
            //    }
            //});
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
function btn_save_click() {
	$("#errmsg").text("");
	if ( $("#name").val().length == 0 ) {
		$("#errmsg").text("名称を入力してください。");
		return ;
	}
	if ( $("#password").val().length == 0 ) {
		$("#errmsg").text("パスワードを入力してください。");
		return ;
	}
	if ( $("#password").val().length == 0 ) {
		$("#startdate").text("開始日を入力してください。");
		return ;
	}
    $.ajax({
        type : 'POST',
        url : "/customer/save",
        data : JSON.stringify({
            "name" : $("#name").val(),
            "password" : $("#password").val(),
            "email": $("#email").val(),
            "startdate" : $("#startdate").val(),
            "birth" : $("#birth").val(),
            "favorite" : $("#favorite").val(),
            "memo": $("#memo").val()
        }),
        contentType: 'application/JSON',
        dataType : 'JSON',
        scriptCharset: 'utf-8',
        success : function(data) {
        	$("#memplus_dialog").dialog("close");
            // Success
            //alert("success");
            //alert(JSON.stringify(data));
        	disp_alert("登録しました。")
            $("#response").html(JSON.stringify(data));
            customersList();
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
function questionList() {
	$("#table_question").empty();
	$.ajax({
		  type: 'GET',
		  url: '/question/selectall',
		  dataType: 'json',
		  success: function(json){
			//$("#message11").text(json[0].name);
			var questions = json;
			$("#table_question").append(
				 $("<tr></tr>")
				        .append($("<th></th>").text("No"))
				        .append($("<th></th>").text("内容"))
			);

		    for(var i in questions){
		    	var item = $.extend(true, {}, $("#plan_col").clone());  			    	
				$("#table_question").append(
				    $("<tr></tr>")
				        .append($("<td></td>").text(questions[i].seqno))
				        .append($("<td contenteditable='true'></td>").text(questions[i].question).css("background-color","white"))
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

}
function customersList() {
    "use strict";
	var sources = [];
	questionList();
	var url = '/customer/init';
	$.ajax({
		  type: 'GET',
		  url: url,
		  dataType: 'json',
		  success: function(json){
		    var searchs = json;
		    for(var i in searchs){
		    	var search = searchs[i]
            	var today = moment(search.from);
            	var andTwoDates = moment(search.to);
		    
           		var today_friendly = "/Date(" + today.valueOf() + ")/";
            	var next_friendly = "/Date(" + andTwoDates.valueOf() + ")/";
		    
            	var data = {
                       name: search.name,
                       desc: search.state,
                       values: [{
                           from: today_friendly,
                           to: next_friendly,
                           label: search.name + " " + search.state,
                           customClass: "ganttRed"
                       }]
              	};
            	sources.push(data);
		    }
            $(".gantt").gantt({
                source: sources,
                scale: "dates",
                minScale: "dates",
                navigate: "scroll"
            });
            disp_customers(json);
		  }
	});
}
function disp_customers(customers) {
	$("#customers").empty();
	$("#customers").append(
		$("<tr></tr>")
			        .append($("<th></th>").text(""))
			        .append($("<th></th>").text("名前"))
			        .append($("<th></th>").text("メール"))
			        .append($("<th></th>").text("開始日"))
			        .append($("<th></th>").text("メモ"))
			        .append($("<th></th>").text("興味"))
			        .append($("<th></th>").text("状態"))
			        .append($("<th></th>").text("サイト"))
			        .append($("<th></th>").text("計画"))
		);

	    for(var i in customers){
	    	var item = $.extend(true, {}, $("#plan_col").clone());
	    	var link = $.extend(true, {}, $("#link_text a").clone()).attr("href", customers[i].site);
			$("#customers").append(
			    $("<tr></tr>")
			    	.append($("<td></td>").append($('<input type="checkbox"></input>').addClass('delete').attr('value', customers[i].id)))
			        .append($("<td></td>").text(customers[i].name))
			        .append($("<td></td>").text(customers[i].email))
			        .append($("<td></td>").text(customers[i].startdate))
			        .append($("<td></td>").text(customers[i].memo))
			        .append($("<td></td>").text(customers[i].favorite))
			        .append($("<td></td>").text(customers[i].state))
			        .append($("<td></td>").append(link))
			        .append($("<td></td>").append(item).attr("onclick", "plan_dialog_click(" + customers[i].id + ")"))
			);
	    }
}

function customersList1() {
	$("#customers").empty();
	$.ajax({
		  type: 'GET',
		  url: '/customer/selectall',
		  dataType: 'json',
		  success: function(json){
			//$("#message11").text(json[0].name);
			var customers = json;
			$("#customers").append(
				 $("<tr></tr>")
				        .append($("<th></th>").text(""))
				        .append($("<th></th>").text("名前"))
				        .append($("<th></th>").text("メール"))
				        .append($("<th></th>").text("開始日"))
				        .append($("<th></th>").text("メモ"))
				        .append($("<th></th>").text("興味"))
				        .append($("<th></th>").text("状態"))
				        .append($("<th></th>").text("サイト"))
				        .append($("<th></th>").text("計画"))
			);

		    for(var i in customers){
		    	var item = $.extend(true, {}, $("#plan_col").clone());  			    	
				$("#customers").append(
				    $("<tr></tr>")
				    	.append($("<td></td>").append($('<input type="checkbox"></input>').addClass('delete').attr('value', customers[i].id)))
				        .append($("<td></td>").text(customers[i].name))
				        .append($("<td></td>").text(customers[i].email))
				        .append($("<td></td>").text(customers[i].startdate))
				        .append($("<td></td>").text(customers[i].memo))
				        .append($("<td></td>").text(customers[i].favorite))
				        .append($("<td></td>").text(customers[i].status))
				        .append($("<td></td>").append($("#link_text a").attr("href", customers[i].site)))
				        .append($("<td></td>").append(item).attr("onclick", "plan_dialog_click(" + customers[i].id + ")"))
				);
		    }
			
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
}
