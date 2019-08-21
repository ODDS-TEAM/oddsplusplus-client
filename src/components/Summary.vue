<template>
  <div class="card">
    <div class="row">
      <div class="col-4 prod-detail" style>
        <p>
          <img id="card-boot-image" class="img-item" :src="detail.imgUrl" />
        </p>
        <h3>{{detail.title}} ({{detail.format}})</h3>
        <h4>by {{detail.author}}</h4>
        <h1 style="color: red">$ {{detail.price}}</h1>
        <h5>Order date: {{detail.orderDate| formatDate}}</h5>
      </div>
      <div class="col-8 summary-detail">
        <table style="height:110px;width: 100%; margin:10px 0; border-bottom: 2px solid #efefef;">
          <tr>
            <h2 class="p-20-h p-20-t " >Qty : {{detail.count}}</h2>
          </tr>
          <tr>
            <h3 class="p-20-h p-20-t ">Total price : ${{detail.cost}}</h3>
          </tr>
        </table>
        <table style="width: 100%;margin: 20px 0 0px;overflow-x:auto;">
          <tr>
            <th class="p-20-h" style="width:80%;">Name</th>
            <th class="p-20-h" style="width:20%;">Qty</th>
          </tr>
          <tr v-for="name in names" :key="name">
            <td class="p-20-h  p-20-t">
              <img
                src="https://icon-library.net/images/my-profile-icon-png/my-profile-icon-png-3.jpg"
                style="max-width: 20px"
              />
              {{name}}
            </td>
            <td class="p-20-h  p-20-t" style="color: red; text-align:left">1</td>
          </tr>
        </table>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ["itemid"],
  data() {
    return {
      itemId: null,
      detail: {},
      user: {},
      orderList: {},
      names: ["Sivaroot Chuncharoen", "Pornpavit Sanusit", "Pitchayut CheeseJa","Anupong Chaisawan","Sivaroot Chuncharoen", "Pornpavit Sanusit", "Pitchayut CheeseJa","Anupong Chaisawan"]
    };
  },
  mounted: function() {
    if (typeof this.$route.params.id === "undefined") {
      this.$router.push("/myitem");
    }
    this.getUserData();
    this.getItemData();
    this.getItemOrder();
  },
  methods: {
    getUserData: function() {
      this.$http
        .get(process.env.VUE_APP_API + "/users/Cheese")
        .then(response => {
          this.user = response.body;
          window.console.log("User Data=====>", this.user);
        });
    },
    getItemData: function() {
      this.$http
        .get(process.env.VUE_APP_API + "/items/" + this.$route.params.id)
        .then(response => {
          this.detail = response.body;
          window.console.log("Item Data=====>", this.detail);
        });
    },
    getItemOrder: function() {
      this.$http
        .get(
          process.env.VUE_APP_API + "/reserves/items/" + this.$route.params.id
        )
        .then(response => {
          this.orderList = response.body;
          window.console.log("Item Order=====>", this.orderList);
        });
    }
  }
};
</script>

<style scoped>

.p-20-h {
  padding: 0 20px;
}
.p-20-t {
  padding-top: 10px;
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
  .prod-detail {
    padding: 20px;
    border-bottom: none;
  }
  .col-8 {
    border-left: 2px solid #efefef;
  }
}
</style>