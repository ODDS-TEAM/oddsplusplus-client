<template>
  <div>
    <div class="fab-wrapper">
      <a class="fab-button" v-on:click="showModal = true">
        <h1 style="color: white;">+</h1>
      </a>
    </div>
    <ul style="margin-top: 140px;">
      <li v-for="item in data" v-bind:key="item.value">
        <div class="card">
          <div class="grid-container">
            <div class="item1">
              <img class="img-item" :src="item.imgUrl" />
            </div>
            <div class="item2" style="text-align:left">
              <h4>{{ item.title }} ({{item.format}})</h4>
              <h5>
                Author:
                <span style="font-weight: normal;">{{ item.author }}</span>
              </h5>
              <h4 style="color:red;">${{ item.price }}</h4>
              <h5>
                Add by:
                <span style="font-weight: normal;">{{ item.user.name }}</span>
              </h5>
              <h5>
                Order Date:
                <span style="font-weight: normal;">{{item.orderDate| formatDate}}</span>
              </h5>
              <button
                class="button"
                v-on:click="getOrderData(item.id)"
                type="button"
              >Order ({{item.count}})</button>
            </div>
            <div class="item3" style="margin-top: auto; margin-bottom: auto; ">
              <button class="button" v-on:click="plus(item.id)">PLUS 1</button>
            </div>
          </div>
        </div>
      </li>
    </ul>
    <div class="modal" v-if="showModal">
      <a
        style="position: absolute; top: 7px; right: 15px; color: red;cursor: pointer;"
        v-on:click="cancel"
      >X</a>
      <div class="input-group">
        <input
          type="text"
          v-model="urlInput"
          placeholder="Please fill amazon book URL"
          v-on:change="onChange"
        />
        <label>URL</label>
      </div>
      <div v-if="showResult">
        <div class="grid-modal">
          <div class="g1">
            <img class="show-item" :src="results.imageUrl" />
          </div>
          <div class="g2" style="text-align:left;">
            <h5>
              Title:
              <span style="font-weight: normal;">{{results.title}}</span>
            </h5>
            <h5>
              Author:
              <span style="font-weight: normal;">{{results.owner}}</span>
            </h5>
            <h5>
              Type:
              <span style="font-weight: normal;">{{results.format}}</span>
            </h5>
            <h4 style="color:red;">${{results.price}}</h4>
          </div>
        </div>
        <button class="button" style="width: 100%; !important" v-on:click="save">ADD</button>
      </div>
    </div>
    <div class="modal" v-if="orderModal">
      <a
        style="position: absolute; top: 7px; right: 15px; color: red;cursor: pointer;"
        v-on:click="exitOrderModal"
      >X</a>
      <h1>Order List</h1>
      <li v-for="item in orderList" v-bind:key="item.id">
        <span style="font-weight: normal;">{{item.user.name}}</span>
      </li>
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
      user: null,
      orderModal: false
    };
  },
  mounted: function() {
    this.getItemData();
    this.$http.get("http://127.0.0.1:8080/users/Cheese").then(response => {
      this.user = response.body;
      window.console.log(this.user);
    });
  },
  methods: {
    getItemData: function() {
      this.$http.get("http://127.0.0.1:8080/items").then(response => {
        this.data = response.body;
        window.console.log(this.data);
      });
    },
    getOrderData: function(itemId) {
      this.$http
        .get("http://127.0.0.1:8080/reserves/" + itemId)
        .then(response => {
          this.orderList = response.body;
          window.console.log(this.orderList);
        });
      this.orderModal = true;
    },
    onChange: function() {
      window.console.log(this.urlInput);
      this.$http
        .get("http://127.0.0.1:8080/responseScrap", {
          params: {
            url: this.urlInput
          }
        })
        .then(response => {
          window.console.log("Work in");
          this.results = response.body;
          window.console.log(this.results);
          this.showResult = true;
        });
    },
    cancel: function() {
      this.showModal = false;
      this.showResult = null;
      this.urlInput = null;
    },
    plus: function(itemId) {
      this.$http
        .post("http://127.0.0.1:8080/reserves/" + this.user.id + "/" + itemId)
        .then(response => {
          this.responses = response.body;
          window.console.log(this.responses);
          this.getItemData();
        });
    },
    save: function() {
      this.$http
        .post(
          "http://127.0.0.1:8080/items/" + this.user.id,
          {
            title: this.results.title,
            owner: this.results.owner,
            imageUrl: this.results.imageUrl,
            price: this.results.price,
            format: this.results.format
          },
          {
            params: {
              url: this.urlInput,
              date: "dfghj"
            }
          }
        )
        .then(response => {
          this.responses = response.body;
          window.console.log(this.responses);
          this.getItemData();
        });
      this.showResult = false;
      this.showModal = false;
    },
    exitOrderModal: function() {
      this.orderModal = false;
      this.orderList = null;
    }
  }
};
</script>

<style>
.img-item {
  width: 80%;
}

.card {
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
  transition: 0.3s;
  width: 80%;
  padding: 10px;
  margin: 20px auto auto auto;
}

.card:hover {
  box-shadow: 0 8px 16px 0 rgba(0, 0, 0, 0.2);
}

.grid-container {
  display: grid;
  grid-template-columns: 36% auto 16%;
  padding: 10px;
}

.grid-container > div {
  background-color: rgba(255, 255, 255, 0.8);
  text-align: center;
  padding: 20px 0;
  font-size: 18px;
}

.item1 {
  grid-column: 1;
}

.item2 {
  grid-column: 2;
}

.grid-modal {
  display: grid;
  grid-template-columns: 40% auto;
  padding: 10px;
}

.grid-modal > div {
  background-color: rgba(255, 255, 255, 0.8);
  text-align: center;
  padding: 20px 0;
  font-size: 18px;
}

.g1 {
  grid-column: 1;
}

.g2 {
  grid-column: 2;
}

.button {
  background-color: #f44336;
  /* Green */
  border: none;
  color: white;
  padding: 15px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
  -webkit-transition-duration: 0.4s;
  /* Safari */
  transition-duration: 0.4s;
  width: 70%;
  border-radius: 4px;
}

.button:hover {
  box-shadow: 0 12px 16px 0 rgba(0, 0, 0, 0.24),
    0 17px 50px 0 rgba(0, 0, 0, 0.19);
}

li {
  list-style-type: none;
}

.fab-wrapper {
  position: fixed;
  right: 40px;
  top: 100px;
  z-index: 5;
  display: flex;
  flex-direction: center;
  align-items: center;
}

.fab-button {
  width: 70px;
  height: 70px;
  background-color: #f44336;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  border-radius: 50%;
  box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
  transition: all 0.1s ease-in-out;
}

.fab-button:hover {
  transform: scale(1.25);
  box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.3);
}

.fab-button p {
  font-size: 30px;
  color: #ffffff;
  text-align: center;
  line-height: 70px;
}

.modal {
  border-radius: 4px;
  box-shadow: 0 0 0 9999px rgba(0, 0, 0, 0.5);
  background-color: #ffffff;
  width: 40%;
  position: fixed;
  transform: translate(-50%, -50%);
  top: 50%;
  left: 50%;
  padding: 30px;
  z-index: 1;
}

.input-group {
  position: relative;
  width: 100%;
  overflow: hidden;
}

.input-group input {
  position: relative;
  height: 45px;
  border-radius: 30px;
  min-width: 400px;
  box-shadow: none;
  border: 1px solid #eaeaea;
  padding-left: 160px;
  outline: none;
}

.input-group label {
  position: absolute;
  left: 0;
  height: 48px;
  background: #f44336;
  padding: 0px 25px;
  border-radius: 30px;
  line-height: 48px;
  font-size: 18px;
  color: #fff;
  top: 0;
  width: 100px;
  font-weight: 100;
  text-align: center;
}

.show-item {
  width: 50%;
  height: auto;
}
</style>
