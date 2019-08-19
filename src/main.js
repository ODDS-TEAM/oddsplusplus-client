import Vue from 'vue'
import App from './App.vue'
// import Login from './components/Login'
import VueResource from 'vue-resource'
import moment from 'moment'
import routes from './routes'
import VueRouter from 'vue-router';
Vue.config.productionTip = false
Vue.use(VueResource);
Vue.use(VueRouter);


Vue.filter('formatDate', function(value) {
  if (value) {
    return moment(String(value)).format('DD/MM/YYYY')
  }
});
const router = new VueRouter({routes});

new Vue({
  router,
  render: h => h(App)
  
}).$mount('#app')
