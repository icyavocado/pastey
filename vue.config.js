module.exports = {
  outputDir: "public",

  css: {
    sourceMap: true
  },

  chainWebpack: config => {
    config.plugin("html").tap(args => {
      args[0].template = "src/assets/template/index.html";
      return args;
    });
    config.plugin("copy").tap(args => {
      args[0][0].from = "/icyavocado/pastey/public-vue";
      return args;
    });
  },

  baseUrl: undefined,
  assetsDir: undefined,
  runtimeCompiler: undefined,
  productionSourceMap: undefined,
  parallel: undefined
};
