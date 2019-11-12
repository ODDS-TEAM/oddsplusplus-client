import Vue from 'vue'
import App from './App.vue'
import VueResource from 'vue-resource'
import moment from 'moment'
import routes from './routes'
import VueRouter from 'vue-router';
import VueCookie from 'vue-cookie'
Vue.config.productionTip = false

Vue.use(VueResource);
Vue.use(VueRouter);
Vue.use(VueCookie);
import GAuth from 'vue-google-oauth2'
const gauthOption = {
  clientId: '822425732761-q99fsf9aue9kkf3d71dn6be83f6l45vq.apps.googleusercontent.com',
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

router.beforeEach((to, from, next) => {
  const requiresAuth = to
    .matched
    .some(record => record.meta.requiresAuth)
  var user =
    localStorage.getItem('userId') &&
    localStorage.getItem('email') &&
    localStorage.getItem('name') &&
    localStorage.getItem('imgURL');
  if (requiresAuth && !user) {
    // next('/prepare')
    // window.location.href = "/prepare"
  }
  next()
})

Vue.component('modal', require('./components/modal/Modal.vue').default);

new Vue({
  router,
  render: h => h(App),
}).$mount('#app')
