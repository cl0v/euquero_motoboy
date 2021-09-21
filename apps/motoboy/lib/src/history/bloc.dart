import 'package:core/core.dart';

import '../repository.dart';

class HistoryBloc extends SimpleBloc {
  Repository repository = Repository();
  final String uid;

  HistoryBloc(this.uid);

  
}
