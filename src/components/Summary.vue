<template>
    <div class="card">
    
        <div class="row">
            <div v-if="loading" class="col-12">
                <p><img src="../assets/loading.gif" style="width:100px;height:100px;margin: 0;border-radius:50%;;"></p>
            </div>
    
            <div v-if="!loading" class="col-4 prod-detail" style>
                <p>
                    <img id="card-boot-image" class="img-item" :src="summary[0].Item[0].imgUrl" />
                </p>
                <h3 id="summary-title-format" >{{summary[0].Item[0].title}} ({{summary[0].Item[0].format}})</h3>
                <h4 id="summary-author">by {{summary[0].Item[0].author}}</h4>
                <h1 id="summary-price" style="color: red">$ {{summary[0].Item[0].price}}</h1>
                <h5 id="summary-order-date">Order date: {{summary[0].Item[0].orderDate| formatDate}}</h5>
            </div>
            <div v-if="!loading" class="col-8 summary-detail">
                <table style="height:110px;width: 100%; margin:10px 0; border-bottom: 2px solid #efefef;">
                    <tr>
                        <table style="width:100%;">
                            <tr>
                                <td style="width:45%;">
                                    <h2 id="summary-total-qty" class="p-20-t">Qty : {{summary[0].Item[0].count}}</h2>
                                </td>
                                <td style="width:27.5%;">
                                    <button id="summary-btn-go-to-amazon" class="btn-order" v-on:click="goToAmazon">Go to Amazon</button>
                                </td>
                                <td style="width:27.5%;"> <button id="summary-btn-order-update" class="btn-order btn-sum" v-on:click="modal = true">Order Update</button>
                                </td>
                            </tr>
                        </table>
    
                    </tr>
                    <tr>
                        <h3 id="summary-total-price" class="p-20-t">Total price : ${{summary[0].Item[0].cost}}</h3>
                    </tr>
                    <tr>
                        <h3 id="summary-total-charge" class="p-20-t">Total charge : ${{summary[0].Item[0].shippingCharge}}</h3>
                    </tr>
                </table>
                <thead>
                    <tbody>
                        <table style="width: 100%;margin: 20px 0 0px;overflow-x:auto;">
                            <tr>
                                <th class="img-user"></th>
                                <th class="p-20-h" style="width:80%;">Name</th>
                                <th class="p-20-h" style="width:20%; text-align:center">Qty</th>
                                <th class="p-20-h" style="width:20%;">Costs($)</th>
                                <th class="p-20-h" style="width:20%;">Charge($)</th>
                            </tr>
                            <tr v-for="order in summary[0].Reserve" :key="order.id">
                                <td class="p-20-h p-20-t img-user" style="width:60px !important;">
                                    <p style="text-align:left; margin : 0;">
                                        <img :src="order.user[0].imgUrl" style="width:40px;height:40px;border-radius:5px;" /> </p>
                                </td>
                                <td class="p-20-h p-20-t" id="summary-Name" >{{order.user[0].name}} </td>
                                <td class="p-20-h p-20-t" id="summary-Qty"  style="color: red; text-align:center">{{order.count}}</td>
                                <td class="p-20-h p-20-t" id="summary-Costs($)" style="color: red; text-align:center">{{order.cost.toFixed(2)}}</td>
                                <td class="p-20-h p-20-t" id="summary-Charge($)" style="color: red; text-align:center">{{order.shippingCharge}}</td>
                            </tr>
                            
                        </table>
                    </tbody>
                </thead>
            </div>
        </div>
    
        <ResultModal @close="modal=false" @refresh="getItemData" v-if="modal" />
    </div>
</template>

<script>
import ResultModal from './modal/ResultModal.vue'
import { GetSummary, UpdateOrder, AddSummary } from '../service';
import { isObject } from 'util';
export default {
    components: {
        ResultModal
    },
    props: ["itemid"],
    data() {
        return {
            itemId: null,
            summary: {
                item: {}
            },
            userId: null,
            modal: false,
            cost: null,
            charge: null,
            responses: null,
            loading: true,

        };
    },
    mounted: function() {
        this.userId = localStorage.getItem("userId");
        if (typeof this.$route.params.id === "undefined") {
            this.$router.push("/myitem");
        }
        this.getItemData();
    },
    methods: {
        getItemData: function() {
            GetSummary(this.$route.params.id).then(res => {
                this.summary = res.data
                console.log(this.summary)
                if(this.summary.length == 0) {
                    console.log("Length = 0")
                    this.Summary();
                    // this.getItemData
                }
            });
            this.loading = false;
        },
        Summary: function() {
            AddSummary(this.$route.params.id)
                .then(response => {
                    if (response) {
                        this.getItemData()
                    }
                })
        },
        updateOrder: function() {
            UpdateOrder(
                    this.$route.params.id ,
                    this.cost ,
                    this.charge
                )
                .then(response => {
                    this.clearModalData();
                    this.$emit("refreshMyItem");
                    this.responses = response.body;
                });
        },
        clearModalData: function() {
            this.modal = false;
            this.cost = 0.0;
            this.charge = 0.0;
        },
        goToAmazon: function() {
            window.open(this.summary[0].Item[0].url, "_blank");
        }
    }
};
</script>

<style scoped>
.img-user {
    display: none;
}

thead {
    display: inline-block;
    width: 100%;
}

tbody {
    height: 150px;
    display: inline-block;
    width: 100%;
    overflow: auto;
}

.p-20-h {
    padding: 0 10px 0 10px;
    font-size: 12px;
}

.p-20-t {
    padding: 10px 10px 0 10px;
}

.prod-detail {
    padding: 20px;
    border-bottom: 2px solid #efefef;
}

.card {
    margin-top: 100px;
}

th {
    text-align: left;
}

p {
    text-align: center;
}

h2,
h3 {
    margin: 0;
}

.img-item {
    max-height: 240px;
    max-width: 200px;
}

@media only screen and (min-width: 768px) {
    .img-user {
        display: block;
    }
    .p-20-h {
        font-size: 16px;
    }
    tbody {
        height: 290px;
        display: inline-block;
        width: 100%;
        overflow: auto;
    }
    .prod-detail {
        padding: 20px;
        border-bottom: none;
        border-right: 2px solid #efefef;
    }
    .img-item {
      max-height: 240px;
      max-width: 190px;
    }
}

.btn-order {
    border-radius: 5px;
    border: 1px solid #d9d9d9;
    padding: 8px;
    color: #515151;
    text-transform: uppercase;
    width: 100% !important;
    font-size: 10px;
    margin-right: 5px;
    transition: all 0.3s ease;
    font-weight: 500;
    box-shadow: 0 0 15px 0 0;
    float: right;
    margin-top: 10px;
}

.btn-order:hover {
    box-shadow: 0 0 10px 0 rgba(0, 0, 0, 0.1);
    cursor: pointer;
}

.btn-sum {
    border: 0;
    background-color: #1498d5;
    color: white;
    width: 120px;
}

.modal {
    padding: 0px 20px 0px 20px;
    width: 250px;
    height: 200px;
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
}
</style>
