<template>
  <div>
    <div class="nav">
      <span>
        <img class src="./../assets/odds_logo.png" />
      </span>
      <div class="main-color add-btn" v-on:click="showModal = true">+</div>
    </div>
    <div class="card">
      <nav>
        <input
          type="text"
          v-model="urlInput"
          class="urlInput"
          placeholder="Please fill amazon book URL"
        />
      </nav>
      <div class="photo">
        <img
          class="imgBook"
          src="https://images-na.ssl-images-amazon.com/images/I/512oz7h5oZL._SX302_BO1,204,203,200_.jpg"
        />
      </div>
      <div class="description">
        <h2>Animal Farm</h2>
        <h4>By George Orwell</h4>
        <h1>$16.14</h1>
        <!-- <datepicker v-model="date" placeholder="Choose date"></datepicker>

        <button>Add to Cart</button>
        <button>Wishlist</button>-->
      </div>
    </div>
    <!-- <div class="modal" v-if="showModal">
      <a
        style="position: absolute; top: 7px; right: 15px; color: red;cursor: pointer;"
        v-on:click="showModal = false"
      >X</a>
      <div>
        <input
          type="text"
          v-model="urlInput"
          class="urlInput"
          placeholder="Please fill amazon book URL"
        />
        <label class="waiting" v-if="waiting">Please wait ...</label>

        <button class="fetchBtn main-color" v-on:click="scrap">Fetch</button>
      </div>
      <div v-if="showResult" style="clear:both; margin-top: 25px;">
        <img class="rs-img" :src="results.imageUrl" />
        <div style="clear:both; margin-top: 25px;">
          <div style="clear:both;">
            Order date
            <datepicker v-model="date" placeholder="Choose date"></datepicker>
          </div>

          <div style="clear:both;">
            Title:
            <span style="font-weight: normal;">{{results.title}}</span>
          </div>
          <div style="clear:both;">
            Author:
            <span style="font-weight: normal;">{{results.owner}}</span>
          </div>

          <div style="clear:both;">
            Type:
            <span style="font-weight: normal;">{{results.format}}</span>
          </div>
        </div>

        <h4 style="color:red;">${{results.price}}</h4>
        <button class="button" style="width: 100%; !important" v-on:click="save">ADD</button>
      </div>
    </div>-->
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

.card {
  width: 90%;
  height: 375px;
  position: absolute;
  background: white;
  margin: 0 auto;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  box-shadow: 0 2px 5px 0 rgba(0, 0, 0, 0.16), 0 2px 10px 0 rgba(0, 0, 0, 0.12);
  transition: all 0.3s;
}
.card:hover {
  box-shadow: 0 8px 17px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
}
nav {
  width: 100%;
  color: #727272;
  text-transform: uppercase;
  padding: 10px 20px;
  border-bottom: 2px solid #efefef;
  font-size: 12px;
}
.photo {
  padding: 30px auto;
  width: 100%;
  text-align: center;
  /* float: left; */
}
.imgBook {
  position: absolute;
  margin: 10px auto;
  height: 200px;
  border-radius: 10px;
}
.description {
  padding: 30px;
  /* float: left; */
  width: 55%;
  border-left: 2px solid #efefef;
}
h1 {
  color: #515151;
  font-weight: 300;
  padding-top: 15px;
  margin: 0;
  font-size: 30px;
  font-weight: 300;
}

h2 {
  color: #515151;
  margin: 0;
  text-transform: uppercase;
  font-weight: 500;
}

h4 {
  margin: 0;
  color: #727272;
  text-transform: uppercase;
  font-weight: 500;
  font-size: 12px;
}

p {
  font-size: 12px;
  line-height: 20px;
  color: #727272;
  padding: 20px 0;
  margin: 0;
}

button {
  outline: 0;
  border: 0;
  background: none;
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
}
.rs-img {
  clear: both;
  width: 50%;
  height: auto;
  transform: translateX(50%);
  left: 50%;
}
.fetchBtn {
  border: 0px;

  float: right;
  width: 70px;
  height: 30px;
  border-radius: 5px;
}
.urlInput {
  width: 100%;
  height: 30px;
  /* padding: 8px 20px; */
  /* margin: 8px 0; */
  box-sizing: border-box;
  border: 0;
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
h5 {
  margin: 0;
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
  padding: 25px;
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

@media only screen and (min-width: 600px) {
  .nav {
    height: 64px;
  }
  img {
    margin: 7px 0;
    height: 40px;
  }
  .add-btn {
    width: 90px;
    height: 50px;
    font-size: 35px;
  }
  .photo {
    width: 40%;
    padding: 30px;
    float: left;
  }
  .description {
    float: left;
  }
  .card {
    width: 600px;
  }
  .imgBook {
    position: static;
    margin: auto auto;
    height: 240px;
    border-radius: 10px;
  }
}
@media only screen and (min-width: 768px) {
}
</style>

