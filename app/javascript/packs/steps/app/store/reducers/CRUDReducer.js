export default (
  state,
  action,
  item,
  types
) => {
  switch (action.type) {
    case types.LOAD:
      return {
        ...state,
        items: action.items,
      };
    case types.FORM:
      return {
        ...state,
        openForm: true,
        item: action.data,
      };
    case types.ERROR_SUBMIT:
      return {
        ...state,
        openForm: true,
        item: action.data,
      };
    case types.CLOSE_FORM:
      return {
        ...state,
        openForm: false,
        item,
      };
    default:
      return state;
  }
}
