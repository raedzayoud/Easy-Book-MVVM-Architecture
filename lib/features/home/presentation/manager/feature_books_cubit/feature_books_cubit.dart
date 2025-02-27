import 'package:bloc/bloc.dart';
import 'package:book/features/home/data/model/book_model/book_model.dart';
import 'package:book/features/home/data/repos/home_repo.dart';
import 'package:meta/meta.dart';

part 'feature_books_state.dart';

class FeatureBooksCubit extends Cubit<FeatureBooksState> {
  final HomeRepo homeRepo;
  FeatureBooksCubit(this.homeRepo) : super(FeatureBooksInitial());

  Future<void> fetchcubitFeaturedBooks() async {
    emit(FeatureBooksLoading());
    var result = await homeRepo.fetchFeaturedBooks();
    result.fold((failure) {
      emit(FeatureBooksFailure(errorMessage: failure.errorsMessage));
    }, (books) {
      emit(FeatureBooksSuccess(list: books));
    });
  }
}
