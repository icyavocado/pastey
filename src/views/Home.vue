<template>
  <div class="home">
    <global-events
      @keydown.ctrl.alt.78.prevent="reset"
      @keydown.ctrl.83.prevent="save"
      @keydown.ctrl.68.prevent="duplicate"
      @keydown.ctrl.82.prevent="raw"
    />
    <codemirror ref="codeInstance" :options="cmOptions" v-model="code"></codemirror>
    <header class="control">
      <logo/>
      <action-bar/>
    </header>
  </div>
</template>

<script>
import { mapMutations, mapState, mapGetters, mapActions } from "vuex";

import { codemirror } from "vue-codemirror";
import CodeMirror from "codemirror";
import "codemirror/lib/codemirror.css";
import "codemirror/theme/blackboard.css";
import "codemirror/mode/meta.js";
import "codemirror/mode/javascript/javascript.js";
window.CodeMirror = CodeMirror;

import GlobalEvents from "vue-global-events";

import "../css/main.css";

import ActionBar from "@/components/ActionBar";
import Logo from "@/components/Logo";

export default {
  name: "Home",
  components: {
    codemirror,
    ActionBar,
    Logo,
    GlobalEvents
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
    ...mapActions(["getData", "reset", "save", "duplicate", "raw"]),
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
