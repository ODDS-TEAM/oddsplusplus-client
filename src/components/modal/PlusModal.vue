<template>
  <modal @close="$emit('close')">
    <div slot="body">
      <div class="plus-modal">
        <h3>Value</h3>
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
            <td style="text-align:center;">
              <h2 style="margin:0 ;">{{plusItem.current}}</h2>
            </td>
            <td>
              <p>
                <button class="btn-count_" v-on:click="plusItem.current++;plusItem.send++">+</button>
              </p>
            </td>
          </tr>
        </table>

        <div style="  border-bottom: 2px solid #efefef;"></div>
        <button class="plus-btn" v-on:click="sendOrder" :disabled="plusItem.send == 0">confirm</button>
        <button class="plus-btn cancel-btn" v-on:click="$emit('close')">cancel</button>
      </div>
    </div>
  </modal>
</template>

<script>
export default {
  props: {
    itemId: {
      type: String,
      default() {
        return "";
      }
    }
  },
  data() {
    return {
      userId: null,
      plusItem: {
        itemId: null,
        current: null,
        count: null,
        send: 0
      },
      responses: null
    };
  },

  beforeMount() {
    this.plusItem.itemId = this.itemId; // save props data to itself's data and deal with it
  },
  mounted: function() {
    this.userId = localStorage.getItem("userId");
    this.getOrderCount(this.plusItem.itemId);
  },
  methods: {
    getOrderCount(itemId) {
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
          this.plusItem.count = response.body;
          this.plusItem.itemId = itemId;
          this.plusModal = true;
        });
    },
    sendOrder: function() {
      this.plusModal = false;
      if (this.plusItem.send == 0) {
        return;
      } else if (this.plusItem.count + this.plusItem.send == 0) {
        this.$http
          .delete(
            process.env.VUE_APP_API +
              "/reserves/" +
              this.userId +
              "/" +
              this.plusItem.itemId
          )
          .then(response => {
            this.responses = response;
            this.clearPlusModalData();
            this.$emit("close");
            this.$emit("refresh");
          });
      } else {
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
            this.$emit("close");
            this.$emit("refresh");
          });
      }
    },

    clearPlusModalData: function() {
      this.plusItem.send = 0;
      this.plusItem.current = null;
      this.plusItem.itemId = null;
    }
  }
};
</script>

<style scoped>
.btn-count {
  background-color: #db3223;
  border-radius: 14px;
  border: 2px solid #d02718;
  color: #ffffff;
  font-family: Georgia;
  font-size: 16px;
  padding: 8px 27px;
  text-decoration: none;
}

.btn-count:hover {
  background: -webkit-gradient(
    linear,
    left top,
    left bottom,
    color-stop(0.05, rgb(236, 139, 139)),
    color-stop(1, #ff2222)
  );
}

.btn-count:active {
  position: relative;
  top: 2px;
}

.btn-count_ {
  background-color: #77b55a;
  border-radius: 14px;
  border: 1px solid #4b8f29;
  color: #ffffff;
  font-family: Georgia;
  font-size: 16px;
  padding: 8px 27px;
  text-decoration: none;
}

.btn-count_:hover {
  background: -webkit-gradient(
    linear,
    left top,
    left bottom,
    color-stop(0.05, rgb(164, 247, 145)),
    color-stop(1, #209908)
  );
}

.btn-count_:active {
  position: relative;
  top: 2px;
}
p {
  text-align: center;
}

.cancel-btn {
  color: white;
  width: 88px;
  background-color: #fa1d12;
}

.plus-btn:disabled {
  display: none;
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

/* 
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
} */
</style>