import 'package:buddypay_digital_wallet/features/auth/domain/entity/auth_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'auth_hive_model.g.dart';

@HiveType(typeId: 0) // Assign a unique typeId for each model
class AuthHiveModel extends Equatable {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String fullname;

  @HiveField(2)
  final String phone;

  @HiveField(3)
  final String password;

  @HiveField(4)
  final String pin;

  @HiveField(5)
  final String device;

  // Constructor
  AuthHiveModel({
    String? userId,
    required this.fullname,
    required this.phone,
    required this.password,
    required this.pin,
    this.device = "mobile",
  }) : userId = userId ?? const Uuid().v4();

  // Initial Constructor
  const AuthHiveModel.initial()
      : userId = '',
        fullname = '',
        phone = '',
        password = '',
        pin = '',
        device = 'mobile';

  // From Entity
  factory AuthHiveModel.fromEntity(AuthEntity entity) {
    return AuthHiveModel(
      userId: entity.userId,
      fullname: entity.fullname,
      phone: entity.phone,
      password: entity.password,
      pin: entity.pin,
      device: entity.device,
    );
  }

  // To Entity
  AuthEntity toEntity() {
    return AuthEntity(
      userId: userId,
      fullname: fullname,
      phone: phone,
      password: password,
      pin: pin,
      device: device,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [userId, fullname, phone, password, pin, device];
}
