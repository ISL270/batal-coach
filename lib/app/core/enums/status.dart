import 'package:btl/app/core/models/generic_exception.dart';
import 'package:equatable/equatable.dart';

sealed class Status extends Equatable {
  const Status();
  bool get isInitial => this is Initial;
  bool get isSuccess => this is Success;
  bool get isLoading => this is Loading;
  bool get isPageLoading => this is PageLoading;
  bool get isFailure => this is Failure;

  // TODO: fix sealed classes json serialization.
  static Status fromJson(Map<String, dynamic>? json) => const Initial();
}

final class Initial extends Status {
  const Initial();
  @override
  List<Object?> get props => [];
}

final class Success extends Status {
  const Success();
  @override
  List<Object?> get props => [];
}

final class Loading extends Status {
  const Loading();
  @override
  List<Object?> get props => [];
}

final class PageLoading extends Status {
  const PageLoading();
  @override
  List<Object?> get props => [];
}

final class Failure extends Status {
  final GenericException exception;
  const Failure(this.exception);

  @override
  List<Object?> get props => [exception];
}
