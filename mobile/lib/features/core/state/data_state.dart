import 'package:fpdart/fpdart.dart';

import '../error/error.dart';

typedef DataState<T> = Future<Either<Failure, T>>;
