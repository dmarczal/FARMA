
export default class Http {
  constructor() {
    this.fetchInit = {
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      mode: 'cors',
      cache: 'default',
    }
  }

  dispatch(method, path, body, options) {
    let config = {...this.fetchInit, method, ...options};

    if (body) config.body = JSON.stringify(body);

    return fetch(path, config)
      .then((response) => {
        if (response.status == 400) throw(response);

        return response.json();
      });
  }

  get(path, options = {}) { return this.dispatch('get', path, null, options) }
  post(path, body, options = {}) { return this.dispatch('post', path, body, options) }
  put(path, body, options = {}) { return this.dispatch('put', path, body, options) }
  delete(path, options = {}) { return this.dispatch('delete', path, null, options) }
}
