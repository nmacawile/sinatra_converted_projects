$(document).ready(function(){
	x = 0
	$('.selection').on("click", function(){
		if(x < 4) {
			x++
			if(x == 4) { $('#crack').prop("disabled", false) }
			code = $(this).data("code");
			$("#pending" + x).addClass(code);
			$("#guess").val(function() {
			    return this.value + code;
			});
		}
	});

	$('#clear').on("click", function(){
		x = 0
		$('#crack').prop("disabled", true)
		$(".pending").attr('class', 'pending');
		$("#guess").val("");
	});

});