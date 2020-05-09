import Vue from 'vue';
import { BootstrapVue } from 'bootstrap-vue';

import App from './components/app';
import router from './router';

// Install BootstrapVue
Vue.use(BootstrapVue);

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(App),
    router
  }).$mount();
  document.body.appendChild(app.$el);
});
