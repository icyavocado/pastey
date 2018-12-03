onmessage = function(event) {
  importScripts(
    "//cdn.jsdelivr.net/gh/highlightjs/cdn-release@9.13.1/build/highlight.min.js"
  );
  var result = self.hljs.highlightAuto(event.data);
  postMessage(result.value);
};
