import _ from 'underscore';

import { clone } from '@application/lib/utils';


const state = {
  feeds: []
};

const mutations = {
  set(state, feeds) {
    if (!_.isArray(feeds)) {
      state.feeds.push(feeds);
    }
    else {
      state.feeds = clone(feeds);
    }
  },
  remove(state, feedId) {
    state.feeds = state.feeds.filter((feed) => {
      return feedId !== feed.id;
    });
  },
  update(state, feeds) {
    if (!_.isArray(feeds)) {
      feeds = [feeds];
    }

    // Remove existing records
    const ids = feeds.map(a => a.id);
    state.feeds = state.feeds.filter((feed) => {
      return ids.indexOf(feed.id) === -1;
    });

    // Add new records
    feeds.forEach((feed) => {
      state.feeds.push(clone(feed));
    });
  }
};

const actions = {
  ...require('./actions').default
};

const getters = {
  all(state) {
    return clone(state.feeds).sort((a, b) => {
      return a.title.localeCompare(b.title);
    });
  }
};

export default {
  namespaced: true,
  state,
  mutations,
  actions,
  getters
};
