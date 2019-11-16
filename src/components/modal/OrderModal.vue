<template>
    <modal @close="$emit('close')">
        <div slot="body">
            <h3>Order List</h3>
            <div style="  border-bottom: 2px solid #efefef; margin-bottom:10px;"></div>
            <table v-if="!loading" style="width: 100%;margin: 15px 0 10px;overflow-x:auto;">
                <tr v-for="order in orderList" :key="order._id" style="height:50px">
                    <td style="width: 56px;">
                        <div>
                            <img :src="order.User.imgUrl" style="width:40px;height:40px;border-radius:5px;" />
                        </div>
                    </td>
                    <td class="p-20-h p-20-t">
                        <h4 id="order.user.name" style="font-size:15px;">{{order.User.name}}</h4>
                    </td>
                    <td id="order.count" class="p-20-h p-20-t" style="color: red; text-align:center">{{order.count}}</td>
                </tr>
            </table>
            <p style="text-align:center;"><img v-if="loading" src="../../assets/loading.gif" style="width:100px;height:100px;margin:0 auto;transform: scale(1.2);"></p>
    
        </div>
    </modal>
</template>

<script>
import { Reserve } from '../../service';
export default {
    props: {
        itemId: {
            type: String,
            default () {
                return "";
            }
        }
    },
    beforeMount() {
        this.itemId = this.itemId; // save props data to itself's data and deal with it
    },
    data() {
        return {
            orderList: null,
            loading: true
        };
    },
    mounted: function() {
        window.console.log(this.itemId);
        this.getOrderData(this.itemId);
    },
    methods: {
        getOrderData: function(itemId) {
            Reserve(itemId)
                .then(response => {
                    this.orderList = response.data;
                    window.console.log(this.orderList);
                    this.loading = false;
                });
            this.orderModal = true;
        }
    }
};
</script>

<style scoped>
li {
    margin-bottom: 10px;
}
</style>
