<template>
  <div class="home">
    <codemirror :options="cmOptions" v-model="code"></codemirror>
    <header class="control">
      <logo/>
      <action-bar/>
    </header>
  </div>
</template>

<script>
import { codemirror } from "vue-codemirror";
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
      localOp: {
        tabSize: 2,
        mode: "text/javascript",
        theme: "blackboard",
        lineNumbers: true,
        line: true,
        readOnly: this.isDupable
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
        return this.localOp;
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
