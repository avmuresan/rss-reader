const BASE_PATH = '/api/';

export default (path, query = {}) => {
  let params = [];
  Object.keys(query).forEach((key) => {
    params.push(`${encodeURIComponent(key)}=${encodeURIComponent(query[key])}`);
  });

  if (params.length === 0) {
    return BASE_PATH + path.replace(/^\//, '');
  }

  return BASE_PATH + path.replace(/^\//, '') + '?' + params.join('&');
};
