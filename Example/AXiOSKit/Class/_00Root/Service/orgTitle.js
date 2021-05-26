window.onload = function() {
    function orgTitle() {
        var metaTags = document.getElementsByTagName('meta');
        var content = '';
        for (var i = 0; i < metaTags.length; i++) {
            if (metaTags[i].getAttribute('property') == 'og:title') {
                content = metaTags[i].getAttribute('content');
                break;
            }
        }
        alert(content);
        window.webkit.messageHandlers.orgTitle.postMessage(content);
    }
    orgTitle();
};
