import React from 'react'
import ReactDom from 'react-dom'
import App from './component/app'
import {Provider} from 'react-redux'
import storeCreate from './lib/store-create'

let AppContainer = () => (
  <Provider store={storeCreate()}>
    <App/>
  </Provider>
)

ReactDom.render( <AppContainer/> , document.getElementById('root'))
