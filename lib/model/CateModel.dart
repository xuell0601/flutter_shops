
class CateModel {
  List<Message> message;
  Meta meta;

  CateModel({this.message, this.meta});

  CateModel.fromJson(Map<String, dynamic> json) {
    if (json['message'] != null) {
      message = new List<Message>();
      json['message'].forEach((v) {
        message.add(new Message.fromJson(v));
      });
    }
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.message != null) {
      data['message'] = this.message.map((v) => v.toJson()).toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    return data;
  }
}

class Message {
  int catId;
  String catName;
  int catPid;
  int catLevel;
  bool catDeleted;
  String catIcon;
  List<Children> children;

  Message(
      {this.catId,
        this.catName,
        this.catPid,
        this.catLevel,
        this.catDeleted,
        this.catIcon,
        this.children});

  Message.fromJson(Map<String, dynamic> json) {
    catId = json['cat_id'];
    catName = json['cat_name'];
    catPid = json['cat_pid'];
    catLevel = json['cat_level'];
    catDeleted = json['cat_deleted'];
    catIcon = json['cat_icon'];
    if (json['children'] != null) {
      children = new List<Children>();
      json['children'].forEach((v) {
        children.add(new Children.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cat_id'] = this.catId;
    data['cat_name'] = this.catName;
    data['cat_pid'] = this.catPid;
    data['cat_level'] = this.catLevel;
    data['cat_deleted'] = this.catDeleted;
    data['cat_icon'] = this.catIcon;
    if (this.children != null) {
      data['children'] = this.children.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Children {

  int catId;
  String catName;
  int catPid;
  int catLevel;
  bool catDeleted;
  String catIcon;
  List<Children> children;

  Children(
      {this.catId,
        this.catName,
        this.catPid,
        this.catLevel,
        this.catDeleted,
        this.catIcon});

  Children.fromJson(Map<String, dynamic> json) {
    catId = json['cat_id'];
    catName = json['cat_name'];
    catPid = json['cat_pid'];
    catLevel = json['cat_level'];
    catDeleted = json['cat_deleted'];
    catIcon = json['cat_icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cat_id'] = this.catId;
    data['cat_name'] = this.catName;
    data['cat_pid'] = this.catPid;
    data['cat_level'] = this.catLevel;
    data['cat_deleted'] = this.catDeleted;
    data['cat_icon'] = this.catIcon;
    return data;
  }
}

class Meta {
  String msg;
  int status;

  Meta({this.msg, this.status});

  Meta.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['status'] = this.status;
    return data;
  }
}