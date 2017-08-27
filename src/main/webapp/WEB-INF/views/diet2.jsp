<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
<script>
	$.ajax({
	  type: 'GET',
	  url: 'http://localhost:8080/customer/selectall',
	  dataType: 'json',
	  success: function(json){
		$("#message").text(json);
	    console.log(json)
	  }
	});
</script>
</head>
<body>
<ul id="demo"></ul>
<div id="message">
</div>
</body>
</html>