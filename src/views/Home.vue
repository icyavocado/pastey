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
  methods: {
    ...mapMutations(["set"]),
    ...mapActions(["getData"])
  },
  computed: {
    ...mapState(["name", "value"]),
    ...mapGetters(["isDupable"]),
    cmOptions() {
      return {
        // codemirror options
        tabSize: 2,
        mode: "text/javascript",
        theme: "blackboard",
        lineNumbers: true,
        line: true,
        readOnly: this.isDupable
      };
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
