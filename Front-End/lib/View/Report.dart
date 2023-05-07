import 'package:cancerrapp/Controller/ReportController.dart';
import 'package:cancerrapp/Helper/Components/PrimaryText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReportView extends StatelessWidget {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    ReporoController reporoController = Get.put(ReporoController());
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: PrimaryText(
            text: "Patient Repots",
            color: Colors.white,
          )),
      body: FutureBuilder(
        future: reporoController.GetAllReport(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 1, childAspectRatio: 6),
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: PrimaryText(
                      text: "Report Date",
                      size: 17,
                      fontWeight: FontWeight.bold),
                  subtitle: PrimaryText(
                    text: DateFormat.yMMMMd().format(
                        snapshot.data?[index].reportDateTime ?? DateTime.now()),
                    size: 15,
                  ),
                  leading: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PrimaryText(
                          text: "Cancer Stage",
                          size: 17,
                          fontWeight: FontWeight.bold),
                      PrimaryText(
                          text:
                              "${snapshot.data?[index].cancerStage?.toUpperCase()}",
                          size: 15),
                    ],
                  ),
                  // trailing: PrimaryText(text: "text"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
