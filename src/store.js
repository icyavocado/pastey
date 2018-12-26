import Vue from "vue";
import Vuex from "vuex";

import api from "./api/PasteyAPI";
const dancer_config = require("../config.json");

import router from "./router";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    ...dancer_config,
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
    reset({ commit, getters }) {
      if (getters.isNew) throw Error("Couldn't reset since isNew is true");
      commit("set", { name: "name", value: "" });
      commit("set", { name: "value", value: "" });
      router.push("/");
    },
    save({ state, commit, getters }) {
      if (!getters.isSaveable)
        throw Error("Couldn't save since isSaveable is false");
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
          });
          router.push({
            path: result.data.format
              ? `/${result.data.name}.${result.data.format}`
              : `/${result.data.name}`
          });
        }
      );
    },
    duplicate({ commit, getters }) {
      if (!getters.isDupable)
        throw Error("Couldn't duplicate since isDupable is false");
      commit("set", { name: "name", value: "" });
      router.push("/");
    },
    raw({ state, getters }) {
      if (!getters.isDupable)
        throw Error("Couldn't get raw value since there is no value");
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
