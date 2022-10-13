import 'dart:io';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final mediaFoldersProvider = StateProvider<List<Directory>>((ref) => []);
