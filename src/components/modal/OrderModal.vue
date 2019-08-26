<template>
  <modal @close="$emit('close')">
    <div slot="body">
      <h3>Order List</h3>
      <div style="  border-bottom: 2px solid #efefef; margin-bottom:10px;"></div>
      <table style="width: 100%;margin: 20px 0 0px;overflow-x:auto;">
        <tr v-for="order in orderList" :key="order.id">
          <td>
            <div style="width:40px;height:40px;overflow:hidden;border-radius:50%">
              <img :src="order.user.imgURL" />
            </div>
          </td>
          <td class="p-20-h p-20-t" style="text-align:left;">{{order.user.name}}</td>
          <td class="p-20-h p-20-t" style="color: red; text-align:center">{{order.count}}</td>
        </tr>
      </table>
    </div>
  </modal>
</template>

<script>
export default {
  props: {
    itemId: {
      type: String,
      default() {
        return "";
      }
    }
  },
  beforeMount() {
    this.itemId = this.itemId; // save props data to itself's data and deal with it
  },
  data() {
    return {
      orderList: null
    };
  },
  mounted: function() {
    window.console.log(this.itemId);
    this.getOrderData(this.itemId);
  },
  methods: {
    getOrderData: function(itemId) {
      this.$http
        .get(process.env.VUE_APP_API + "/reserves/" + itemId)
        .then(response => {
          this.orderList = response.body;
          window.console.log(this.orderList);
        });
      this.orderModal = true;
    }
  }
};
</script>

<style scoped>
li {
  margin-bottom: 10px;
}
</style>