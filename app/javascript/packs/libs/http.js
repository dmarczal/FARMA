
export default class Http {
  constructor() {
    this.fetchInit = {
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      mode: 'cors',
      cache: 'default',
      credentials: 'same-origin',
    }
  }

  dispatch(method, path, body, options) {
    let config = {...this.fetchInit, method, ...options};

    if (body) config.body = JSON.stringify(body);

    let fetchResponse = fetch(path, config)
      .then((response) => {
        if (response.status == 400) throw(response);

        return response.json();
      });

    return new Promise ((resolve, reject) => {
      fetchResponse.then(
        (response) => resolve(response),
        (error) => error.json().then((json) => reject(json))
      );
    });
  }

  get(path, options = {}) { return this.dispatch('get', path, null, options) }
  post(path, body, options = {}) { return this.dispatch('post', path, body, options) }
  put(path, body, options = {}) { return this.dispatch('put', path, body, options) }
  delete(path, options = {}) { return this.dispatch('delete', path, null, options) }
}
