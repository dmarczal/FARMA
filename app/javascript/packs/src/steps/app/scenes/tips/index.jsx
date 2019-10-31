import Tips from './Tips';
import { connect } from 'react-redux';
import { withRouter } from 'react-router-dom';

import {
  formTip,
  closeForm,
  editTip,
  createTip,
  fetchTips,
} from '../../store/actions/tips';

const mapStateToProps = ({ tips, requestLoad, steps }) => ({
  tip: tips.item,
  tips: tips.items,
  openForm: tips.openForm,
  isLoad: requestLoad.isFetching,
  step: steps.current,
});

const mapDispatchToProps = dispatch => ({
  load (stepId) {
    dispatch(fetchTips(stepId));
  },

  newTip () {
    dispatch(formTip());
  },

  closeTip () {
    dispatch(closeForm());
  },

  onSubmit (stepId, tip) {
    if (tip.id) {
      return dispatch(editTip(stepId, tip));
    }

    dispatch(createTip(stepId, tip));
  },
});

export default withRouter(
  connect(mapStateToProps, mapDispatchToProps)(Tips)
);
