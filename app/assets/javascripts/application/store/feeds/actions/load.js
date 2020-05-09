import _ from 'underscore';

import { underscore } from '@application/lib/utils';
import Api from '@application/api';

const escapeParam = (param) => {
  return encodeURIComponent(param);
};

const buildParams = (payload) => {
  return Object.keys(payload).map((param) => {
    const key = underscore(param);
    const value = escapeParam(payload[param]);
    return `${key}=${value}`;
  }).join('&');
};

const buildPath = (payload) => {
  let path = '/feeds';

  if (_.isUndefined(payload)) {
    return path;
  }

  if (!_.isUndefined(payload.id)) {
    return `${path}/${payload.id}`;
  }

  return `${path}?${buildParams(payload)}`;
};

export default ({ commit }, payload) => {
  return Api.get(buildPath(payload)).then((response) => {
    if (!_.isUndefined(response.data.feeds)) {
      commit('set', response.data.feeds);
    }
    else if (!_.isUndefined(response.data.feed)) {
      commit('set', response.data.feed);
    }

    return response;
  });
};
