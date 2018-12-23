import Vue from "vue";
import Vuex from "vuex";

import api from "./api/PasteyAPI";
import router from "./router";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    value: "",
    name: "",
    format: "",
    type: ""
  },
  mutations: {
    set(state, { name, value }) {
      state[name] = value;
    }
  },
  actions: {
    getData({ state, commit }) {
      api.get("/" + state.name, result => {
        Object.keys(result.data).forEach(key => {
          commit("set", {
            name: key,
            value: result.data[key]
          });
        });
      });
    },
    reset({ commit }) {
      commit("set", { name: "name", value: "" });
      commit("set", { name: "value", value: "" });
      router.push("/");
    },
    save({ state, commit }) {
      api.post(
        {
          value: state.value
        },
        result => {
          Object.keys(result.data).forEach(key => {
            commit("set", {
              name: key,
              value: result.data[key]
            });
            router.push("/" + result.data.name);
          });
        }
      );
    },
    duplicate({ commit }) {
      commit("set", { name: "name", value: "" });
      router.push("/");
    },
    raw({ state }) {
      router.push({
        path: "/raw/" + state.name
      });
    }
  },
  getters: {
    isNew(state) {
      return state.name === "";
    },
    isSaveable(state) {
      return (
        (state.name === "" || typeof state.name === "undefined") &&
        state.value !== ""
      );
    },
    isDupable(state) {
      return state.name !== "" && state.value !== "";
    }
  }
});
