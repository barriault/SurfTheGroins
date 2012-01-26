var slides= new Array('slide1', 'slide2'); 
var i = 0; var wait = 5000;

function SlideShow() {
	Effect.Fade(slides[i], { duration:1, from:1.0, to:0.0 }); 
	i++;
	if (i == 2) i = 0; 
		Effect.Appear(slides[i], { duration:1, from:0.0, to:1.0 });
	} 


// the onload event handler that starts the fading. 
function start_slideshow() { setInterval('SlideShow()',wait); }

