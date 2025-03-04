part of 'bottom_nav_bloc.dart';
abstract class BottomNavState {
  final int index;
  BottomNavState(this.index);
}

class BottomNavInitial extends BottomNavState {
  BottomNavInitial() : super(0);
}

class BottomNavUpdated extends BottomNavState {
  BottomNavUpdated(int index) : super(index);
}
