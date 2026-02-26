// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';

// class ImageState {
//   XFile? imageFile;

//   ImageState({this.imageFile});

//   ImageState copyWith({XFile? imageFile}) =>
//       ImageState(imageFile: imageFile); //  자기를 부르는 재귀함수, 메모리가 늘어나지 않는다.
// }

// class ImageNotifier extends Notifier<ImageState> {
//   final ImagePicker picker = ImagePicker();

//   @override
//   ImageState build() => ImageState();

//   Future<void> getImageFromGallery(ImageSource source) async {
//     final pickedFile = await picker.pickImage(source: source);
//     if (pickedFile != null) {
//       state = ImageState(imageFile: pickedFile);
//     }
//   }

//   void clearImage() {
//     state = ImageState();
//   }
// } //  ImageNotifier

// final imageNotifierProvider = NotifierProvider<ImageNotifier, ImageState>(
//   ImageNotifier.new,
// );
