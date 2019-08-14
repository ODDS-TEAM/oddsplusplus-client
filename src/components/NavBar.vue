<template>
  <div>
    <div class="nav">
      <span>
        <img class src="./../assets/odds_logo.png" />
      </span>
      <div class="main-color add-btn" v-on:click="showModal = true">+</div>
    </div>
    <div class="modal" v-if="showModal">
      <a
        style="position: absolute; top: 7px; right: 15px; color: red;cursor: pointer;"
        v-on:click="showModal = false"
      >X</a>
      <div>
          <input type="text" v-model="urlInput" class="urlInput" placeholder="Please fill amazon book URL" />
          <button class="fetchBtn" v-on:click="scrap">Fetch</button>
      </div>
      <label class="waiting" v-if="waiting">Please wait ...</label>
      <div v-if="showResult">
        <div class="grid-modal">
          <div class="g1">
            <img class="show-item" :src="results.imageUrl" />
          </div>
          <div class="g2" style="text-align:left;">
            <label>Order date</label>
            <datepicker v-model="date" placeholder="Choose date"></datepicker>
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
  </div>
</template>

<script>
import Datepicker from "vuejs-datepicker";

export default {
  components: {
    Datepicker
  },
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
      orderModal: false,
      date: null,
      waiting: false
    };
  },
  methods: {
    scrap: function() {
      this.waiting = true;
      this.$http
        .get("http://35.208.105.247:8080/responseScrap", {
          params: {
            url: this.urlInput
          }
        })
        .then(response => {
          this.waiting = false;
          this.results = response.body;
          window.console.log(this.results);
          this.showResult = true;
        });
    },
    save: function() {
      window.console.log(this.date);
      this.$http
        .post(
          "http://35.208.105.247:8080/items/" + this.user.id + "/" + this.date,
          {
            title: this.results.title,
            owner: this.results.owner,
            imageUrl: this.results.imageUrl,
            price: this.results.price,
            format: this.results.format
          },
          {
            params: {
              url: this.urlInput
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
      this.urlInput = null;
    }
  }
};
</script>

<style scoped>
* {
  box-sizing: border-box;
}
.urlInput{
  width: 100%;
  padding: 8px 20px;
  margin: 8px 0;
  box-sizing: border-box;
  border: 1px solid #4e4e4e;
  border-radius: 4px;
}
.nav {
  margin: 0;
  padding: 6px 10px;
  overflow: hidden;
  background-color: #f2f2f2;
  height: 43px;
}
img {
  margin: 2px 0;
  height: 27px;
}
.add-btn {
  float: right;
  text-align: center;
  width: 40px;
  height: 31px;
  font-size: 23px;
  border-radius: 5px;
  color: white;
  font-weight: 900;
}

.modal {
  width: 90%;
  padding: 20p;
  border-radius: 4px;
  box-shadow: 0 0 0 9999px rgba(0, 0, 0, 0.5);
  background-color: #ffffff;
  position: fixed;
  transform: translate(-50%, -50%);
  top: 50%;
  left: 50%;
  padding: 30px;
  z-index: 1;
}
[type="date"] {
  background: #fff
    url(https://cdn1.iconfinder.com/data/icons/cc_mono_icon_set/blacks/16x16/calendar_2.png)
    97% 50% no-repeat;
}
[type="date"]::-webkit-inner-spin-button {
  display: none;
}
[type="date"]::-webkit-calendar-picker-indicator {
  opacity: 0;
}

/* @media only screen and (min-width: 600px) {
  ul {
    height: 64px;
  }
}
@media only screen and (min-width: 768px) {
  .nav {
    height: 64px;
  }
} */
</style>

