import Vue from 'vue';
import VueRouter from 'vue-router';

import Home from '@application/pages/home';
import Feeds from '@application/pages/feeds';

Vue.use(VueRouter);

const routes = [
  { path: '/home', component: Home },
  { path: '/feeds', component: Feeds.all },
  { path: '*',  component: Home, redirect: '/home' }
];

const router = new VueRouter({
  mode: 'history',
  routes: routes
});

export default router;
