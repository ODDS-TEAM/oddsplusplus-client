
<template>
    <div class="card">

        <div v-for="item in data" v-bind:key="item.value">
            <table class="card-table">
                <tr>
                    <td class="item-img"><img class="img-item" :src="item.imgUrl"></td>
                    <td class="item-data">
                        <table>
                            <tr>Title : {{item.title}}</tr>
                            <tr>Author : {{item.author}}</tr>
                            <tr>Price : ${{item.price}}</tr>
                            <tr>Author : {{item.author}}</tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</template>
<script>
    export default {
        data() {
            return {
                data: null,
                item: null



            }

        },
        mounted: function () {

            this.$http.get('http://34.87.104.156/items').then(response => {
                this.someData = response.body
                this.data = this.someData
                window.console.log(this.data)
            })
        }


    }
</script>


<style>
    .img-item {
        height: auto;
    }

    .card {
        width: 90%;
        height: 200px;
    }

    .card-table {
        width: 100%;
        height: 100%;
    }

    .item-img {
        width: 30%;
        height: 200px;

    }

    .item-data {
        width: 70%;
    }
</style>
