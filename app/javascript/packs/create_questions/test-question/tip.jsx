import React from 'react';
import renderHTML from 'react-render-html';

const Tip = ({ index, content }) => (
  <div className="tip">
    <span>{index} DICA</span>
    { renderHTML(content) }
  </div>
)

export default Tip;
