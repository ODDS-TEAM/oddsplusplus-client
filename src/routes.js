
import CardList from './components/CardList.vue'
import Callback from './components/Prepare.vue'
import Summary from './components/Summary.vue'
import MyItem from './components/MyItem.vue'
import MyOrder from './components/MyOrder'
const routes = [
    {
        path: '/', component: CardList
    },
    {
        path: '/home', component: CardList
    },
    { path: '/callback', component: Callback },
    {
        path: '/summary/:id', name: 'summary', component: Summary
    },
    {
        path: '/myitem', component: MyItem
    },
    {
        path: '/myorder', component: MyOrder
    },
    {
        path: '*', redirect: '/home'
    },
];

export default routes;