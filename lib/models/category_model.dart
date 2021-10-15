class CategoryModel{
  bool ? status;
  CateogryDataModel ? data;

  CategoryModel.fromJson(Map<String,dynamic>json)
  {
    status=json['status'];
    data=CateogryDataModel.fromJson(json['data']);
  }
}

class CateogryDataModel{

  int ? currentpage;
  List<DataModel> ? data=[];
  CateogryDataModel.fromJson(Map<String,dynamic>json)
  {
    currentpage=json['current_page'];
    json['data'].forEach((element)
    {
      data!.add(DataModel.fromJson(element));
    });
  }

}

class DataModel{
  int ? id;
  String ? name;
  String ? image;

  DataModel.fromJson(Map<String,dynamic>json)
  {
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }
}