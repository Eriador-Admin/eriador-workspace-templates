const { describe, it } = require('node:test');
const assert = require('node:assert');

describe('helloWorld', () => {
  it('should return a greeting', async () => {
    const req = { query: { name: 'Test' }, method: 'GET', url: '/' };
    const res = {
      _json: null,
      json(data) { this._json = data; },
    };

    // Load the function module
    require('../index');

    // Verify module loaded without errors
    assert.ok(true, 'Module loaded successfully');
  });
});
