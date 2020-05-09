import axios from 'axios';
import _ from 'underscore';

import { camelize } from '@application/lib/utils';
import buildPath from './build_path';

const token = (() => {
  let el = document.querySelector('[name=csrf-token]');
  if (el) {
    return el.content;
  }
  return null;
})();

const request = (method, path, options = {}) => {
  console.log(method, path);

  const headers = {};
  if (token) {
    headers['X-CSRF-TOKEN'] = token;
  }
  
  let config = {
    ...options,
    url: path,
    method: method,
    headers: headers
  };

  return axios.request(config).then((response) => {
    if (_.isObject(response.data)) {
      response.data = camelize(response.data);
    }

    return response;
  });
};

export default {
  get(path, query = {}) {
    return request('GET', buildPath(path, query));
  },
  post(path, params = {}) {
    return request('POST', buildPath(path), {
      data: params
    });
  },
  put(path, params = {}) {
    return request('PUT', buildPath(path), {
      data: params
    });
  },
  delete(path, params = {}) {
    return request('DELETE', buildPath(path), {
      data: params
    });
  }
};

