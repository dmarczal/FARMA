import React from 'react';
import PropTypes from 'prop-types';

const TextField = ({
  value,
  name,
  id,
  onChange,
  label,
  col,
}) => (
  <div className={`input-field col ${col}`}>
    <input
      id={id}
      type="text"
      name={name}
      value={value}
      onChange={onChange}
    />
    <label htmlFor={id}>{label}</label>
  </div>
);

TextField.propTypes = {
  value:    PropTypes.string.isRequired,
  name:     PropTypes.string.isRequired,
  id:       PropTypes.string.isRequired,
  onChange: PropTypes.func.isRequired,
  label:    PropTypes.string.isRequired,
  col:      PropTypes.string.isRequired,
}

export default TextField;
