import _ from 'underscore';

const camelize = (subject, firstUpperCased = false) => {
  if (!_.isString(subject)) {
    return subject;
  }

  let transformed = subject.replace(/[^A-Za-z0-9]+/g, ' ')
    .replace(/ ([A-Za-z0-9])/g, (m) => m[1].toUpperCase())
    .replace(/^([A-Z])/g, (m) => m[0].toLowerCase());

  if (firstUpperCased) {
    transformed = transformed.split('');
    transformed[0] = transformed[0].toUpperCase();
    transformed = transformed.join('');
  }

  return transformed;
};

const clone = (obj) => {
  if (_.isNull(obj) || _.isUndefined(obj)) {
    return obj;
  }
  return JSON.parse(JSON.stringify(obj));
};

const underscore = (subject) => {
  if (!_.isString(subject)) {
    return subject;
  }

  return subject
    .replace(/(?:([0-9a-z])([A-Z])|([a-zA-Z])([0-9]))/g, '$1$3 $2$4')
    .replace(/[ -]+/g, '_')
    .toLowerCase();
};

export { camelize, clone, underscore };
