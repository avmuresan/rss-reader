import { clone } from '@application/lib/utils';
import { compareDesc } from 'date-fns';

const state = {
  articles: []
};

const mutations = {
  set(state, articles) {
    state.articles = clone(articles);
  }
};

const actions = {
  ...require('./actions').default
};

const getters = {
  all(state) {
    return clone(state.articles).map((article) => {
      return { ...article, date: new Date(article.date) };
    }).sort((articleA, articleB) => compareDesc(articleA.date, articleB.date));
  }
};

export default {
  namespaced: true,
  state,
  mutations,
  actions,
  getters
};
