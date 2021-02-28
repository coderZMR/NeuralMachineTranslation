s = ["userName", "password", "PassTwo"];

function UserCheck()
{
    var User = document.getElementById("userName");
    if(User === null || User.value.length < 3 || User.value.length > 8) document.getElementById("0").innerHTML="账号长度应为3~8";
    else document.getElementById("0").innerHTML="";
}

function PassCheck()
{
    var Pass = document.getElementById("password");
    if(Pass === null || Pass.value.length < 3 || Pass.value.length > 8) document.getElementById("1").innerHTML="密码长度应为3~8";
    else document.getElementById("1").innerHTML="";
}

function PassTwoCheck()
{
    var PassTwo = document.getElementById("PassTwo");
    var Pass = document.getElementById("password");
    if(PassTwo.value !== Pass.value) document.getElementById("2").innerHTML="两次输入密码不一致";
    else document.getElementById("2").innerHTML="";
}

function SubmitCheck()
{
    var f = true;
    for(var i = 0; i < 3; ++i){
        if(document.getElementById(s[i]).value === "") {
            f = false;
            break;
        }
    }
    for(var j = 0; j < 3; ++j) {
        if(document.getElementById("" + j).innerHTML !== ""){
            f = false;
            break;
        }
    }
    if(f) {
        document.getElementById("submit").disabled = false;
    } else {
        document.getElementById("submit").disabled = true;
    }
    setTimeout("SubmitCheck()", 1000);
}