<template>
  <div>
    <div class="nav">
      <span>
        <img class src="./../assets/odds_logo.png" id="navbar-logo" />
      </span>
      <div class="main-color add-btn" v-on:click="showModal = true" id="navbar-add-button">+</div>
    </div>
    <div class="card" v-if="showModal">
      <a class="modal-cancel" v-on:click="clearModalData" id="modal-cancel">X</a>
      <nav>
        <span>
          <input
            type="text"
            v-model="urlInput"
            class="urlInput"
            placeholder="Please fill amazon book URL"
            id="modal-url-input"
          />
        </span>
        <span style="width:30%">
          <button class="main-color fetchBtn" v-on:click="scrap" id="modal-fetch-button">Fetch</button>
        </span>
      </nav>
      <div class="alert-bar" v-if="excepMsg">
        <h4 style="  color: white !important;">Error : {{excepMsg}}</h4>
      </div>
      <div v-if="waiting">
        <img
          src="https://cdn.dribbble.com/users/597558/screenshots/1998465/comp-2.gif"
          style="width:100%;height:auto;"
        />
      </div>
      <div v-if="showResult">
        <div style="  border-bottom: 2px solid #efefef;"></div>
        <div class="photo">
          <img class="imgBook" :src="results.imageUrl" id="modal-book-image" />
        </div>
        <div class="description">
          <h3 id="modal-book-title">{{results.title}}</h3>
          <h4 id="modal-book-author">By {{results.owner}}</h4>
          <h1 id="modal-book-price" style="color:red;">${{results.price}}</h1>
          <p id="modal-book-format">{{results.format}}</p>
          <input id="modal-book-date" type="date" v-model="date" />
          <br />
          <button id="modal-save-button" class="button-add" v-on:click="save">Add</button>

          <!-- 

        <button>Add to Cart</button>
          <button>Wishlist</button>-->
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      excepMsg: null,
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
  mounted: function() {
    // this.getItemData();
    window.console.log();

    this.$http.get("http://35.209.202.150:8080/users/Cheese").then(response => {
      this.user = response.body;
      window.console.log(this.user);
    });
  },
  methods: {
    scrap: function() {
      this.results = null;
      this.showResult = false;
      this.excepMsg = null;
      this.waiting = true;
      this.$http
        .get("http://35.209.202.150:8080/responseScrap", {
          params: {
            url: this.urlInput
          }
        })
        .then(
          response => {
            this.excepMsg = null;
            this.waiting = false;
            this.results = response.body;
            window.console.log(this.results);
            this.showResult = true;
          },
          error => {
            this.excepMsg = error.body.message;
            this.waiting = false;
          }
        );
    },
    save: function() {
      window.console.log(this.date);
      this.$http
        .post(
          "http://35.209.202.150:8080/items/" +
            this.user.id +
            "/" +
            new Date(this.date),
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
          this.$emit("addEvent");
        });
      this.clearModalData();
    },
    clearModalData(mode = 0) {
      this.excepMsg = null;
      this.showModal = false;
      this.showResult = false;
      this.results = null;
      this.date = null;
      if (mode == 1) return;
      this.urlInput = null;
    }
  }
};
</script>

<style scoped>
* {
  box-sizing: border-box;
}
.alert-bar {
  width: 100%;
  background-color: #b13636;
  text-align: center;
}
[type="date"] {
  background: #fff
    url(https://cdn1.iconfinder.com/data/icons/cc_mono_icon_set/blacks/16x16/calendar_2.png)
    97% 50% no-repeat;
  border: 1px solid #c4c4c4;
  border-radius: 5px;
  background-color: #fff;
  padding: 3px 5px;
  box-shadow: inset 0 3px 6px rgba(83, 83, 83, 0.2);
  width: 125px;
  margin: 5px 0px 15px;
}
[type="date"]::-webkit-inner-spin-button {
  display: none;
}
[type="date"]::-webkit-calendar-picker-indicator {
  opacity: 0;
}
.card {
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
  box-shadow: 0 2px 5px 10000px rgba(0, 0, 0, 0.5);
  transition: all 0.3s;
}

nav {
  width: 100%;
  color: #727272;
  text-transform: uppercase;
  padding: 10px 20px;
  border-bottom: 0;
  font-size: 12px;
}
.photo {
  padding: 1%;
  width: 45%;
  text-align: center;
  float: left;
  border-right: 2px solid #efefef;
}
.imgBook {
  margin: 10px auto;
  width: 125px;
  height: auto;
  border-radius: 15px;
}
.description {
  padding: 5% 3% 0 5%;
  float: left;
  width: 55%;
}
h1 {
  color: #515151;
  font-weight: 300;
  padding-top: 15px;
  margin: 0;
  font-size: 30px;
  font-weight: 300;
}

h3 {
  color: #515151;
  margin: 0;
}

h4 {
  margin: 0;
  color: #727272;
  font-weight: 500;
  font-size: 12px;
}

p {
  font-size: 12px;
  line-height: 20px;
  color: #727272;
  padding: 10px 0;
  margin: 0;
}

.button-add {
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
  cursor: pointer;
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
  color: white;
  float: right;
  width: 20%;
  height: 30px;
  border-radius: 5px;
  cursor: pointer;
  font-size: 15px;
}
.urlInput {
  width: 78%;
  height: 30px;
  /* padding: 8px 20px; */
  /* margin: 8px 0; */
  box-sizing: border-box;
  border: 0;
  border-radius: 4px;
}
.nav {
  position: fixed; /* Set the navbar to fixed position */
  top: 0; /* Position the navbar at the top of the page */
  width: 100%;
  margin: 0;
  padding: 6px 10px;
  overflow: hidden;
  background-color: white;
  height: 43px;
  border-bottom: 2px solid #efefef;
  box-shadow: 0 0 5px -1px rgba(0, 0, 0, 0.5);
  z-index: 2;
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
  cursor: pointer;
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
    width: 53px;
    height: 50px;
    font-size: 35px;
  }
  .photo {
    width: 40%;
    padding: 15px;
    float: left;
  }
  .description {
    float: left;
  }
  .card {
    width: 550px;
  }
  .imgBook {
    position: static;
    margin: auto auto;
    width: auto;
    height: 240px;
    max-width: 180px;
    border-radius: 10px;
  }
  p {
    font-size: 12px;
    line-height: 20px;
    color: #727272;
    padding: 20px 0;
    margin: 0;
  }
}
.modal-cancel {
  position: absolute;
  width: 20px;
  height: 20px;
  top: -10px;
  right: -10px;
  color: white;
  cursor: pointer;
  border-radius: 50%;
  background-color: #ff0000;
  text-align: center;
}
</style>

