import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/location_service.dart';

// !for services
final locationServiceProvider = Provider((ref) => LocationService());
