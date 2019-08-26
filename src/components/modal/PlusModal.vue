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
                                <button class="btn-count" :disabled="plusItem.current == 0" v-on:click="plusItem.current--;plusItem.send--">-</button>
                            </p>
                        </td>
                        <td style="text-align:center;width:50%">
                            <h2 style="margin:0 ;">{{plusItem.current}}</h2>
                        </td>
                        <td style="width:25%">
                            <p>
                                <button class="btn-count" v-on:click="plusItem.current++;plusItem.send++">+</button>
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
            default () {
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