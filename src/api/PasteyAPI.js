import axios from "axios";
import Qs from "qs";

const instance = axios.create({
  baseURL: "/api"
});

const api = {
  async get(url, cb) {
    let result = await instance.get(url);
    cb(result);
  },
  async post(payload, cb) {
    let value = "";
    if (typeof payload === "string") {
      value = payload
        .replace(/&/g, "&amp;")
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&apos;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;");
    } else {
      value = payload;
    }

    let result = await instance.post("/", Qs.stringify(value));
    cb(result);
  }
};

export default api;
