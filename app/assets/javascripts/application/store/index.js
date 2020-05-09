import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex);

import feeds from './feeds';

export default new Vuex.Store({
  strict: true,
  modules: {
    feeds
  }
});
