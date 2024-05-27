import 'package:uuid/uuid.dart';

String generateUniqueId() {
  const Uuid uuid = Uuid();

  String uniqueId = uuid.v4();

  return uniqueId;
}
