import React from 'react'
import {Provider} from 'react-redux'
import {BrowserRouter, Route} from 'react-router-dom'
import store from '../../lib/store.js'

class App extends React.Component {
  render(){
    return (
      <div className='app'>
        <Provider store={store}>
          <BrowserRouter>
            <div>
              <Route exact path='/' component={() => <p> hello world </p>} />
            </div>
          </BrowserRouter>
        </Provider>
      </div>
    )
  }
}

export default App
