import 'package:get_it/get_it.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/bloc/register_cubit/register_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/bloc/sign_in_cubit/sign_in_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/data_source/data_source/remot_data_source.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/data_source/repository_imp/auth_repository_impl.dart';
import 'package:graduation_project_therapist_dashboard/app/features/bottom_navigation_bar/bloc/bottom_navigation_widget_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/notification/data/data_source/notification_data_source.dart';
import 'package:graduation_project_therapist_dashboard/app/features/notification/data/repository_imp/get_notification_data_repo_imp.dart';
import 'package:graduation_project_therapist_dashboard/app/features/notification/presentaion/bloc/notification_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/data/data_source/profile_data_source.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/data/edite_profile_repo.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/data/repository_imp/edit_profile_repo_imp.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_blocs/theme_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_blocs/user_data_block/user_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../shared/shared_blocs/language_bloc.dart';
import '../service/navigation_service.dart';
import '../service/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;
final sls = GetIt.instance();

Future<void> init() async {
// Features - posts

// Usecases

  // sl.registerLazySingleton(() => Usecase(sl()));

// Repository
  sl.registerLazySingleton<AuthRepositoryImpl>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<NotificationRepository>(
      () => NotificationRepositoryImplementation(sl()));
  sl.registerLazySingleton<EditProfileRepository>(
      () => EditProfileRepositoryImpl(sl()));

// Datasources

  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(client: http.Client()));
  sl.registerLazySingleton<NotificationDataSource>(
      () => NotificationDataSourceImp(client: http.Client()));
  sl.registerLazySingleton<ProfileDataSource>(
      () => ProfileDataSourceImpl(client: http.Client()));

// Bloc
  sl.registerFactory(() => SignInCubit());
  sl.registerFactory(() => RegisterCubit());
  sl.registerFactory(() => ProfileBloc(editProfileRepositoryImpl: sl()));
  sl.registerLazySingleton(() => LanguageBloc());
  sl.registerFactory(() => GetUserDataBloc());
  sl.registerLazySingleton(() => BottomNavigationWidgetBloc());
  sl.registerLazySingleton(
      () => NotificationBloc(notificationRepository: sl()));
  sl.registerLazySingleton(() => ThemeBloc());

// External

  sl.registerLazySingleton(() => NavigationService());
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => PrefService());
}
