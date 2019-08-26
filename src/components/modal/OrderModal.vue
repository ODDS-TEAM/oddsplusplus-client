<template>
    <modal @close="$emit('close')">
        <div slot="body">
            <h3>Order List</h3>
            <div style="  border-bottom: 2px solid #efefef; margin-bottom:10px;"></div>
            <table style="width: 100%;margin: 15px 0 10px;overflow-x:auto;">
                <tr v-for="order in orderList" :key="order.id" style="height:50px">
                    <td style="width: 56px;">
                        <div >
                            <img :src="order.user.imgURL" style="width:40px;height:40px;border-radius:5px;"/>
                        </div>
                    </td>
                    <td class="p-20-h p-20-t">
                        <h4 style="font-size:15px;">{{order.user.name}}</h4>
                    </td>
                    <td class="p-20-h p-20-t" style="color: red; text-align:center">{{order.count}}</td>
                </tr>
            </table>
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
    beforeMount() {
        this.itemId = this.itemId; // save props data to itself's data and deal with it
    },
    data() {
        return {
            orderList: null
        };
    },
    mounted: function() {
        window.console.log(this.itemId);
        this.getOrderData(this.itemId);
    },
    methods: {
        getOrderData: function(itemId) {
            this.$http
                .get(process.env.VUE_APP_API + "/reserves/" + itemId)
                .then(response => {
                    this.orderList = response.body;
                    window.console.log(this.orderList);
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