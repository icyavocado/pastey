<template>
  <a href="/about.md" class="logo">
    <h2>[ {{ app_name }} ]</h2>
  </a>
</template>

<script>
import { mapState } from "vuex";

export default {
  computed: {
    ...mapState(["app_name"])
  }
};
</script>
