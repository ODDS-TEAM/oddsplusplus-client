<template>
  <h3>Please wait while redirecting...</h3>
</template>

<script>
export default {
    mounted: function() {
        this.$emit("closeNav");
    }
}
</script>

<style scoped>
h3{
    width: 100%;
    text-align: center;
    position: fixed;
    transform: translate(-50%,-50%);
    top: 45%;
    left: 50%;
    font-size: 21px;
}

</style>