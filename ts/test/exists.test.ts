
import { test, describe } from 'node:test'
import { equal } from 'node:assert'


import { JmespathFreeSDK } from '..'


describe('exists', async () => {

  test('test-mode', () => {
    const testsdk = JmespathFreeSDK.test()
    equal(testsdk instanceof JmespathFreeSDK, true,
      'JmespathFreeSDK.test() must return a client synchronously')
  })

})
