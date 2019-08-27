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
import GAuth from 'vue-google-oauth2'
const gauthOption = {
  clientId: '971106496644-4nae94isrfp8n4ef1dmkq54ocsqt5f3n.apps.googleusercontent.com',
  scope: 'profile email',
  prompt: 'select_account'
}
Vue.use(GAuth, gauthOption)

Vue.filter('formatDate', function (value) {
  if (value) {
    return moment(String(value)).format('DD/MM/YYYY')
  }
});
const router = new VueRouter({
  mode: 'history',
  routes
});

Vue.component('modal', require('./components/modal/Modal.vue').default);



new Vue({
  router,
  render: h => h(App),

}).$mount('#app')
