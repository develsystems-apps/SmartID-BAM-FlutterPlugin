class SmartIdExample {
  String? data;
  String? channelId;
  String? username;

  SmartIdExample({this.data, this.channelId, this.username});

  SmartIdExample.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    channelId = json['channelId'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['channelId'] = this.channelId;
    data['username'] = this.username;
    return data;
  }
}
