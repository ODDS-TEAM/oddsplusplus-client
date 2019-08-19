<template>
  <div>
    <ul>
      <li v-for="item in data" v-bind:key="item.value">
        <div class="card">
          <div class="row">
            <div class="col-3 col-s-4">
              <p>
                <img id="card-boot-image" class="img-item" :src="item.imgUrl" />
              </p>
            </div>

            <div class="col-6 col-s-8 title">
              <h3>Name : {{ item.title }}</h3>
              <h3>Type : {{item.format}}</h3>
            </div>

            <div class="col-2 col-s-8">
              <div>
                <button class="button-summary">Summary</button>
              </div>
              <div v-if="orderdate = true">
                <button class="button-delete myButton:hover" v-on:click="deleteItem(item.id)">Delete</button>
              </div>
            </div>
          </div>
        </div>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  data() {
    return {
      data: null,
      user: null
    };
  },
  mounted: function() {
    this.getUserData();
  },
  methods: {
    getItemData: function() {
      this.$http
        .get(process.env.VUE_APP_API + "/items/users/" + this.user.id)
        .then(response => {
          this.data = response.body;
          window.console.log(this.data);
        });
    },
    getUserData: function() {
      this.$http
        .get(process.env.VUE_APP_API + "/users/Cheese")
        .then(response => {
          this.user = response.body;
          window.console.log(this.user);
          this.getItemData();
        });
    },
    deleteItem: function(itemId) {
      this.$http
        .delete(
          process.env.VUE_APP_API +
            "/items/users/" +
            itemId +
            "/" +
            this.user.id
        )
        .then(response => {
          this.$emit("refreshMyItem");
        });
    }
  }
};
</script>

<style scoped>
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
  max-width: 100px;
  max-height: 120px;
}
.card {
  border-radius: 10px;
  box-shadow: 0 0 15px 0 rgba(0, 0, 0, 0.2);
  transition: 0.3s;
  width: 80%;
  margin: 25px auto;
}
.card:hover {
  box-shadow: 0 0 15px 0 rgba(0, 0, 0, 0.5);
}
h3 {
  color: #515151;
  margin-bottom: 5px;
  /* margin-top: 30px; */
  font-size: 18px;
}

.button-summary {
  -moz-box-shadow: inset 0px 39px 0px -24px #4883db;
  -webkit-box-shadow: inset 0px 39px 0px -24px #4883db;
  box-shadow: inset 0px 39px 0px -24px #4883db;
  background-color: #5d92e3;
  -moz-border-radius: 4px;
  -webkit-border-radius: 4px;
  border-radius: 4px;
  border: 1px solid #ffffff;
  display: inline-block;
  cursor: pointer;
  color: #ffffff;
  font-family: Arial;
  font-size: 15px;
  margin-top: 40px;
  padding: 6px 30px;
  text-decoration: none;
  text-shadow: 0px 1px 0px #0066ff;
}
.button-summary:hover {
  background-color: #5d92e3;
}
.button-summary:active {
  position: relative;
  top: 1px;
}

.button-delete:hover {
  background-color: #fa1d12;
}
.button-delete:active {
  position: relative;
  top: 1px;
}

.button-delete {
  -moz-box-shadow: inset 0px 39px 0px -24px #f76159;
  -webkit-box-shadow: inset 0px 39px 0px -24px #f76159;
  box-shadow: inset 0px 39px 0px -24px #f76159;
  background-color: #fa3628;
  -moz-border-radius: 4px;
  -webkit-border-radius: 4px;
  border-radius: 4px;
  border: 1px solid #ffffff;
  display: inline-block;
  cursor: pointer;
  color: #ffffff;
  font-family: Arial;
  font-size: 15px;
  margin-top: 5px;
  padding: 6px 40px;
  text-decoration: none;
  text-shadow: 0px 1px 0px #b23e35;
}
.button-add:hover {
  box-shadow: 0 0 10px 0 rgba(0, 0, 0, 0.1);
  cursor: pointer;
}
.modal:hover {
  box-shadow: 0 8px 17px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
}

@media only screen and (min-width: 768px) {
  ul {
    margin-top: 94px;
  }
  .card {
    width: 650px;
  }
  .modal {
    width: 300px;
  }
  .img-item {
    position: relative;
    margin: auto auto;
    max-width: 100px;
    max-height: 120px;
  }
}
</style>
