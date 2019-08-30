<template></template>

<script>
import { emit } from "cluster";
export default {
  mounted: function() {
    this.$emit("closeNav");
    window.localStorage.clear();
    this.$nextTick(() => {
      window.location.href = "https://api-dev.odds.team/logout";
    });
  }
};
</script>

<style>
</style>