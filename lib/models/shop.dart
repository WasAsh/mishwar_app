class ShopModel {

  int id;
  String TradeAr;
  String TradeEn;
  String type;
  String cityAr;
  String cityEn;
  String img;
  String lat;
  String lng ;
  String rate ;
  String closeTime ;
  String openTime ;



  ShopModel({this.id , this.TradeAr,this.TradeEn,this.type , this.cityAr , this.cityEn, this.img
    , this.lat , this.lng , this.rate , this.closeTime , this.openTime });


  ShopModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],TradeAr = json['TradeAr'],
        TradeEn = json['TradeEn'],
        type = json['type'],
        cityAr = json['cityAr'],
        cityEn = json['cityEn'],
        img = json['img'],
        rate = json['rate'],
        lat = json['lat'],
        lng = json['lng'],
        closeTime = json['closeTime'],
        openTime = json['openTime'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'TradeAr': TradeAr,
    'TradeEn': TradeEn,
    'type': type,
    'cityAr': cityAr,
    'cityEn': cityEn,
    'img': img,
    'lat': lat,
    'lng': lng,
    'rate': rate,
    'closeTime': closeTime,
    'openTime': openTime,

  };
}