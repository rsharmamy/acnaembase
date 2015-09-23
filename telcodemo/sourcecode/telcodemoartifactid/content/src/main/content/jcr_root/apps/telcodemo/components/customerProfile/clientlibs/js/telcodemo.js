function ajaxhit_get(){

console.log('enter ajax call');

$.ajax({
	type: 'GET',
    url: 'http://www.mocky.io/v2/55ffb30e3a1553320d41a610',
  	data: { },
    contentType: "application/json",
	//dataType: 'json',
	dataType: 'jsonp',

  beforeSend:function(){

      console.log('before call');
  },
  success:function(data){
    display(data);
  },
  error:function(){

      console.log('error in ajax hit');
  }

});

}

function display(data){

    var keys = Object.keys(data);

    Object.keys(data).forEach(function(k) {
		var idVar = '#userprofile_'+k;
      	//console.log(data[k]);
		$(idVar).html(data[k]);

    });

}
