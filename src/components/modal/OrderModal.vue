<template>
    <modal @close="$emit('close')">
        <div slot="body">
            <h3>Order List</h3>
            <div style="  border-bottom: 2px solid #efefef; margin-bottom:10px;"></div>
            <li v-for="item in orderList" v-bind:key="item.id">
                <h4>{{item.user.name}} ({{item.count}})</h4>
            </li>
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
        window.console.log(this.itemId)
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


}
</script>

<style scoped>
li{
    margin-bottom: 10px;
}
</style>