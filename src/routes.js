
import CardList from './components/CardList.vue'
import Prepare from './components/Prepare.vue'
import Summary from './components/Summary.vue'
import MyItem from './components/MyItem.vue'
import MyOrder from './components/MyOrder'
const routes = [
    {
        path: '/', component: CardList, meta: { requiresAuth: true }

    },
    {
        path: '/home', component: CardList, meta: { requiresAuth: true }

    },
    {
        path: '/prepare', component: Prepare
    },
    {
        path: '/summary/:id', name: 'summary', component: Summary, meta: { requiresAuth: true }

    },
    {
        path: '/myitem', component: MyItem, meta: { requiresAuth: true }

    },
    {
        path: '/myorder', component: MyOrder, meta: { requiresAuth: true }

    },
    {
        path: '*', redirect: '/home', meta: { requiresAuth: true }

    },
];

export default routes;