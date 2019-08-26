<template>
  <div class="card">
    <div class="row">
      <div class="col-4 prod-detail" style>
        <p>
          <img id="card-boot-image" class="img-item" :src="summary.item.imgUrl" />
        </p>
        <h3>{{summary.item.title}} ({{summary.item.format}})</h3>
        <h4>by {{summary.item.author}}</h4>
        <h1 style="color: red">$ {{summary.item.price}}</h1>
        <h5>Order date: {{summary.item.orderDate| formatDate}}</h5>
      </div>
      <div class="col-8 summary-detail">
        <table style="height:110px;width: 100%; margin:10px 0; border-bottom: 2px solid #efefef;">
          <button class="btn-order btn-sum" v-on:click="modal = true">Order Update</button>
          <button class="btn-order" v-on:click="goToAmazon">Go to Amazon</button>
          <tr>
            <h2 class="p-20-t">Qty : {{summary.item.count}}</h2>
          </tr>
          <tr>
            <h3 class="p-20-t">Total price : ${{summary.item.cost}}</h3>
          </tr>
          <tr>
            <h3 class="p-20-t">Total charge : ${{summary.item.shippingCharge}}</h3>
          </tr>
        </table>
        <thead>
          <tbody>
        <table style="width: 100%;margin: 20px 0 0px;overflow-x:auto;">
          <tr>
            <th class="p-20-h" style="width:80%;">Name</th>
            <th class="p-20-h" style="width:20%; text-align:center">Qty</th>
            <th class="p-20-h" style="width:20%;">Costs($)</th>
            <th class="p-20-h" style="width:20%;">Charge($)</th>
          </tr>
          <tr v-for="order in summary.order" :key="order.id">
            <td class="p-20-h p-20-t">
              <p style="text-align:left; margin : 0">
                <img
                  src="https://icon-library.net/images/my-profile-icon-png/my-profile-icon-png-3.jpg"
                  style="max-width: 20px "
                />
                 {{order.user.name}}
              </p>
            </td>
            <td class="p-20-h p-20-t" style="color: red; text-align:center">{{order.count}}</td>
            <td class="p-20-h p-20-t" style="color: red; text-align:center">{{order.cost}}</td>
            <td class="p-20-h p-20-t" style="color: red; text-align:center">{{order.shippingCharge}}</td>
          </tr>
        </table>
          </tbody>
        </thead>
      </div>
    </div>
    
    <ResultModal @close="modal=false" @refresh="getItemData" v-if="modal"/>
  </div>
</template>

<script>
import ResultModal from './modal/ResultModal.vue'
export default {
  components: {
    ResultModal
  },
  props: ["itemid"],
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
  mounted: function() {
    this.userId = localStorage.getItem("userId");
    if (typeof this.$route.params.id === "undefined") {
      this.$router.push("/myitem");
    }
    this.getItemData();
  },
  methods: {
    getItemData: function() {
      this.$http
        .get(process.env.VUE_APP_API + "/reserves/sum/" + this.$route.params.id)
        .then(response => {
          this.summary = response.body;
        });
    },
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
    },
    goToAmazon: function() {
      window.open(this.summary.item.url, "_blank");
    }
  }
};
</script>

<style scoped>
thead {
    display: inline-block;
    width: 100%;
}
tbody {
    height: 150px;
    display: inline-block;
    width: 100%;
    overflow: auto;
}
.p-20-h {
  padding: 0 10px 0 10px;
  font-size: 12px;
}
.p-20-t {
  padding: 10px 10px 0 10px;
}
.prod-detail {
  padding: 20px;
  border-bottom: 2px solid #efefef;
}
.card {
  margin-top: 100px;
}
th {
  text-align: left;
}
p {
  text-align: center;
}
h2,
h3 {
  margin: 0;
}
.img-item {
  max-height: 240px;
}
@media only screen and (min-width: 768px) {
  .p-20-h {
    font-size: 16px;
  }

  tbody {
    height: 290px;
    display: inline-block;
    width: 100%;
    overflow: auto;
}

  .prod-detail {
    padding: 20px;
    border-bottom: none;
    border-right: 2px solid #efefef;
  }
}

.btn-order {
  border-radius: 5px;
  border: 1px solid #d9d9d9;
  padding: 8px 0px;
  color: #515151;
  text-transform: uppercase;
  width: 125px;
  font-family: inherit;
  margin-right: 5px;
  transition: all 0.3s ease;
  font-weight: 500;
  box-shadow: 0 0 15px 0 0;
  float: right;
  margin-top: 10px;
}

.btn-order:hover {
  box-shadow: 0 0 10px 0 rgba(0, 0, 0, 0.1);
  cursor: pointer;
}

.btn-sum {
  border: 0;
  background-color: #1498d5;
  color: white;
  width: 120px;
  margin-right: 20px;
}

.modal {
  padding: 0px 20px 0px 20px;
  width: 250px;
  height: 200px;
  border-radius: 10px;
  position: fixed;
  transform: translate(-50%, -50%);
  z-index: 1;
  background: white;
  margin: 0 auto;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  box-shadow: 0 2px 5px 0 rgba(0, 0, 0, 0.16), 0 2px 10px 0 rgba(0, 0, 0, 0.12);
  transition: all 0.3s;
}
</style>