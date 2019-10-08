import HttpError from './HttpError';

const baseOptions = {
  headers: {},
}

export const GET = 'GET';
export const POST = 'POST';
export const PUT = 'PUT';
export const PATCH = 'PATCH';
export const DELETE = 'DELETE';

export default class Http {
  constructor (basePath) {
    this.basePath = basePath;
    this.response = null;
  }

  async request (method, path, options) {
    let headers = {...options.headers}
    delete options.headers;

    let data = {
      method,
      credentials: 'include',
      headers: {
        'Content-Type': 'application/json',
        ...headers,
      },
      ...options,
    }

    this.response = await fetch(this.getPath(path), data);

    if (!this.response.ok) {
      let json = await this.response.json();

      throw new HttpError(
        'Request is not OK!',
        this.response.status,
        json
      );
    }
  }

  async sendRequest (method, path, options) {
    await this.request(method, path, options);
    return this.response.json();
  }


  async get (path, options = {...baseOptions}) {
    return this.sendRequest(GET, path, options);
  }

  async post (path, body = {}, options = {...baseOptions}) {
    return this.sendRequest(POST, path, {
      ...options,
      body: JSON.stringify(body),
    });
  }

  async put (path, body = {}, options = {...baseOptions}) {
    return this.sendRequest(PUT, path, {
      ...options,
      body: JSON.stringify(body),
    });
  }

  async patch (path, body = {}, options = {...baseOptions}) {
    return this.sendRequest(PATCH, path, {
      ...options,
      body: JSON.stringify(body),
    });
  }

  async delete (path, options = {...baseOptions}) {
    return this.sendRequest(DELETE, path, options);
  }

  getPath (path) {
    return this.basePath + path;
  }
}
