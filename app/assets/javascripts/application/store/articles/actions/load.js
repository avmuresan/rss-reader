import _ from 'underscore';

import Api from '@application/api';

export default ({ commit }) => {
  return Api.get('/articles').then((response) => {
    if (!_.isUndefined(response.data.articles)) {
      commit('set', response.data.articles);
    }

    return response;
  });
};
