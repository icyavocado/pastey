import Vue from "vue";
import Router from "vue-router";
import Home from "./views/Home.vue";
import Raw from "./views/Raw.vue";
import store from "./store";

Vue.use(Router);

export default new Router({
  mode: "history",
  base: process.env.BASE_URL,
  routes: [
    {
      path: "/raw/:name(\\w+)?(.)?:format(\\w+)?",
      name: "raw",
      component: Raw,
      beforeEnter
    },
    {
      path: "(/)?:name(\\w+)?(.)?:format(\\w+)?",
      name: "home",
      component: Home,
      beforeEnter
    }
  ]
});

function beforeEnter(to, from, next) {
  let data = {
    name: to.params.name ? to.params.name : "",
    format: to.params.format ? to.params.format : "",
    type: to.params.type ? to.params.type : ""
  };
  Object.keys(data).forEach(key => {
    store.commit("set", {
      name: key,
      value: data[key]
    });
  });
  if (store.state.name) store.dispatch("getData");
  next();
}
