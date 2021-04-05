import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skills_test/model/vehicle_api_result_model.dart';
import 'package:flutter_skills_test/model/vehicle_model.dart';
import 'package:flutter_skills_test/services/vehicle_service.dart';

class Vehicles extends StatefulWidget {
  static String tag = "/vehicles";

  @override
  _VehicleState createState() => _VehicleState();
}

class _VehicleState extends State<Vehicles> {
  //final List<Vehicle> vehicleList = Vehicle.staticData();
  List<Cars> vehicleList = [];

  Future<List<Cars>> futurevehicleList;

  PageController controller = PageController();

  int pageChanged = 0;

  bool isEditable = false;

  @override
  void initState() {
    super.initState();

    futurevehicleList = VehicleServices.fetchVehicles();

    futurevehicleList.then((result) {
      setState(() {
        for (var i in result.take(10)) {
          vehicleList.add(i);
        }
      });
    });
  }

  void deleteVehicleItem() {
    setState(() {
      vehicleList.removeAt(pageChanged);

      if (pageChanged != 0) {
        pageChanged = pageChanged - 1;
      }

//vehicleList.removeWhere((element) => element.id == vehicleList[pageChanged].id);
    });
  }

  void movetoNext() {
    controller.nextPage(
        duration: Duration(milliseconds: 250), curve: Curves.linear);
  }

  void movetoPrev() {
    controller.previousPage(
        duration: Duration(milliseconds: 250), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Vehicles Catalog'),
        ),
        //Replace the body to implement your own screen design

        body: FutureBuilder(
            future: futurevehicleList,
            builder:
                (BuildContext context, AsyncSnapshot<List<Cars>> snapshot) {
              if (snapshot.hasData) {
                return vehicleList.length != 0
                    ? PageView(
                        controller: controller,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (index) {
                          setState(() {
                            pageChanged = index;
                          });
                          print(pageChanged);
                        },
                        children: vehicleList.map((it) {
                          return Container(
                            padding: const EdgeInsets.all(25.0),
                            child: Column(
                              children: [
                                Image.asset('assets/images/rangerover.png'),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                        alignment: Alignment.centerLeft,
                                        icon: const Icon(
                                            Icons.keyboard_arrow_left),
                                        onPressed: movetoPrev),
                                    IconButton(
                                        alignment: Alignment.centerRight,
                                        icon: const Icon(
                                            Icons.keyboard_arrow_right),
                                        onPressed: movetoNext),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Car Model',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    !isEditable
                                        ? Text(it.carModel)
                                        : Container(
                                            width: 100,
                                            child: TextFormField(
                                              initialValue: it.carModel,
                                            ))
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Colour',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    !isEditable
                                        ? Text(it.carColor)
                                        : Container(
                                            width: 100,
                                            child: TextFormField(
                                              initialValue: it.carColor,
                                            )),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Year',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    !isEditable
                                        ? Text(it.carModelYear.toString())
                                        : Container(
                                            width: 100,
                                            child: TextFormField(
                                              initialValue:
                                                  it.carModelYear.toString(),
                                            )),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('VIN',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    !isEditable
                                        ? Text(it.carVin)
                                        : Container(
                                            width: 100,
                                            child: TextFormField(
                                              initialValue: it.carVin,
                                            )),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Price',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    !isEditable
                                        ? Text(it.price)
                                        : Container(
                                            width: 100,
                                            child: TextFormField(
                                              initialValue: it.price,
                                            )),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Availability',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    !isEditable
                                        ? Text(it.availability.toString())
                                        : Container(
                                            width: 100,
                                            child: TextFormField(
                                              initialValue:
                                                  it.availability.toString(),
                                            )),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RaisedButton(
                                      onPressed: () {
                                        setState(() {
                                          isEditable = true;
                                        });
                                      },
                                      child: const Text('EDIT',
                                          style: TextStyle(fontSize: 20)),
                                      color: Colors.blue,
                                      textColor: Colors.white,
                                      elevation: 5,
                                    ),
                                    RaisedButton(
                                      onPressed: deleteVehicleItem,
                                      child: const Text('DELETE',
                                          style: TextStyle(fontSize: 20)),
                                      color: Colors.blue,
                                      textColor: Colors.white,
                                      elevation: 5,
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        }).toList(),
                      )
                    : Center(
                        child: Text('No Vehicles Found!!',
                            style: TextStyle(fontSize: 30.0)));
              } else if (snapshot.hasError) {
                return Text('Something went wrong...');
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
