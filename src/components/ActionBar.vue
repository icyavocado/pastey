<template>
  <div>
    <div>
      <button @click="reset" :disabled="isNew">[ New ]</button>
    </div>
    <div>
      <button @click="save" :disabled="!isSaveable">[ Save ]</button>
    </div>
    <div>
      <button @click="duplicate" :disabled="!isDupable">[ Duplicate ]</button>
    </div>
    <div>
      <button @click="raw" :disabled="!isDupable">[ Raw Text ]</button>
    </div>
  </div>
</template>

<script>
import { mapState, mapGetters, mapMutations, mapActions } from "vuex";
export default {
  methods: {
    ...mapMutations(["set"]),
    ...mapActions(["reset", "save", "duplicate", "raw"])
  },
  computed: {
    ...mapState(["name", "format", "type", "value"]),
    ...mapGetters(["isNew", "isSaveable", "isDupable"])
  }
};
</script>

<style>
</style>
