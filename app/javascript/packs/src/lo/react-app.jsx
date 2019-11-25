import React from 'react';
import ReactDOM from 'react-dom';
import Page from './app';

var el = document.getElementById('lo-app');

let type = el.dataset.type;
let teamId = el.dataset.teamId;
let lo = el.dataset.lo;
let userName = el.dataset.user;
let userImage = el.dataset.userImage;

ReactDOM.render(<Page
  type={type}
  teamId={teamId}
  loName={lo}
  userName={userName}
  userImage={userImage}
/>,
  el
);
