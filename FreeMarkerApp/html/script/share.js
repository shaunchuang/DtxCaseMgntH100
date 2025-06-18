function shareFb(url,title, summary){
	//window.open("http://www.facebook.com/sharer.php?s=100&p[url]="+encodeURIComponent(url)+"&p[images][0]="+encodeURIComponent(url)+"&p[title]="+encodeURIComponent(title)+"&p[summary]="+encodeURIComponent(summary),'sharer','toolbar=0,status=0,width=626,height=436');
	window.open('http://www.facebook.com/share.php?u='.concat(encodeURIComponent(url)) ); 
}

function sharePlurk(url,title){
	window.open('http://www.plurk.com/?qualifier=shares&status='.concat(encodeURIComponent(url)).concat(' ').concat('&#40;(').concat(encodeURIComponent(title)).concat(')&#41;')); 
}

function shareMySpace(title){
	window.open('http://www.myspace.com/Modules/PostTo/Pages/?u='+encodeURIComponent(document.location.toString()),'ptm','height=450,width=440').focus();
}

function shareTwitter(title){
	window.open('http://twitter.com/home/?status='.concat(encodeURIComponent(title)).concat(' ').concat(encodeURIComponent(location.href))); 
}

function shareGoolePlus(url,title){
	//window.open('https://m.google.com/app/plus/x/'.concat(encodeURIComponent(title)).concat(' ').concat(encodeURIComponent(url)));
	window.open('https://plus.google.com/share?url='.concat(encodeURIComponent(url)));
}