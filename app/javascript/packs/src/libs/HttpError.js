export default class HttpError {
  constructor (message, status, data = {}) {
    this.message = message;
    this.data = data;
    this.status = status;
  }
}
