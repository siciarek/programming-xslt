function switchFrame($, index) {
    var urls = [
		'/fractals/lsystem/bspline-triangle.xml',
		'/fractals/lsystem/approx-of-sierpinski.xml'
	];
	
	var url = location.href + urls[index];
	
	console.log(url);
	
	$('#display').attr('src', url);
}

$(document).ready(function() {
	$('#fractal').change(function(e){
		var self = $(this);

		switchFrame($, self.val());
	});
});