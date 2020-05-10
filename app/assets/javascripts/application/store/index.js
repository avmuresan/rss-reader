import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex);

import articles from './articles';
import feeds from './feeds';

export default new Vuex.Store({
  strict: true,
  modules: {
    articles,
    feeds
  }
});
