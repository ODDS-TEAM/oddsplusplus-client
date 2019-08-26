<template>
  <modal @close="$emit('close')">
    <div slot="body">
      <div class="result-modal">
        <h3>Total Costs</h3>
        <input type="text" v-model="cost" />
        <h3>Shipping Charge</h3>
        <input type="text" v-model="charge" />
        <button class="plus-btn" v-on:click="updateOrder">confirm</button>
        <button class="plus-btn cancel-btn" v-on:click="$emit('close')">cancel</button>
      </div>
    </div>
  </modal>
</template>
<script>
export default {
  data() {
    return {
      itemId: null,
      summary: {
        item: {}
      },
      userId: null,
      modal: false,
      cost: null,
      charge: null,
      responses: null
    };
  },
  methods: {
    updateOrder: function() {
      this.$http
        .patch(
          process.env.VUE_APP_API +
            "/updateOrder/" +
            this.$route.params.id +
            "/" +
            this.cost +
            "/" +
            this.charge
        )
        .then(response => {
          this.clearModalData();
          this.$emit("refreshMyItem");
          this.responses = response.body;
        });
    },
    clearModalData: function() {
      this.modal = false;
      this.cost = 0.0;
      this.charge = 0.0;
    }
  }
};
</script>
<style scoped>
</style>