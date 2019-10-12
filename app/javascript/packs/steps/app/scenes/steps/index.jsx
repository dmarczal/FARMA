import Steps from './Steps';
import { connect } from 'react-redux'
import { withRouter } from 'react-router-dom';
import {
  fetchSteps,
  formStep,
  closeForm,
  createStep,
  editStep,
} from '../../store/actions/steps';

const mapStateToProps = ({ steps }) => {
  return {
    steps: steps.items,
    isLoad: steps.isFetching,
    step: steps.item,
    openForm: steps.openForm,
  };
}

const mapDispatchToProps = dispatch => ({
  load () {
    dispatch(fetchSteps());
  },

  newStep () {
    dispatch(formStep());
  },

  closeStep () {
    dispatch(closeForm());
  },

  onSubmit (step) {
    if (step.id) {
      return dispatch(editStep(step));
    }

    dispatch(createStep(step));
  },
});

export default withRouter(connect(
  mapStateToProps,
  mapDispatchToProps
  )(Steps));
