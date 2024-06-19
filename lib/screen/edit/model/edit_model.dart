class EditModel {
  int? id;
  String? title, description, category, date;

  EditModel({this.id, this.title, this.description, this.category, this.date});

  factory EditModel.mapToModel(Map m1) {
    return EditModel(
        id: m1['id'],
        description: m1['description'],
        title: m1['title'],
        category: m1['category'],
        date: m1['date']);
  }
}
