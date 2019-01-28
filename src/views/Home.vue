<template>
  <div class="home">
    <global-events
      @keydown.ctrl.alt.78.prevent="reset"
      @keydown.ctrl.83.prevent="save"
      @keydown.ctrl.68.prevent="duplicate"
      @keydown.ctrl.82.prevent="raw"
    />
    <monaco-editor class="editor" v-model="code" :options="options"></monaco-editor>
    <header class="control">
      <logo/>
      <action-bar/>
    </header>
  </div>
</template>

<script>
import { mapMutations, mapState, mapGetters, mapActions } from "vuex";

import MonacoEditor from "vue-monaco";
import GlobalEvents from "vue-global-events";

import "../css/main.css";

import ActionBar from "@/components/ActionBar";
import Logo from "@/components/Logo";

export default {
  name: "Home",
  components: {
    MonacoEditor,
    ActionBar,
    Logo,
    GlobalEvents
  },
  data() {
    return {};
  },
  methods: {
    ...mapMutations(["set"]),
    ...mapActions(["getData", "reset", "save", "duplicate", "raw"])
  },
  computed: {
    ...mapState(["name", "value", "format"]),
    ...mapGetters(["isDupable"]),
    options: {
      get() {
        return {
          minimap: {
            enabled: true
          },
          language: "javascript",
          roundedSelection: false,
          scrollBeyondLastLine: false,
          matchBrackets: true,
          readOnly: false,
          theme: "vs-dark"
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
  }
};
</script>
