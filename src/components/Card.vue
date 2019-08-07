<template>
  <div>
    <div v-for="item in items" v-bind:key="item.value">
      <div class="card">
        <div class="img">
          <img class="img-item" :src="item.imgUrl" />
        </div>
        <div class="data">
          <div>
            <span class="content">Title :</span>
            <span>{{item.title}}</span>
          </div>
          <div>
            <span class="content">Author :</span>
            <span>{{item.author}}</span>
          </div>
          <div>
            <span class="content">Price :</span>
            <span>${{item.price}}</span>
          </div>
          <div>
            <span class="content">By :</span>
            <span>{{item.user.name}}</span>
          </div>
          <div>
            <span class="content">Order Date :</span>
            <span>{{item.orderDate| formatDate}}</span>
          </div>
          <button class="button" v-on:click="getOrderData(item.id)" type="button">Order ({{item.count}})</button>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      items: null,
      orders: null
    };
  },
  mounted: function() {
    this.$http.get("http://127.0.0.1:8080/items").then(response => {
      this.items = response.body;
      window.console.log(this.items);
    });
  },
  methods: {
    getOrderData(itemId) {
      this.$http
        .get("http://127.0.0.1:8080/reserve/" + itemId)
        .then(response => {
          this.orders = response.body;
          window.console.log(this.orders);
        });
    }
  }
};
</script>
<style scoped>
.card {
  width: 60%;
  height: 250px;
  margin-left: 20%;
  margin-top: 50px;
  box-shadow: 5px 5px 4px 5px #dadada;
}
.img {
  height: 100%;
  width: 20%;
  float: left;
}
.data {
  height: 100%;
  display: block;
}
.content {
  margin-top: 20px;
  margin-left: 20px;
  display: inline-block;
}
.img-item {
  height: 100%;
  width: auto;
}
.button {
  margin-top: 20px;
  margin-left: 20px;
}
</style>

