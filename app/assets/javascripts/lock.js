var Lock = function () {

    return {
        //main function to initiate the module
        init: function () {

             $.backstretch([
		        "/assets/bg/1.jpg",
		        "/assets/bg/2.jpg",
		        "/assets/bg/3.jpg",
		        "/assets/bg/4.jpg"
		        ], {
		          fade: 1000,
		          duration: 8000
		      });
        }

    };

}();