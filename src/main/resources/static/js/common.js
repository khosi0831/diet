//共通
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
