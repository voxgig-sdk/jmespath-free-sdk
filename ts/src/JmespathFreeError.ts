
import { Context } from './Context'


class JmespathFreeError extends Error {

  isJmespathFreeError = true

  sdk = 'JmespathFree'

  code: string
  ctx: Context

  constructor(code: string, msg: string, ctx: Context) {
    super(msg)
    this.code = code
    this.ctx = ctx
  }

}

export {
  JmespathFreeError
}

