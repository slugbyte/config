import {createStore, applyMiddleware} from 'redux'
import reducer from '../reducer'

const thunk = store => next => action => 
  typeof action === 'function' ?
    action(store.dispatch, store.getState) :
    next(action)

const log = __DEBUG__ ? console.log : () => {}
const logger = store => next => action => {
  log('__ACTION__', action)
  let result = next(action) 
  log('__STATE__', store.getState())
  return result
}

export default createStore(reducer, applyMiddleware(thunk, logger))
