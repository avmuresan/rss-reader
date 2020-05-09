import _ from 'underscore';
import Vue from 'vue';

import App from './components/app';
import router from './router';
import store from './store';

// Run initializers
const initializers = require.context('./initializers', true, /\.js$/);
initializers.keys().forEach((k) => {
  let initializer = initializers(k);
  if (_.isFunction(initializer)) {
    initializer();
  }
  else if (_.isFunction(initializer.default)) {
    initializer.default();
  }
});

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(App),
    router,
    store
  }).$mount();
  document.body.appendChild(app.$el);
});
