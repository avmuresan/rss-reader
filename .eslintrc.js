module.exports = {
  'env': {
    'browser': true,
    'es6': true,
    'node': true
  },
  'extends': [
    'eslint:recommended',
    'plugin:vue/essential'
  ],
  'parserOptions': {
    'sourceType': 'module'
  },
  'rules': {
    'indent': [
      'error',
      2
    ],
    'linebreak-style': [
      'error',
      'unix'
    ],
    'quotes': [
      'warn',
      'single'
    ],
    'semi': [
      'error',
      'always'
    ],
    'eqeqeq': [
      'warn',
      'always'
    ],
    'brace-style': [
      'warn',
      'stroustrup'
    ],
    'no-console': 0,
    'no-var': 'warn',
    'max-len': [
      'error',
      80
    ]
  },
  'overrides': [
    // Vue specific rules
    {
      'files': ['*.vue'],
      'rules': {
        'indent': 'off',
        'max-len': 'off',
        'vue/script-indent': ['warn', 2, {
          'baseIndent': 1
        }]
      }
    }
  ],
  'plugins': [
    'vue'
  ],
  'globals': {
    'require': true
  }
};
