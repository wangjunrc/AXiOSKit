document.write("<script language=javascript src='js/client.js'></script>");



var button2 = document.getElementById('button2');
button2.addEventListener('click',function () {
                         
                         button2Click();
                         });

document.getElementById('button3').addEventListener('click',function () {
                                                    button3Click();
                                                    });



function showAler(data) {
    alert(data);
    return data+'收到'
    //    iosWeixinPay();
}
function showAler2() {
    alert(4);
    //    iosWeixinPay();
}



// js调oc 原生注入方式
function button2Click() {
    
    var person = new Person();
    person.name = 'jim';
    person.age = 12;
    
alert(isiOS);

if (isiOS) {
    
    window.webkit.messageHandlers.JSUseOCFunctionName_test1.postMessage(person);
}
    
}

function button3Click() {
    //        alert('JSUseOCFunctionName_test1');
    window.webkit.messageHandlers.JSUseOCFunctionName_test2.postMessage('tom');
}

function buttonClick() {
    //    parameter 是参数,
    //ocTestName oc 需要js注入的名称
    alert("A");
    window.webkit.messageHandlers.ocTestName.postMessage('jim');
    
}

//全局变量
var globalPerson = new Person() //用一个构造函数来创建了对象


// 定义对象
function Person(name, age) { //创建一个person的函数
    this.name = name; //此处的this对应的是对象obj
    this.age = age
}


function payCallBack(data) {
    
    alert(data);
    
}

function iosWeixinPay() {
    
    globalPerson.name = 'tom'
    globalPerson.age = 12
    
   
    
}



