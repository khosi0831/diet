<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="jp">
    <head>
        <title>顧客管理</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=Edge;chrome=IE8">
	 		 	<link rel="stylesheet" href="/jquery/jquery-ui-1.11.4.custom/jquery-ui.css">
        <link href="/jquery/jQuery.Gantt-master/css/style.css" type="text/css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <style type="text/css">
            body {
                font-family: Helvetica, Arial, sans-serif;
                font-size: 13px;
                padding: 0 0 50px 0;
            }
            .contain {
                width: 800px;
                margin: 0 auto;
            }
            h1 {
                margin: 40px 0 20px 0;
            }
            h2 {
                font-size: 1.5em;
                padding-bottom: 3px;
                border-bottom: 1px solid #DDD;
                margin-top: 50px;
                margin-bottom: 25px;
            }
			table{
				margin: 15px auto 10px auto;
			}
			
			
			th{
				padding:5px;
				background:#266;
				border:1px solid #777;
				color: #fff;
                font-size: 13px;
			}
			td{
				border:solid 1px #777;
				background:#eee;
				padding:5px;
                font-size: 13px;
			}
			table tr.odd td {
				background: #ccc;
			}            
        </style>
    </head>
    <body>

        <div class="contain">


            <div class="gantt"></div>
	<button type="button" id="btn_memplus">
		<img src="images/memplus.png" />
	</button>
	<button type="button" id="btn_question">
		<img src="images/kao_small.png" />
	</button>
	<button type="button" id="btn_del" onclick="btn_customer_del_click();">
		<img src="images/del.png"/>
	</button>
	
開始日: <input type="text" id="search_startDate" class="datepicker">
名称: <input type="text" id="search_name">
メモ: <input type="text" id="search_keyword">
	<button type="button" id="btn_search" onclick="btn_search_click();">
		<img src="images/search.png" />
	</button>

<table id="customers" border="1"></table>


<!-- ダイアログ関連 -->
<div id="link_text"><a href="http://www.520328.com/" target="_blank">サイトへ</a></div>
<div id="plan_dialog" title="計画" style="display: none">
	<button type="button" id="btn_save" onclick="btn_plan_save_click();"><img src="images/save.png"/></button>
	<table id="plan_table" border="1" width="300"></table>	
</div>
<div id="plan" contenteditable="true"></div>
<div id="plan_col">click</div>
<div id="memplus_dialog" style="display: none">
	<button type="button" id="btn_save" onclick="btn_save_click();"><img src="images/save.png"/></button>
	<table border="1">
		<tr>
			<th>名称</th>
			<td><input type="text" id="name" /></td>
		</tr>
		<tr>
			<th>パスワード</th>
			<td><input type="text" id="password" /></td>
		</tr>
		<tr>
			<th>メール</th>
			<td><input type="text" id="email" /></td>
		</tr>
		<tr>
			<th>開始日</th>
			<td><input type="text" id="startdate" class="datepicker"></td>
		</tr>
		<tr>
			<th>誕生日</th>
			<td><input type="text" id="birth" class="datepicker"></td>
		</tr>
		<tr>
			<th>興味</th>
			<td><textarea id="favorite" rows="4"></textarea></td>
		</tr>
		<tr>
			<th>メモ</th>
			<td><textarea id="memo" rows="4"></textarea></td>
		</tr>
	</table>
</div>


	<div id="question_dialog" style="display: none">
		<button type="button" id="btn_save_question" onclick="btn_save_question();"><img src="images/save.png"/></button>
		<table border="1" id="table_question"></table></table>
	</div>



    <script src="jquery/jQuery.Gantt-master/js/jquery.min.js"></script>
    <script src="jquery/jQuery.Gantt-master/js/jquery.fn.gantt.js"></script>
    <script src="http://cdnjs.cloudflare.com/ajax/libs/moment.js/2.8.4/moment.min.js"></script>
  	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script>
    	function btn_customer_del_click() {
    		
    		var data = [];
    		$($('.delete:checked')).each(function(){
   				var addData = {"id":$(this).val()};
   				data.push(addData);
    			console.log($(this).val());
    		});
    		
//			$("#customers").empty();    				
			$.ajax({
				  type: 'POST',
				  url: '/customer/delete',
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
		            "startDate" : $("#search_startDate").val(),
		            "name" : $("#search_name").val(),
		            "memo": $("#search_keyword").val()
	            }),
	            contentType: 'application/JSON',
	            dataType : 'JSON',
	            scriptCharset: 'utf-8',
	            success : function(data) {
	                // Success
	                alert("success");
	                alert(JSON.stringify(data));
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
	                alert("error");
	                alert(JSON.stringify(data));
	                $("#response").html(JSON.stringify(data));
	            }
	        });
    		
    	}
    	function btn_plan_save_click ( customId ) {
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
						$("#plan_dialog").dialog({});
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
		function btn_save_click() {
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
    					        .append($("<td contenteditable='true'></td>").text(questions[i].question))
    					);
    			    }
    				
    			  }
    			});
		
		}
		function customersList() {
            "use strict";
    		var sources = [];
    		questionList();
    		var url = '/customer/search1';
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
					        .append($("<td></td>").text(customers[i].status))
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
        $(function() {
        	
        	$('tr:nth-child(odd)').addClass('odd');        	
            var dateFormat = 'yy/mm/dd';
            $('.datepicker').datepicker({
                dateFormat: dateFormat
            });

		    $( "#datepicker" ).datepicker();
		    $( "#startdate" ).datepicker();
		    $( "#birth" ).datepicker();
		    
			$('#btn_memplus').click(function() {
				$("#memplus_dialog").dialog({});
			});
			
			$('#btn_question').click(function() {
				$("#question_dialog").dialog({
					width: 500
				});
			});
			
			
			customersList();
/*
			"use strict";
    		var sources = [];
    		questionList();
    		var url = '/customer/search1';
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
    	            
    			  }
    		});
            
*/            


/*
            var today = moment();
            var andTwoDates = moment().add(50, "days");

            var today_friendly = "/Date(" + today.valueOf() + ")/";
            var next_friendly = "/Date(" + andTwoDates.valueOf() + ")/";
            $(".gantt").gantt({
                source: [
                 {
                    name: "Testing111",
                    desc: " ",
                    values: [{
                        from: today_friendly,
                        to: next_friendly,
                        label: "Test",
                        customClass: "ganttRed"
                    }]
                },
                {
                    name: "Testing",
                    desc: " ",
                    values: [{
                        from: today_friendly,
                        to: next_friendly,
                        label: "Test1",
                        customClass: "ganttRed"
                    }]
                }

                ],
                scale: "dates",
                minScale: "dates",
                navigate: "scroll"
            });
*/            
//顧客
//            customersList();
            
        
        });

    </script>
    </body>
</html>
