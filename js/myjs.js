function login() {
    var x = document.getElementById("formlogin");
    var y = document.getElementById("formregister");
    if (x.style.display === "none") {
        x.style.display = "block";
        y.style.display = "none";
    }
}
    function register() {
    var x = document.getElementById("formlogin");
    var y = document.getElementById("formregister");
    if (y.style.display === "none") {
        y.style.display = "block";
        x.style.display = "none";
    }
}
function coupon(){
		var prixtotal = document.getElementById("prixtotal").innerText;
		var couponvalue = document.getElementById("couponvalue").value;	
		document.getElementById("prixtotal").innerHTML=prixtotal-couponvalue;

}