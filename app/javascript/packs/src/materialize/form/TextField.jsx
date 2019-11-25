import React from 'react';
import PropTypes from 'prop-types';

const TextField = ({
  value,
  name,
  id,
  onChange,
  label,
  col,
  errors,
}) => {
  errors = errors || [];
  let errorClass = '';
  let errorMessage = '';

  if (errors.length > 0) {
    errorMessage = <span className="help-block">{errors[0]}</span>
    errorClass = 'has-error';
  }

  return (
    <div className={`input-field col ${col} ${errorClass}`}>
      <input
        id={id}
        type="text"
        name={name}
        value={value}
        onChange={onChange}
      />
      <label htmlFor={id}>{label}</label>
      {errorMessage}
    </div>
  )
};

TextField.propTypes = {
  value:    PropTypes.any.isRequired,
  name:     PropTypes.string.isRequired,
  id:       PropTypes.string.isRequired,
  onChange: PropTypes.func.isRequired,
  label:    PropTypes.string.isRequired,
  col:      PropTypes.string.isRequired,
  errors:   PropTypes.array,
}

export default TextField;
