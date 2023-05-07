import 'package:cancerrapp/Helper/Components/PrimaryText.dart';
import 'package:cancerrapp/Helper/Widgets/Loader.dart';
import 'package:cancerrapp/Helper/Widgets/MyTextField.dart';
import 'package:cancerrapp/View/DashBoard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../Controller/AppointmrntController.dart';
import '../Helper/Widgets/MyButton.dart';

class AppoinmentView extends StatefulWidget {
  const AppoinmentView({super.key});

  @override
  State<AppoinmentView> createState() => _AppoinmentViewState();
}

class _AppoinmentViewState extends State<AppoinmentView> {
  TextEditingController _dateController = TextEditingController();
  DateTime? selectedDate = null;
  DateTime? select;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate ?? DateTime.now(),
        // initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        select = picked;
        _dateController.text = DateFormat.yMMMMd().format(picked);
      });
  }

  @override
  Widget build(BuildContext context) {
    AppointmentController appointmentController =
        Get.put(AppointmentController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: PrimaryText(
          text: "Skin Specialists",
          color: Colors.white,
        ),
      ),
      body: FutureBuilder(
        future: appointmentController.GetAllDoctors(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loader();
          }
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, childAspectRatio: 3),
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Get.dialog(
                    PopUp(context, _selectDate, _dateController, select,
                        appointmentController, snapshot.data?[index].id),
                    barrierDismissible: false,
                  );
                },
                child: Card(
                  child: GridTileBar(
                    leading: Image.asset(
                      snapshot.data?[index].imagePath ?? "",
                      height: 80,
                    ),
                    title: PrimaryText(
                        text: "${snapshot.data?[index].name}",
                        size: 14,
                        fontWeight: FontWeight.w700),

                    subtitle: PrimaryText(
                      text:
                          "${snapshot.data?[index].specilist} \n ${snapshot.data?[index].hospitalName}",
                      size: 14,
                    ),
                    trailing: PrimaryText(
                        text: "${snapshot.data?[index].doctorDay} \n" +
                            "${snapshot.data?[index].doctorTiming}",
                        size: 14,
                        fontWeight: FontWeight.w700),
                    // leading: PrimaryText(text: "${snapshot.data?[index].name}"),

                    // title: PrimaryText(text: "${snapshot.data?[index].name}"),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

Widget PopUp(
    BuildContext context,
    Function _selectDate,
    TextEditingController _dateController,
    DateTime? select,
    AppointmentController appointmentController,
    int? doctorId) {
  return AlertDialog(
    title: PrimaryText(text: "Book Appointment"),
    actions: <Widget>[
      InkWell(
        onTap: () {
          _selectDate(context);
        },
        child: Container(
            // height: MediaQuery.of(context).size.height * .04,
            // margin: EdgeInsets.only(top: 30),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(5)),
            child: MyTextField(
              border: OutlineInputBorder(borderSide: BorderSide.none),
              enable: false,
              labelText: "Appoinment Date",
              controller: _dateController,
            )
            // TextFormField(
            //   style: TextStyle(fontSize: 40),
            //   textAlign: TextAlign.center,
            //   enabled: false,
            //   keyboardType: TextInputType.text,
            //   controller: _dateController,
            //   onSaved: (String? val) {
            //     // selectedDate.toString() = val;
            //   },
            //   decoration: InputDecoration(
            //       disabledBorder:
            //           UnderlineInputBorder(borderSide: BorderSide.none),
            //       contentPadding: EdgeInsets.only(top: 0.0)),
            // ),
            ),
      ),
      SizedBox(height: 10),
      Row(
        children: [
          Expanded(
            child: MyButton(
              bthWidth: 120,
              buttonName: "Appoinment",
              btnTextSize: 16,
              btnColor: Colors.lightBlue,
              onPressed: () async {
                var res = await appointmentController.SaveAppoinment(
                    doctorId!, select);
                if (res == true) {
                  _dateController.text = "";
                  _dateController.clear();
                  Get.to(() => DashboardView());
                }
              },
            ),
          ),
          Expanded(
            child: MyButton(
              bthWidth: 120,
              buttonName: "Close",
              btnColor: Colors.lightBlue,
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ],
      )
    ],
  );
}
