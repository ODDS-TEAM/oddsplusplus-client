
import CardList from './components/CardList.vue'
import Login from './components/Login.vue'

const routes = [
    { path: '/', component: CardList },
    { path: '/home', component: CardList },
    { path: '/login', component: Login }
];

export default routes;