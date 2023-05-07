import 'package:cancerrapp/Helper/Services/BaseController.dart';
import 'package:cancerrapp/Models/ReportsModel.dart';
import 'package:cancerrapp/Repositories/ReportRepositort.dart';

class ReporoController extends BaseController {
  Future<List<ReportModel>> GetAllReport() async {
    var reports = await ReportsRepositort().getAllByUser();
    return reports;
  }
}
