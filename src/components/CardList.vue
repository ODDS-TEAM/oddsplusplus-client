<template>
  <div>
    <ul>
      <li v-for="item in data" v-bind:key="item.value">
        <div class="card">
          <div class="row">
            <div class="col-4 col-s-4">
              <p>
                <img id="card-boot-image" class="img-item" :src="item.imgUrl" />
              </p>
            </div>
            <div class="col-8 col-s-8">
              <h3 id="card-book-title" class="item-title">{{ item.title }}</h3>
              <h4 id="card-book-author">By {{ item.author }}  ({{item.format}})</h4>
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
              <button
                class="button-add"
                v-on:click="getOrderData(item.id)"
                type="button"
                id="card-show-list-button"
              >Show Order ({{item.count}})</button>
              <button
                id="card-plus-button"
                class="button-add btn-plus"
                v-on:click="getOrderCount(item.id)"
              >PLUS 1</button>
            </div>
          </div>
        </div>
      </li>
    </ul>

    <div class="modal" v-if="orderModal">
      <a
        style="position: absolute; top: 7px; right: 15px; color: #9d9d9d;;cursor: pointer;"
        v-on:click="exitOrderModal"
        id="modal-cancel-2"
      >X</a>
      <h3>Order List</h3>
      <div style="  border-bottom: 2px solid #efefef; margin-bottom:10px;"></div>
      <li v-for="item in orderList" v-bind:key="item.id">
        <h4>{{item.user.name}} ({{item.count}})</h4>
      </li>
    </div>

    <div class="plus-modal" v-if="plusModal">
      <h3>X value</h3>
      <div style="  border-bottom: 2px solid #efefef;"></div>

      <table style="width:100%;">
        <tr>
          <td>
            <p>
              <button
                class="btn-count"
                :disabled="plusItem.current == 0"
                v-on:click="plusItem.current--;plusItem.send--"
              >-</button>
            </p>
          </td>
          <td>
            <h2 style="margin:0;">{{plusItem.current}}</h2>
          </td>
          <td>
            <p>
              <button class="btn-count" v-on:click="plusItem.current++;plusItem.send++">+</button>
            </p>
          </td>
        </tr>
      </table>

      <div style="  border-bottom: 2px solid #efefef;"></div>
      <button class="plus-btn" v-on:click="sendOrder" :disabled="plusItem.send == 0">confirm</button>
      <button class="plus-btn cancel-btn" v-on:click="clearPlusModalData">cancel</button>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      data: null,
      responses: null,
      showModal: false,
      orderList: null,
      urlInput: null,
      showResult: false,
      results: null,
      userId: null,
      orderModal: false,
      date: null,
      waiting: false,
      plusItem: {
        itemId: null,
        current: null,
        send: 0
      },
      plusModal: false
    };
  },
  mounted: function() {
    this.userId = localStorage.getItem("userId");
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
    },
    clearPlusModalData: function() {
      this.plusItem.send = 0;
      this.plusModal = false;
      this.plusItem.current = null;
      this.plusItem.itemId = null;
    },
    getOrderCount: function(itemId) {
      this.$http
        .get(
          process.env.VUE_APP_API +
            "/reserves/users/" +
            this.userId +
            "/" +
            itemId
        )
        .then(response => {
          this.plusItem.current = response.body;
          this.plusItem.itemId = itemId;
          this.plusModal = true;
        });
    },
    sendOrder: function() {
      this.plusModal = false;
      if (this.plusItem.send == 0) return;
      this.$http
        .post(
          process.env.VUE_APP_API +
            "/reserves/" +
            this.userId +
            "/" +
            this.plusItem.itemId +
            "/" +
            this.plusItem.send
        )
        .then(response => {
          this.clearPlusModalData();
          this.responses = response.body;
          window.console.log(this.responses);
          this.getItemData();
        });
    }
  }
};
</script>

<style scoped>
[class*="col-"] {
  padding: 0 15px;
}
ul {
  margin-top: 80px;
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
  font-family: inherit;
  margin-right: 5px;
  transition: all 0.3s ease;
  font-weight: 500;
  box-shadow: 0 0 15px 0 0;
}
.button-add:hover {
  box-shadow: 0 0 10px 0 rgba(0, 0, 0, 0.1);
  cursor: pointer;
}
.btn-plus {
  background-color: #1498d5;
  color: white;
  width: 70px;
}
.modal {
  padding: 0 30px 30px;
  width: 90%;
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
.modal:hover {
  box-shadow: 0 8px 17px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
}

.plus-modal {
  padding: 0px 20px 0px 20px;
  width: 315px;
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

.plus-btn {
  background-color: #1498d5;
  border-radius: 5px;
  border: 1px solid #d9d9d9;
  padding: 8px;
  margin: 10px 0 10px 10px;
  color: white;
  text-transform: uppercase;
  width: 90px;
  font-family: inherit;
  float: right;
}
.plus-btn:disabled {
  display: none;
}

.cancel-btn {
  color: white;
  width: 70px;
  background-color: #fa1d12;
}

.updateCount {
  float: left;
}

.manage {
  margin: auto;
  left: 50%;
}

.input {
  margin: 10px;
}
.btn-count {
  cursor: pointer;
  width: 100px;
  height: 30px;
  border: 0;
  font-size: 22px;
  border-radius: 5px;
  background-color: rgb(244, 244, 244);
}
.btn-count:hover {
  background-color: rgb(238, 238, 238);
}

@media only screen and (min-width: 768px) {
  ul {
    margin-top: 94px;
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
}
</style>
