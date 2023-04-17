import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_login/api/client.dart';
import 'package:flutter_bloc_login/api/models/api_response_model.dart';
import 'package:flutter_bloc_login/api/models/user.dart';

import 'signup_event.dart';
import 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final RestClient apiClient;

  SignupBloc({required this.apiClient}) : super(SignupInitial()) {
    on<SignupSubmitted>((event, emit) async {
      emit(SignupLoading());

      try {
        User user = User(
          firstName: event.email,
          lastName: "",
          email: event.email,
          phoneNumber: PhoneNumber(countryCode: "+974", number: "12345678"),
        );

        ApiResponse response = await apiClient.signUp(user);

        if (response.value.isNotEmpty) {
          emit(SignupSuccess());
        } else {
          emit(SignupFailure(error: "Login failed."));
        }
      } catch (error) {
        emit(SignupFailure(error: error.toString()));
      }
    });
  }
}
