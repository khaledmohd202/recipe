abstract class Failure {
  final String message;
  const Failure(this.message);
}

class SupabaseFailure extends Failure {
  const SupabaseFailure(super.message);
}
