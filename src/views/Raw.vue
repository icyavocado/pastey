<template>
  <div class="raw">{{ value }}</div>
</template>

<script>
import { mapMutations, mapState, mapActions } from "vuex";

export default {
  name: "Raw",
  methods: {
    ...mapMutations(["set"]),
    ...mapActions(["getData"])
  },
  computed: {
    ...mapState(["name", "value"])
  }
};
</script>
