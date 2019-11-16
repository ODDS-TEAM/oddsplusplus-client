<template>
  <modal @close="$emit('close')">
    <div slot="body">
      <div class="plus-modal">
        <h3>Quantity</h3>
        <div style="  border-bottom: 2px solid #efefef;"></div>

        <table style="width:100%;">
          <tr>
            <td style="width:25%">
              <p>
                <button
                  class="btn-count"
                  id="plusmodal-minus-button"
                  :disabled="plusItem.current == 0"
                  v-on:click="plusItem.current--;plusItem.send--"
                >-</button>
              </p>
            </td>
            <td style="text-align:center;width:50%">
              <h2 id="plusmodal-current" v-if="!loading" style="margin:0 ;">{{plusItem.current}}</h2>
              <img
                v-if="loading"
                src="../../assets/loading.gif"
                style="width:50px;height:50px;margin:0 auto;transform: scale(1.2);"
              />
            </td>
            <td style="width:25%">
              <p>
                <button
                  class="btn-count"
                  id="plusmodal-plus-button"
                  v-on:click="plusItem.current++;plusItem.send++"
                >+</button>
              </p>
            </td>
          </tr>
        </table>

        <div style="  border-bottom: 2px solid #efefef;"></div>
        <button
          class="plus-btn"
          id="plusmodal-confirm-button"
          v-on:click="sendOrder"
          :disabled="plusItem.send == 0"
        >confirm</button>
        <button
          class="plus-btn cancel-btn"
          id="plusmodal-cancel-button"
          v-on:click="$emit('close')"
        >cancel</button>
      </div>
    </div>
  </modal>
</template>

<script>
import { GetOrder, DeleteOrderByUserAndItem, AddReserve } from "../../service";
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
      loading: true,
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
      console.log("itemId = " + this.itemId)
    this.plusItem.itemId = this.itemId; // save props data to itself's data and deal with it
  },
  mounted: function() {
    this.userId = localStorage.getItem("userId");
    this.getOrderCount(this.plusItem.itemId);
  },
  methods: {
    getOrderCount(itemId) {
      GetOrder(this.userId, itemId).then(response => {
        this.plusItem.current = parseInt(response.data);
        this.plusItem.count = parseInt(response.data);
        this.plusItem.itemId = itemId;
        this.plusModal = true;
        this.loading = false;
      });
    },
    sendOrder: function() {
      this.plusModal = false;
      if (this.plusItem.send == 0) {
        return;
      } else if (this.plusItem.count + this.plusItem.send == 0) {
        DeleteOrderByUserAndItem(this.userId, this.plusItem.itemId).then(
          response => {
            this.responses = response;
            this.clearPlusModalData();
            this.$emit("close");
            this.$emit("refresh");
          }
        );
      } else {
        AddReserve(this.userId, this.plusItem.itemId, this.plusItem.send).then(
          response => {
            this.clearPlusModalData();
            this.responses = response.data;
            this.$emit("close");
            this.$emit("refresh");
          }
        );
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
  cursor: pointer;
  background-color: #1e9cb5;
  border-radius: 4px;
  border: 0 !important;
  color: #fff;
  font-size: 25px;
  font-weight: 900;
  padding: 5px;
  width: 100%;
  height: 100%;
}

p {
  text-align: center;
}

.cancel-btn {
  color: white;
  width: 88px;
  background-color: #f55246 !important;
}

.plus-btn:disabled {
  display: none;
}

.plus-btn {
  cursor: pointer;
  background-color: #1498d5;
  border-radius: 5px;
  border: 0;
  padding: 8px;
  margin: 10px 0 10px 10px;
  color: white;
  text-transform: uppercase;
  width: 90px;
  font-family: inherit;
  float: right;
}
</style>