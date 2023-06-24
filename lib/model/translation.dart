class Translation {
  String? en;
  String? pl;

  Translation({this.en, this.pl});

  Translation.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    pl = json['pl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en'] = this.en;
    data['pl'] = this.pl;
    return data;
  }
}