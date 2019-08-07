<template>

    <div >
        <div class="fab-wrapper"><a class="fab-button" v-on:click="showModal = true"><h1 style="color: white;">+</h1>
        </a></div>
        <ul style="margin-top: 140px;">
            <li v-for="item in data" v-bind:key="item.value">
                <div class=" card">
                    <div class="grid-container">
                        <div class="item1">
                            <img class="img-item" :src="item.imgUrl">
                        </div>
                        <div class="item2" style="text-align:left">
                            <h4>{{ item.title }}</h4>
                            <h5>Author: <span style="font-weight: normal;"> {{ item.author }} </span></h5>
                            <h4 style="color:red;">${{ item.price }}</h4>
                            <h5>Add by: <span style="font-weight: normal;">{{ item.user.name }}</span></h5>
                        </div>
                        <div class="item3" style="margin-top: auto; margin-bottom: auto;">
                            <button class="button">PLUS 1</button>
                        </div>
                    </div>
                </div>
            </li>
        </ul>
        <div class="modal" v-if="showModal">
            <a style="position: absolute; top: 7px; right: 15px; color: white;cursor: pointer;" v-on:click="showModal = false">X</a>
            <input type="text" placeholder="Please fill amazon book URL">
        </div>
    </div>

</template>

<script>


    export default {


        data() {
            return {
                data: null,
                item: null,
                showModal: false

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
    .card {
        box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
        transition: 0.3s;
        width: 80%;
        padding: 10px;
        margin: 20px auto auto auto;
    }

    .card:hover {
        box-shadow: 0 8px 16px 0 rgba(0, 0, 0, 0.2);
    }

    .grid-container {
        display: grid;
        grid-template-columns: 16% 16% auto auto auto 16%;
        grid-gap: 10px;
        padding: 10px;
    }

    .grid-container > div {
        background-color: rgba(255, 255, 255, 0.8);
        text-align: center;
        padding: 20px 0;
        font-size: 25px;
    }

    .item1 {
        grid-column: 1 / 3;
    }

    .item2 {
        grid-column: 3 / 6;
    }

    .button {
        background-color: #f44336;;
        /* Green */
        border: none;
        color: white;
        padding: 15px 32px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 16px;
        margin: 4px 2px;
        cursor: pointer;
        -webkit-transition-duration: 0.4s;
        /* Safari */
        transition-duration: 0.4s;
        width: 70%;
        border-radius: 4px;
    }

    .button:hover {
        box-shadow: 0 12px 16px 0 rgba(0, 0, 0, 0.24), 0 17px 50px 0 rgba(0, 0, 0, 0.19);
    }

    li {
        list-style-type: none;
    }

    .fab-wrapper {
        position: fixed;
        right: 40px;
        top: 100px;
        z-index: 5;
        display: flex;
        flex-direction: center;
        align-items: center;

    }

    .fab-button {
        width: 70px;
        height: 70px;
        background-color: #FE7235;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        border-radius: 50%;
        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
        transition: all 0.1s ease-in-out;
    }

    .fab-button:hover {
        transform: scale(1.25);
        box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.3);
    }

    .fab-button p {
        font-size: 30px;
        color: #ffffff;
        text-align: center;
        line-height: 70px
    }
    .modal {
        border-radius: 20px;
        box-shadow: 0px 0px 49px 4px rgba(0,0,0,0.75);
        background-color: #333333;
        width: 400px;
        position: fixed;
        transform: translate(-50%, -50%);
        top: 50%;
        left: 50%;
        padding: 30px;
        z-index: 1;
    }

    input {
        margin: auto auto;
        width: 100%;
    }
</style>
