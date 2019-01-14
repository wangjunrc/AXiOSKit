function showAler() {
    alert(2);
//    iosWeixinPay();
}
function showAler2() {
    alert(4);
    //    iosWeixinPay();
}

function buttonClick() {
    //    parameter 是参数,
    //ocTestName oc 需要js注入的名称
    alert("A");
    window.webkit.messageHandlers.ocTestName.postMessage('jim');
    
}


function jsBridge(callback) {
    if (window.WebViewJavascriptBridge) {
        return callback(WebViewJavascriptBridge);
    }
    if (window.WVJBCallbacks) {
        return window.WVJBCallbacks.push(callback);
    }
    window.WVJBCallbacks = [callback];
    var WVJBIframe = document.createElement('iframe');
    WVJBIframe.style.display = 'none';
    WVJBIframe.src = 'wvjbscheme://__BRIDGE_LOADED__';
    document.documentElement.appendChild(WVJBIframe);
    setTimeout(function () {
               document.documentElement.removeChild(WVJBIframe)
               },
               0)
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
    
    
    jsBridge(function (bridge) {
             
             //js 调用oc
             
             bridge.callHandler('iosWeixinPay', globalPerson,
                                function responseCallback(responseData) {
                                
                                
                                });
             
             //oc 调用js
             bridge.registerHandler('payCallBack',
                                    function (data, responseCallback) {
                                    payCallBack(data);
                                    })
             
             });
}

function iosAlipayPay() {
    jsBridge(function (bridge) {
             
             //js 调用oc 内部oc 代码直接返回 responseData
             bridge.callHandler('iosAlipayPay', alipayPayParams,
                                function responseCallback(responseData) {
                                
                                payCallBack(responseData);
                                })
             });
}
