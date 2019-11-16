<template>
    <h1>Hello Scrapper</h1>
</template>
<script>
// import RequestPromise from '../../node_modules/request-promise'
import http from '../http-common'
import axios from '../../node_modules/axios'
// import fetch from '../../node_modules/node'
// import Puppeteer from '../../node_modules/puppeteer'
// import Osmosis from '../../node_modules/osmosis'
// import cheerio from '../../node_modules/cheerio'
export default {
    components: {
        // Scrapper
    },
    data() {
        return {
            url : "https://sutplan.com/"
            // url: "https://www.amazon.com/Animal-Farm-GEORGE-ORWELL/dp/9386538288/ref=tmm_pap_swatch_0?_encoding=UTF8&qid=1573527970&sr=8-1"
        };
    },
    methods: {
        fetchData (url) {
            http.get(http.baseURL).then(function(response) {
                console.log(response)
            })
            // console.log("In Scrapper ")
            // RequestPromise(url)
            // .then(function(html) {
            //     console.log("In Scrapper " + html)
            // })
            // .catch(function(err) {
            //     console.log(err)
            // })
            // Osmosis.get(url).set({heading: 'div', title: 'title'})
            // .data(item => 
            //     console.log(item));
            // cheerio(url).then(function(html) {
            //     return 
            // })
        },
    },
    mounted: function() {
        this.fetchData(this.url)
    }
}
</script>
<style scoped>

</style>