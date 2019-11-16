<template>
  <modal @close="$emit('close')">
    <div slot="body">
      <input
        type="text"
        v-model="urlInput"
        class="urlInput"
        placeholder="Please fill amazon book URL"
        id="modal-url-input"
      />
      <button class="main-color fetchBtn" v-on:click="scrap" id="modal-fetch-button">Fetch</button>
      <div class="alert-bar" v-if="excepMsg">
        <h4 id="addmodal-alert" style="color: white !important;">Error : {{excepMsg}}</h4>
      </div>
      <div v-if="waiting">
        <img
          src="https://cdn.dribbble.com/users/597558/screenshots/1998465/comp-2.gif"
          style="width:100%;height:auto;"
        />
      </div>
      <div v-if="showResult">
        <div class="row" style="margin-top:5px;border-top:2px solid #efefef;">
          <div class="col-4 col-s-4">
            <p style="text-align:center;padding:0;margin:10px 0 0;">
              <img class="imgBook" :src="results.img" id="modal-book-image" />
            </p>
          </div>
          <div class="col-8 col-s-8">
            <table class="table-add-img">
              <tr>
                <td>
                  <h3 id="modal-book-title">{{results.book_name}}</h3>
                  <h3 id="modal-book-format">{{results.format}}</h3>
                </td>
              </tr>
              <tr>
                <td>
                  <h4 id="modal-book-author">By {{results.author}}</h4>
                </td>
              </tr>

              <tr>
                <td>
                  <h1 id="modal-book-price" style="color:red;">${{results.price}}</h1>
                </td>
              </tr>

              <br />
              <tr>
                <td>
                  <a>Order Date</a>
                </td>
              </tr>
              <tr>
                <td>
                  <input id="modal-book-date" :min="minDateToday" type="date" v-model="date" />
                </td>
              </tr>
            </table>
            <p style="padding:10px;margin:0;text-align:center;">
              <button id="modal-save-button" class="button-add main-color" v-on:click="save">Add</button>
            </p>
          </div>
        </div>
      </div>
    </div>

    <div slot="content" style="margin-top: 15px;"></div>
  </modal>
</template>

<script>
import { Scrap, AddItem } from "../../service";
export default {
  data() {
    return {
      urlInput: null,
      data: null,
      excepMsg: null,
      waiting: false,
      showResult: false,
      date: null,
      minDateToday: new Date().toISOString().split("T")[0],
      user: {
        id: localStorage.getItem("userId"),
        name: localStorage.getItem("name"),
        email: localStorage.getItem("email"),
        imgURL: localStorage.getItem("imgURL")
      }
    };
  },
  methods: {
    clearModalData(mode = 0) {
      this.excepMsg = null;
      this.showModal = false;
      this.showResult = false;
      this.results = null;
      this.date = null;
      if (mode == 1) return;
      this.urlInput = null;
    },
    save: function() {
      window.console.log(this.date);

      if (this.date === null) {
        alert("Please select date that you want to order!");
      } else {
        AddItem({
          title: this.results.book_name,
          author: this.results.author,
          imgUrl: this.results.img,
          price: parseFloat(this.results.price),
          format: this.results.format,
          user: this.user.id,
          url: this.urlInput,
          count: 1,
          cost: 0.0,
          orderDate: new Date(this.date)
        }).then(response => {
          window.console.log(response);
          this.$nextTick(() => {
            this.$emit("refresh");

            this.renderComponent = true;
          });
          this.$emit("close");
        });
        this.clearModalData();
      }
    },
    scrap: function() {
      this.results = null;
      this.showResult = false;
      this.excepMsg = null;
      this.waiting = true;
      Scrap({ book_url: this.urlInput }).then(
        response => {
          window.console.log(response);
          this.excepMsg = null;
          this.waiting = false;
          this.results = response.data;
          window.console.log(this.results);
          this.showResult = true;
        },
        error => {
          this.excepMsg = error.body.message;
          this.waiting = false;
        }
      );
    }
  }
};
</script>

<style scoped>
.fetchBtn {
  border: 0px;
  color: white;
  float: right;
  width: 20%;
  height: 30px;
  border-radius: 5px;
  cursor: pointer;
  margin: 8px 0;
  font-size: 15px;
}

.urlInput {
  width: 78%;
  height: 30px;
  padding: 0 20px;
  margin: 8px 0;
  box-sizing: border-box;
  box-shadow: 0px 0px 1px 0px rgba(0, 0, 0, 0.75);
  border: 0;
  border-radius: 4px;
}

.alert-bar {
  width: 100%;
  background-color: #b13636;
  text-align: center;
}

.imgBook {
  margin: 0 auto;
  width: auto;
  height: 180px;
  border-radius: 15px;
}

.table-add-img {
  padding: 0 10px;
}

.button-add {
  border: 0;
  border-radius: 4px;
  padding: 8px 0px;
  color: white;
  width: 100%;
  margin-bottom: 5px;
  transition: all 0.3s ease;
  cursor: pointer;
}

[type="date"] {
  background: #fff
    url(https://cdn1.iconfinder.com/data/icons/cc_mono_icon_set/blacks/16x16/calendar_2.png)
    97% 50% no-repeat;
  border: 1px solid #c4c4c4;
  border-radius: 5px;
  background-color: #fff;
  padding: 5px;
  box-shadow: inset 0 3px 6px rgba(83, 83, 83, 0.2);
  width: 125px;
  height: 25px;
  margin: 5px 0px 10px;
}

[type="date"]::-webkit-inner-spin-button {
  display: none;
}

[type="date"]::-webkit-calendar-picker-indicator {
  opacity: 0;
}

@media only screen and (min-width: 768px) {
  .imgBook {
    position: static;
    margin: auto auto;
    width: auto;
    height: 240px;
    max-width: 165px;
    border-radius: 10px;
    margin: 0;
  }
}
</style>