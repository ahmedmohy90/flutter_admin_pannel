import 'package:admin_pannel/data/repositores/authentication/authentication_repository.dart';
import 'package:admin_pannel/features/shop/models/address_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AddressesRepository extends GetxController {
  static AddressesRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<List<AddressModel>> fetchUserAddresses(String userId) async {
    try {
      final result = await _db
          .collection('User')
          .doc(userId)
          .collection('Addresses')
          .get();
      return result.docs
          .map((doc) => AddressModel.fromDocumentSnapshot(doc))
          .toList();
    } catch (e) {
      throw 'Something went wrong, Try again later';
    }
  }

  Future<void> updateSelectedField(String addressId, bool selected) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      await _db
          .collection('User')
          .doc(userId)
          .collection('Addresses')
          .doc(addressId)
          .update({'selectedAddress': selected});
    } catch (e) {
      throw 'Something went wrong, Try again later';
    }
  }

  Future<String> addAdress(AddressModel address) async {
    try {
      final userId = AuthenticationRepository.instance.authUser!.uid;
      final currentAddress = await _db
          .collection('User')
          .doc(userId)
          .collection('Addresses')
          .add(address.toJson());
      return currentAddress.id;
    } catch (e) {
      throw 'Something went wrong, Try again later';
    }
  }
}
