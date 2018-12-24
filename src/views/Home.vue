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
      localMode: "javascript",
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
    ...mapActions(["getData"]),
    loadMode() {
      let mode = "";

      if (!mode) {
        let findModeByExtension = CodeMirror.findModeByExtension(this.format);
        if (findModeByExtension) mode = findModeByExtension.mode;
      }

      if (!mode) {
        let findModeByFileName = CodeMirror.findModeByFileName(
          `${this.name}.${this.format}`
        );
        if (findModeByFileName) mode = findModeByFileName.mode;
      }

      if (!mode) {
        let findModeByName = CodeMirror.findModeByName(this.format);
        if (findModeByName) mode = findModeByName.mode;
      }

      if (!mode) mode = "javascript";

      this.cmOptions = {
        ...this.cmOptions,
        mode
      };

      let recaptchaScript = document.createElement("script");
      recaptchaScript.setAttribute("src", `${this.cdn}/${mode}/${mode}.js`);
      document.head.appendChild(recaptchaScript);
    }
  },
  computed: {
    ...mapState(["name", "value", "format"]),
    ...mapGetters(["isDupable"]),
    cmOptions: {
      get() {
        return {
          ...this.localOp,
          readOnly: this.isDupable,
          mode: this.localMode
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
    if (this.format) this.loadMode();
  }
};
</script>
