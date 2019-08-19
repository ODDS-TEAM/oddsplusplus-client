
import CardList from './components/CardList.vue'
import Login from './components/Login.vue'
import Summary from './components/Summary.vue'
import MyItem from './components/MyItem.vue'
const routes = [
    { path: '/', component: CardList },
    { path: '/home', component: CardList },
    { path: '/login', component: Login },
    { path: '/summary', component: Summary },
    { path: '/myitem', component: MyItem }
];

export default routes;