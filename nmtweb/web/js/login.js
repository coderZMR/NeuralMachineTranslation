function UserCheck() {
    var username = document.getElementById("userName");
    if (username.value.length === 0){
        document.getElementById("0").innerHTML = "用户名为空";
    }
    else document.getElementById("0").innerHTML = "";
}

function PasswordCheck() {
    var password = document.getElementById("password");
    if (password.value.length === 0){
        document.getElementById("1").innerHTML = "密码为空";
    }
    else document.getElementById("1").innerHTML = "";
}

function show()
{
    var now = new Date();
    var h = now.getHours();
    var m = now.getMinutes();
    var s = now.getSeconds();
    var obj = document.getElementById("time");
    obj.innerHTML = h + ":" + m + ":" + s;
    setTimeout("show()", 1000);
}

function check()
{
    if (document.getElementById("userName").value.length !== 0 && document.getElementById("password").value.length !== 0 &&
        document.getElementById("0").innerHTML === "" && document.getElementById("1").innerHTML === "")
    {
        document.getElementById("submit").disabled = false;
    } else {
        document.getElementById("submit").disabled = true;
    }
    setTimeout("check()", 1000);
}