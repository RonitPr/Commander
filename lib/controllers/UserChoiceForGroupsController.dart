class UserChoiceForGroupController {
  List<String> _selecterUsersIds = [];

  getSelectedUserIds() {
    return _selecterUsersIds;
  }

  addId(String userId) {
    _selecterUsersIds.add(userId);
  }

  removeId(String userId) {
    _selecterUsersIds.remove(userId);
  }

  containsId(String userId) {
    return _selecterUsersIds.contains(userId);
  }
}
