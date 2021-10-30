import 'package:admin/src/pages/registration/state.dart';
import 'package:admin/src/repository.dart';
import 'package:core/core.dart';

class RegistrationController extends Bloc<RegistrationState> {
  final IRegistration repository;

  RegistrationController({
    required this.repository,
    required RegistrationState state,
  }) {
    add(state);
  }
}
