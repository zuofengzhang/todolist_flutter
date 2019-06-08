class Item {
  int local_id;
  int uid;
  bool is_sync;
  String title;
  int state; // 0 未完成 1 已完成
  int create_time; // 创建时间

  Item(
      {this.local_id,
      this.uid,
      this.is_sync,
      this.title,
      this.state,
      this.create_time});

  Item.fromJson(Map<String, dynamic> json) {
    this.local_id = json['local_id'];
    this.uid = json['uid'];
    this.is_sync = json['is_sync'];
    this.title = json['title'];
    this.state = json['state'];
    this.create_time = json['create_time'];
  }

  Item.fromSql(Map<String, dynamic> json) {
    this.local_id = json['local_id'];
    this.uid = json['uid'];
    this.is_sync = json['is_sync'] == 'true';
    this.title = json['title'];
    this.state = json['state'];
    this.create_time = json['create_time'];
  }

  Map<String, dynamic> toJson() {
    var map = new Map<String, dynamic>();
    map['local_id']=this.local_id;
    map['uid']=this.uid;
    map['is_sync']=this.is_sync;
    map['title']=this.title;
    map['state']=this.state;
    map['create_time']=this.create_time;
    return map;
  }
}
