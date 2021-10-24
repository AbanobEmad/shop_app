import 'package:shop/models/product_model.dart';

class ProductOfCategoryModel {
  bool ? status;
  String ? message;
  Data ? data;

  ProductOfCategoryModel({this.status, this.message, this.data});

  ProductOfCategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  int ? currentPage;
  List<ProductModel> ? data=[];
  String ? firstPageUrl;
  int ? from;
  int ? lastPage;
  String ? lastPageUrl;
  String ? path;
  int ? perPage;
  int ? to;
  int ? total;

  Data(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.path,
        this.perPage,
        this.to,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data!.add(new ProductModel.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }
}
