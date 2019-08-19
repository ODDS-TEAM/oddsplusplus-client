
import CardList from './components/CardList.vue'
import Login from './components/Login.vue'
import Summary from './components/Summary.vue'
const routes = [
    { path: '/', component: CardList },
    { path: '/home', component: CardList },
    { path: '/login', component: Login },
    { path: '/summary', component: Summary}
];

export default routes;