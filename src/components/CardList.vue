<template>
  <div>
    <div class="header">
      <h1 style="text-align:center;padding:0;">All books</h1>
    </div>
    <ul>
      <li v-for="item in data" v-bind:key="item.value">
        <div class="card" v-if="item.status.status == 'pending'">
          <div class="row">
            <div class="col-4 col-s-4">
              <p>
                <img id="card-boot-image" class="img-item" :src="item.imgUrl" />
              </p>
            </div>
            <div class="col-8 col-s-8">
              <h3 id="card-book-title" class="item-title">{{ item.title }}</h3>
              <h4 id="card-book-author">By {{ item.author }} ({{item.format}})</h4>
              <h1 id="card-book-price" style="color:red;">${{item.price}}</h1>

              <h5>
                Add by:
                <span
                  id="card-book-order-name"
                  style="font-weight: normal;"
                >{{ item.user.name }}</span>
              </h5>
              <h5>
                Order Date:
                <span
                  id="card-boot-order-date"
                  style="font-weight: normal;"
                >{{item.orderDate| formatDate}}</span>
              </h5>
              <div class="btn">
                  <button
                class="button-add"
                v-on:click="orderModal=true;itemId = item.id"
                type="button"
                id="card-show-list-button"
              >Show Order ({{item.count}})</button>
              <button
                id="card-plus-button"
                class="button-add btn-plus"
                v-on:click="plusModal = true;itemId = item.id"
              >PLUS 1</button>
              </div>
              
            </div>
          </div>
        </div>
      </li>
    </ul>
   
      <OrderModal v-if="orderModal" @close="orderModal = false" :itemId="itemId" />
      <PlusModal
        v-if="plusModal"
        @close="plusModal = false"
        @refresh="getItemData"
        :itemId="itemId"
      />
  
  </div>
</template>

<script>
import OrderModal from "./modal/OrderModal.vue";
import PlusModal from "./modal/PlusModal.vue";
export default {
  components: {
    PlusModal,
    OrderModal
  },
  data() {
    return {
      itemId: null,
      data: null,
      responses: null,
      showModal: false,
      orderList: null,
      urlInput: null,
      showResult: false,
      results: null,
      orderModal: false,
      date: null,
      waiting: false,
      plusModal: false
    };
  },
  mounted: function() {
    this.getItemData();
  },
  methods: {
    getItemData: function() {
      this.$http.get(process.env.VUE_APP_API + "/items").then(response => {
        this.data = response.body;
        window.console.log(this.data);
      });
    },

    getOrderData: function(itemId) {
      this.$http
        .get(process.env.VUE_APP_API + "/reserves/" + itemId)
        .then(response => {
          this.orderList = response.body;
          window.console.log(this.orderList);
        });
      this.orderModal = true;
    },
    cancel: function() {
      this.showModal = false;
      this.showResult = null;
      this.urlInput = null;
    },
    plus: function(itemId) {
      this.$http
        .post(
          process.env.VUE_APP_API +
            "/reserves/" +
            this.userId +
            "/" +
            itemId +
            "/" +
            this.count
        )
        .then(response => {
          this.responses = response.body;
          this.getItemData();
        });
    },
    exitOrderModal: function() {
      this.orderModal = false;
      this.orderList = null;
    }
  }
};
</script>

<style scoped>
[class*="col-"] {
  padding: 0 15px;
}

ul {
  margin-top: 0px;
  padding: 0px;
}

p {
  text-align: center;
}

.img-item {
  position: relative;
  margin: auto auto;
  max-width: 230px;
  max-height: 240px;
}

.header {
  margin-top: 50px;
  font-weight: 900;
}

.item-title {
  white-space: nowrap;
  width: 90%;
  overflow: hidden;
  text-overflow: ellipsis;
}

.button-add {
  border-radius: 5px;
  border: 1px solid #d9d9d9;
  padding: 8px 0px;
  margin-bottom: 30px;
  color: #515151;
  text-transform: uppercase;
  width: 125px;
  margin-right: 5px;
  transition: all 0.3s ease;
  font-size: 10px;
  font-weight: 500;
  box-shadow: 0 0 15px 0 0;
  background: white;
}

.button-add:hover {
  box-shadow: 0 0 10px 0 rgba(0, 0, 0, 0.1);
  cursor: pointer;
}

.btn{
    text-align: center;
}

.btn-plus {
  background-color: #1498d5;
  color: white;
  width: 90px;
}

.modal {
  padding: 0 30px 30px;
  width: 90%;
  border-radius: 10px;
  position: fixed;
  transform: translate(-50%, -50%);
  z-index: 9998;
  background: white;
  margin: 0 auto;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  box-shadow: 0 2px 5px 0 rgba(0, 0, 0, 0.16), 0 2px 10px 0 rgba(0, 0, 0, 0.12);
  transition: all 0.3s;
}

.modal:hover {
  box-shadow: 0 8px 17px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
}

.manage {
  margin: auto;
  left: 50%;
}

.input {
  margin: 10px;
}

@media only screen and (min-width: 768px) {
  .header {
    margin-top: 100px;
  }
  ul {
    margin-top: 0px;
  }
  .card {
    width: 700px;
  }
  .modal {
    width: 300px;
  }
  .img-item {
    position: relative;
    margin: auto auto;
    max-width: 200px;
    max-height: 240px;
  }
  .btn{
      text-align:left;
  }
}
</style>
