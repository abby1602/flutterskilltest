class ApiResult {
  List<Cars> cars;

  ApiResult({this.cars});

  ApiResult.fromJson(Map<String, dynamic> json) {
    if (json['cars'] != null) {
      cars = new List<Cars>();
      json['cars'].forEach((v) {
        cars.add(new Cars.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cars != null) {
      data['cars'] = this.cars.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cars {
  int id;
  String car;
  String carModel;
  String carColor;
  int carModelYear;
  String carVin;
  String price;
  bool availability;

  Cars(
      {this.id,
      this.car,
      this.carModel,
      this.carColor,
      this.carModelYear,
      this.carVin,
      this.price,
      this.availability});

  Cars.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    car = json['car'];
    carModel = json['car_model'];
    carColor = json['car_color'];
    carModelYear = json['car_model_year'];
    carVin = json['car_vin'];
    price = json['price'];
    availability = json['availability'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['car'] = this.car;
    data['car_model'] = this.carModel;
    data['car_color'] = this.carColor;
    data['car_model_year'] = this.carModelYear;
    data['car_vin'] = this.carVin;
    data['price'] = this.price;
    data['availability'] = this.availability;
    return data;
  }
}
