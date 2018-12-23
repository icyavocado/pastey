import axios from "axios";
import Qs from "qs";

const instance = axios.create({
  baseURL: "http://localhost:5000/api"
});

const api = {
  async get(url, cb) {
    let result = await instance.get(url);
    cb(result);
  },
  async post(payload, cb) {
    let result = await instance.post("/", Qs.stringify(payload));
    cb(result);
  }
};

export default api;
