<template>
  <modal @close="$emit('close')">
    <div slot="body">
      <div class="result-modal">
        <h3>Order Summary</h3>

        <div style="  border-bottom: 2px solid #efefef; margin-bottom:15px;"></div>

        <h4>Items Cost</h4>

        <input
          type="number"
          id="result-modal-items-cost"
          v-model="cost"
          placeholder="Please fill only item total cost"
        />
        <h4>Shipping Charge</h4>
        <input
          type="number"
          id="result-modal-shipping-charge"
          v-model="charge"
          placeholder="Please fill only shipping total cost"
        />

        <button class="plus-btn" id="result-modal-submit-btn" v-on:click="updateOrder">confirm</button>
        <button
          class="plus-btn cancel-btn"
          id="result-modal-cancel-btn"
          v-on:click="$emit('close')"
        >cancel</button>
      </div>
    </div>
  </modal>
</template>

<script>
import { UpdateOrder } from "../../service";
export default {
  data() {
    return {
      cost: null,
      charge: null
    };
  },
  methods: {
    updateOrder: function() {
      UpdateOrder(this.$route.params.id, this.cost, this.charge).then(() => {
        this.clearModalData();
        this.$emit("refresh");
        this.$emit("close");
      });
    },
    clearModalData: function() {
      this.cost = 0.0;
      this.charge = 0.0;
    }
  }
};
</script>

<style scoped>
h4 {
  margin: 10px 0 2px;
}

input {
  width: 100%;
  height: 30px;
  padding: 0 20px;
  margin: 8px 0;
  box-sizing: border-box;
  box-shadow: 0px 0px 1px 0px rgba(0, 0, 0, 0.75);
  border: 0;
  border-radius: 4px;
}

.plus-btn {
  cursor: pointer;
  background-color: #1498d5;
  border-radius: 5px;
  border: 0;
  padding: 8px;
  margin: 10px 0 10px 10px;
  color: white;
  text-transform: uppercase;
  width: 90px;
  font-family: inherit;
  float: right;
}

.cancel-btn {
  color: white;
  width: 88px;
  background-color: #f55246;
}
</style>