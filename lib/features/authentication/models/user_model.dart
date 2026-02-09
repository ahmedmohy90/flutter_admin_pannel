import 'package:admin_pannel/features/shop/models/address_model.dart';
import 'package:admin_pannel/utils/formatters/formatter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/constants/enums.dart';
import '../../shop/models/order_model.dart';

class UserModel {
  final String id;
  String? fisrtName;
  String? lastName;
  String? email;
  String? userName;
  String? profilePicture;
  String? password;
  String? phoneNumber;
  AppRole? role;
  DateTime? createAt;
  DateTime? updateAt;
  List<OrderModel>? orders;
  List<AddressModel>? addresses ;

  UserModel({
    required this.id,
    this.fisrtName,
    this.lastName,
    this.email,
    this.userName,
    this.profilePicture,
    this.password,
    this.phoneNumber,
    this.role,
    this.createAt,
    this.updateAt,
  });

  // helper methods
  String get fullName => '$fisrtName $lastName';
  String get formattedData => TFormatter.formatDate(createAt);
  String get formattedUpdatedAt => TFormatter.formatDate(updateAt);
  String get formatedPhoneNumber {
    if (phoneNumber == null || phoneNumber!.isEmpty) return '';
    return TFormatter.formatPhoneNumber(phoneNumber!);
  }

  // STATIC FUN TO CREATE AN EMPTY USER Model
  static UserModel empty() => UserModel(email: '', id: '');

  Map<String, dynamic> toJson() {
    return {
      'FirstName': fisrtName,
      'LastName': lastName,
      'Email': email,
      'UserName': userName,
      'ProfilePicture': profilePicture,
      'Password': password,
      'PhoneNumber': phoneNumber,
      'Role': role,
      'CreateAt': createAt,
      'UpdateAt': updateAt
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    if (documentSnapshot.data() != null) {
      final data = documentSnapshot.data()!;
      return UserModel(
        id: documentSnapshot.id,
        fisrtName: data.containsKey('FirstName') ? data['FirstName'] ?? '' : '',
        lastName: data.containsKey('LastName') ? data['LastName'] ?? '' : '',
        email: data.containsKey('Email') ? data['Email'] ?? '' : '',
        userName: data.containsKey('UserName') ? data['UserName'] ?? '' : '',
        profilePicture: data.containsKey('ProfilePicture')
            ? data['ProfilePicture'] ?? ''
            : '',
        password: data.containsKey('Password') ? data['Password'] ?? '' : '',
        phoneNumber:
            data.containsKey('PhoneNumber') ? data['PhoneNumber'] ?? '' : '',
        role: data.containsKey('Role')
            ? AppRole.values.firstWhere(
                (e) => e.name == data['Role'],
                orElse: () => AppRole.user,
              )
            : AppRole.user,
        createAt: (data['CreateAt'] is Timestamp)
            ? (data['CreateAt'] as Timestamp).toDate()
            : DateTime.now(),
        updateAt: (data['UdatedAt'] is Timestamp)
            ? (data['UpdatedAt'] as Timestamp).toDate()
            : DateTime.now(),
      );
    } else {
      return UserModel.empty();
    }
  }
}
