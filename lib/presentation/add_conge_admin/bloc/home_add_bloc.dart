import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_add_event.dart';
part 'home_add_state.dart';

class HomeAddBloc extends Bloc<HomeAddEvent, HomeAddState> {
  HomeAddBloc() : super(HomeAddInitial()) {
    on<HomeAddEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
