import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sedigram/profile_photo/application/profile_photo_event.dart';
import 'package:sedigram/profile_photo/application/profile_photo_state.dart';

class ProfilePhotoBloc extends Bloc<ProfilePhotoEvent, ProfilePhotoState> {
  ProfilePhotoBloc() : super(ProfilePhotoState.init()) {
    on((event, emit) {
      if (event is ProfilePhotoInitEvent) {}
    });
  }
}

abstract class Switchable {
  void turnOn();
}

class LightBulb implements Switchable {
  void turnOn() {
    // Code to turn on the light bulb
  }
}

class Fan implements Switchable {
  void turnOn() {
    // Code to turn on the fan
  }
}

class Switch {
  Switchable device;

  Switch(this.device);

  void operate() {
    device.turnOn();
  }
}

void main() {
  Switchable bulb = LightBulb();
  Switchable fan = Fan();

  Switch myBulbSwitch = Switch(bulb);
  myBulbSwitch.operate();

  Switch myFanSwitch = Switch(fan);
  myFanSwitch.operate();
}
