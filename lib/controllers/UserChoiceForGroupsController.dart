class UserChoiceForGroupController {
  List<String> _selecterUsersIds = [];

  List<String> getSelectedUserIds() {
    return _selecterUsersIds;
  }

  addId(String userId) {
    _selecterUsersIds.add(userId);
  }

  removeId(String userId) {
    _selecterUsersIds.remove(userId);
  }

  bool containsId(String userId) {
    return _selecterUsersIds.contains(userId);
  }
}
