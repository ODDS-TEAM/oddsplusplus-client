<template>
  <div>
    <div class="header">
      <h1 id="myorder-title" style="text-align:center;padding:0;">Your Orders</h1>
    </div>
    <ul>
      <li v-for="(item, index) in data" v-bind:key="item.value">
        <div class="card">
          <div class="row">
            <div class="col-3">
              <p>
                <img id="card-boot-image" class="img-item" :src="item.item.imgUrl" />
              </p>
            </div>

            <div class="col-9 detail">
              <h3 id="item-title" class="item-title">{{ item.item.title }}</h3>
              <h4 id="item-author-format">By {{ item.item.author }} ({{item.item.format}})</h4>
              <table style="height:40px;" class="tb-btn">
                <tr>
                  <td>
                    <div
                      style="position: relative;margin: auto;overflow: hidden;width: 40px;height:40px;"
                    >
                      <img
                        v-if="loading[index]"
                        src="../assets/loading.gif"
                        style="width:40px;height:40px;margin: 0;border-radius:50%;transform: scale(1.6);"
                      />
                    </div>
                  </td>
                  <td v-if="item.item.status.status == 'pending'">
                    <p>
                      <button
                        class="minus-btn"
                        id="roder-minus-button"
                        style="margin-left: 5px;"
                        :disabled="item.count == 1"
                        v-on:click="decrease(index)"
                      >-</button>
                    </p>
                  </td>
                  <td v-else>
                    <h3>Qty {{item.count}}</h3>
                  </td>
                  <td v-if="item.item.status.status == 'pending'">
                    <h3 class="amount" id="order-amount">{{item.count}}</h3>
                  </td>
                  <td v-else>
                    <h3>Cost ${{item.cost}}</h3>
                  </td>
                  <td v-if="item.item.status.status == 'pending'">
                    <p>
                      <button class="plus-btn" id="order-plus-button" v-on:click="increase(index)">+</button>
                    </p>
                  </td>
                  <td v-else>
                    <h3>Charge ${{item.shippingCharge}}</h3>
                  </td>
                  <td style="margin-left:5px;">
                    <p v-if="item.item.status.status == 'pending'">
                      <button
                        class="del-btn"
                        id="order-delete-button"
                        v-on:click="deleteOrder(item.id)"
                      >
                        <img class="img-delete" src="./../assets/delete.png" />
                      </button>
                    </p>
                  </td>
                </tr>
              </table>
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
      userId: null,
      orderdate: true,
      timeout: null,
      qtySend: 0,
      loading: []
    };
  },
  mounted: function() {
    this.userId = localStorage.getItem("userId");
    this.getOrder();
  },
  methods: {
    decrease: function(index) {
      this.loading[index] = true;
      this.data[index].count--;
      if (this.timeout) {
        clearTimeout(this.timeout);
      }
      this.timeout = setTimeout(() => {
        this.$http
          .post(
            process.env.VUE_APP_API +
              "/orders/" +
              this.userId +
              "/" +
              this.data[index].item.id +
              "/" +
              this.data[index].count
          )
          .then(() => {
            this.getOrder();
            this.loading[index] = false;
          });
      }, 900);
    },
    increase: function(index) {
      this.loading[index] = true;

      this.data[index].count++;
      if (this.timeout) {
        clearTimeout(this.timeout);
      }
      this.timeout = setTimeout(() => {
        this.$http
          .post(
            process.env.VUE_APP_API +
              "/orders/" +
              this.userId +
              "/" +
              this.data[index].item.id +
              "/" +
              this.data[index].count
          )
          .then(() => {
            this.getOrder();
            this.loading[index] = false;
          });
      }, 900);
    },
    getOrder() {
      this.$http
        .get(process.env.VUE_APP_API + "/reserves/users/" + this.userId)
        .then(response => {
          this.data = response.body;
          window.console.log(this.data);
          window.console.log(this.data.length);
          this.loading = [];

          for (var i = 0; i < this.data.length; i++) {
            this.loading.push(false);
          }
          window.console.log(this.loading);
        });
    },
    deleteOrder: function(orderId) {
      this.$http
        .delete(process.env.VUE_APP_API + "/reserves/" + orderId)
        .then(() => {
          this.getOrder();
        });
    }
  }
};
</script>

<style scoped>
.minus-btn {
  cursor: pointer;
  background-color: #1e9cb5;
  border: 0;
  color: white;
  width: 40px;
  height: 30px;
  border-radius: 4px;
  font-size: 14px;
}

.amount {
  text-align: center;
  width: 30px;
  margin: 0 auto;
  padding: 0;
  /* padding-bottom: 20px; */
}

.del-btn {
  cursor: pointer;
  background-color: #f55246;
  border: 0;
  color: white;
  width: 40px;
  height: 30px;
  border-radius: 4px;
  font-size: 14px;
  margin-left: 5px;
}

.btn {
  border-radius: 4px;
  font-family: Georgia;
  font-size: 16px;
  margin: 0px 10px 9px 10px;
  text-decoration: none;
}

.plus-btn {
  cursor: pointer;
  background-color: #1e9cb5;
  border: 0;
  color: white;
  width: 40px;
  height: 30px;
  border-radius: 4px;
  font-size: 14px;
}

.header {
  margin-top: 50px;
  font-weight: 900;
}

.detail {
  text-align: left;
  padding: 0 25px;
}

table {
  border-spacing: 0;
}

.tb-btn {
  width: 100%;
  margin: 10px auto;
}

p {
  text-align: center;
}

.img-item {
  position: relative;
  margin: auto auto;
  max-width: 110px;
  max-height: 168.4px;
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

.item-title {
  position: inherit;
  white-space: nowrap;
  overflow: hidden;
  width: 90%;
  text-overflow: ellipsis;
}

.img-delete {
  height: 17px;
}

@media only screen and (min-width: 768px) {
  p {
    margin: 0;
    padding: 0;
    text-align: left;
  }
  ul {
    margin-top: 10px;
  }
  .card {
    width: 500px;
    height: 140px;
  }
  .footer-btn {
    margin: auto 15px 10px 0;
  }
  .detail {
    text-align: left;
    padding: 0;
  }
  .img-item {
    position: relative;
    margin: auto auto;
    max-width: 100px;
    max-height: 140px;
    border-radius: 10px 0 0 10px;
  }
  .tb-btn {
    width: 50%;
    float: right;
    margin: 25px 10px;
  }
  .header {
    margin-top: 100px;
  }
  .img-delete {
    height: 20px;
  }
  .plus-btn {
    margin-left: 3px;
  }
}
</style>
