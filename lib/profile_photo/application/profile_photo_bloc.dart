import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as p;
import 'package:sedigram/core/data/fire_storage.dart';
import 'package:sedigram/core/data/firestore_service.dart';
import 'package:sedigram/profile_photo/application/profile_photo_event.dart';
import 'package:sedigram/profile_photo/application/profile_photo_state.dart';
import 'package:sedigram/user/application/global_user_bloc.dart';
import 'package:uuid/uuid.dart';

class ProfilePhotoBloc extends Bloc<ProfilePhotoEvent, ProfilePhotoState> {
  final GlobalUserBloc globalUserBloc;
  final FirestoreService fireStoreService;
  final Uuid uuid;
  final FireStorage fireStorage;

  ProfilePhotoBloc({
    required this.globalUserBloc,
    required this.fireStoreService,
    required this.uuid,
    required this.fireStorage,
  }) : super(ProfilePhotoState.init()) {
    on((event, emit) async {
      if (event is ProfilePhotoSaveEvent) {
        emit(state.copyWith(isLoading: true));

        final extension = p.extension(event.imagePath);
        final randomId = uuid.v4();
        final uniqueRandomName = randomId + extension;

        final userId = globalUserBloc.state.user.userId;

        final imageUrl = await fireStorage.uploadImageFile(
          event.imagePath,
          uniqueRandomName,
          userId,
        );

        final currentUser = await fireStoreService.getUser(userId);
        final updatedUser = currentUser.copyWith(profilePicture: imageUrl);
        await fireStoreService.updateUser(updatedUser);
        emit(state.copyWith(isLoading: false));
      }
    });
  }
}
