class PostsResponse {
  Posts? postsData;
  String? error;
  PostsResponse({this.postsData, this.error});
  PostsResponse.fromJson(Map<String, dynamic> json) {
    postsData = Posts.fromJson(json);
    error = null;
  }
  PostsResponse.withError(String error) {
    postsData = null;
    error = error;
  }
}

class Posts {
  bool? status;
  List<Data>? data;
  int? currentPage;
  int? pageSize;
  int? totalItems;
  int? totalPages;
  int? nextPage;
  int? previousPage;
  bool? hasMore;

  Posts(
      {this.status,
      this.data,
      this.currentPage,
      this.pageSize,
      this.totalItems,
      this.totalPages,
      this.nextPage,
      this.previousPage,
      this.hasMore});

  Posts.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    currentPage = json['currentPage'];
    pageSize = json['pageSize'];
    totalItems = json['totalItems'];
    totalPages = json['totalPages'];
    nextPage = json['nextPage'];
    previousPage = json['previousPage'];
    hasMore = json['hasMore'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['currentPage'] = currentPage;
    data['pageSize'] = pageSize;
    data['totalItems'] = totalItems;
    data['totalPages'] = totalPages;
    data['nextPage'] = nextPage;
    data['previousPage'] = previousPage;
    data['hasMore'] = hasMore;
    return data;
  }
}

class Data {
  int? id;
  String? title;
  String? body;
  String? image;

  Data({this.id, this.title, this.body, this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    data['image'] = image;
    return data;
  }
}
