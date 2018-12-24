import axios from "axios";

const instance = axios.create({
  baseURL: "http://localhost:5000/api"
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

    let result = await instance.post("/", value);
    cb(result);
  }
};

export default api;
