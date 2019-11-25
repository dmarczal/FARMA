import React from 'react';
import ReactDOM from 'react-dom';
import Page from './app';

var el = document.getElementById('lo-app');

let type = el.dataset.type;
let loId = el.dataset.loId;
let teamId = el.dataset.teamId;
let lo = el.dataset.lo;
let userName = el.dataset.user;
let userImage = el.dataset.userImage;
let page = el.dataset.page;

ReactDOM.render(<Page
  page={page}
  type={type}
  teamId={teamId}
  loId={loId}
  loName={lo}
  userName={userName}
  userImage={userImage}
/>,
  el
);
