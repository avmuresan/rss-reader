import _ from 'underscore';

import Api from '@application/api';

const methodFor = (feed) => {
  if (_.isUndefined(feed.id)) {
    return 'post';
  }

  return 'put';
};

const pathFor = (feed) => {
  if (_.isUndefined(feed.id)) {
    return '/feeds';
  }

  return `/feeds/${feed.id}`;
};

export default ({ commit }, { feed }) => {
  const method = methodFor(feed);
  const path = pathFor(feed);

  return Api[method](path, { feed: feed }).then((response) => {
    commit('update', response.data.feed);

    return response.data.feed;
  });
};
