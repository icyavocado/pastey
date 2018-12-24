<template>
  <div class="home">
    <codemirror ref="codeInstance" :options="cmOptions" v-model="code"></codemirror>
    <header class="control">
      <logo/>
      <action-bar/>
    </header>
  </div>
</template>

<script>
import { codemirror } from "vue-codemirror";
import CodeMirror from "codemirror";
window.CodeMirror = CodeMirror;
import "codemirror/mode/meta.js";

import "codemirror/lib/codemirror.css";
import "codemirror/theme/blackboard.css";
import "codemirror/mode/javascript/javascript.js";

import "../css/main.css";
import ActionBar from "@/components/ActionBar";
import Logo from "@/components/Logo";
import { mapMutations, mapState, mapGetters, mapActions } from "vuex";

export default {
  name: "Home",
  components: {
    codemirror,
    ActionBar,
    Logo
  },
  data() {
    return {
      cdn: "https://cdn.jsdelivr.net/npm/codemirror@5.42.2/mode",
      localOp: {
        tabSize: 2,
        theme: "blackboard",
        lineNumbers: true,
        lineWrapping: true,
        line: true
      }
    };
  },
  methods: {
    ...mapMutations(["set"]),
    ...mapActions(["getData"])
  },
  computed: {
    ...mapState(["name", "value", "format"]),
    ...mapGetters(["isDupable"]),
    cmOptions: {
      get() {
        return {
          ...this.localOp,
          readOnly: this.isDupable,
          mode: this.format ? this.format : "text/javascript"
        };
      },
      set(newValue) {
        this.localOp = newValue;
      }
    },
    code: {
      get() {
        return this.value;
      },
      set(newValue) {
        this.set({ name: "value", value: newValue });
      }
    }
  },
  mounted() {
    if (this.format) {
      const mode = CodeMirror.findModeByExtension(this.format).mode;
      console.log(mode);
      let recaptchaScript = document.createElement("script");
      recaptchaScript.setAttribute("src", `${this.cdn}/${mode}/${mode}.js`);
      document.head.appendChild(recaptchaScript);
    }
  }
};
</script>
