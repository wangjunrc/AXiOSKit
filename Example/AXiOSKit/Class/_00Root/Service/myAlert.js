function myAlert() {
    var metaTags = document.getElementsByTagName('meta');
    var content = metaTags[1].getAttribute('content');
    alert(content);
}
window.onload = function () {
    myAlert();
};
