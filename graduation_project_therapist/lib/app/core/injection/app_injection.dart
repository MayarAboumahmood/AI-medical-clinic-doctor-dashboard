import 'package:get_it/get_it.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/bloc/register_cubit/register_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/bloc/sign_in_cubit/sign_in_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/data_source/data_source/remot_data_source.dart';
import 'package:graduation_project_therapist_dashboard/app/features/auth/data_source/repository_imp/auth_repository_impl.dart';
import 'package:graduation_project_therapist_dashboard/app/features/block_and_report/bloc/block_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/block_and_report/data_source/data_sources/block_datasource.dart';
import 'package:graduation_project_therapist_dashboard/app/features/block_and_report/repository/block_repository_imp.dart';
import 'package:graduation_project_therapist_dashboard/app/features/bottom_navigation_bar/bloc/bottom_navigation_widget_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/bloc/chat_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/data_source/data_source.dart';
import 'package:graduation_project_therapist_dashboard/app/features/chat/repo/chat_repo.dart';
import 'package:graduation_project_therapist_dashboard/app/features/doctor_employment_requests/cubit/doctor_employment_requests_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/doctor_employment_requests/data_source/data_source/d_e_r_datasource.dart';
import 'package:graduation_project_therapist_dashboard/app/features/doctor_employment_requests/repo/doctor_employment_requests_repo.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_all_therapists/cubit/get_all_therapist_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_all_therapists/data_source/data_source/get_all_therapist_datasource.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_all_therapists/reposetory/get_all_therapist_repo.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_patients/cubit/get_patients_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_patients/data_source/data_source/get_patients_datasource.dart';
import 'package:graduation_project_therapist_dashboard/app/features/get_patients/reposetory/get_patients_repo.dart';
import 'package:graduation_project_therapist_dashboard/app/features/home_page/bloc/home_page_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/home_page/data_source/data_sources/home_page_datasource.dart';
import 'package:graduation_project_therapist_dashboard/app/features/home_page/repository/home_page_repository_imp.dart';
import 'package:graduation_project_therapist_dashboard/app/features/medical_description.dart/cubit/medical_description_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/medical_description.dart/data_source/data_source/m_d_data_source.dart';
import 'package:graduation_project_therapist_dashboard/app/features/medical_description.dart/repo/medical_description_repo.dart';
import 'package:graduation_project_therapist_dashboard/app/features/notification/data/data_source/notification_data_source.dart';
import 'package:graduation_project_therapist_dashboard/app/features/notification/data/repository_imp/get_notification_data_repo_imp.dart';
import 'package:graduation_project_therapist_dashboard/app/features/notification/presentaion/bloc/notification_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_requests/cubit/patient_requests_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_requests/data_source/data_source/patient_requests_datasource.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_requests/repo/patient_requests_repository.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_reservations/cubit/patient_reservations_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_reservations/data_source/data_source/patient_reservations_datasource.dart';
import 'package:graduation_project_therapist_dashboard/app/features/patient_reservations/repo/patient_reservations_repo.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/data/data_source/profile_data_source.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/data/edite_profile_repo.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/data/repository_imp/edit_profile_repo_imp.dart';
import 'package:graduation_project_therapist_dashboard/app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/registration_data_complete/cubit/registration_data_complete_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/registration_data_complete/data_sorce/r_d_c_data_sorce.dart';
import 'package:graduation_project_therapist_dashboard/app/features/registration_data_complete/repo/registration_data_complete_repo.dart';
import 'package:graduation_project_therapist_dashboard/app/features/user_profile/cubit/user_profile_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/user_profile/data_source/patient_profile_data_source.dart';
import 'package:graduation_project_therapist_dashboard/app/features/user_profile/repo/patient_profile_repo.dart';
import 'package:graduation_project_therapist_dashboard/app/features/video_call/bloc/video_call_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/features/wallet/cubit/wallet_cubit.dart';
import 'package:graduation_project_therapist_dashboard/app/features/wallet/data_source/data_source/wallet_datasource.dart';
import 'package:graduation_project_therapist_dashboard/app/features/wallet/repo/wallet_repo.dart';
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
  sl.registerLazySingleton<GetAllTherapistRepositoryImp>(
      () => GetAllTherapistRepositoryImp(sl()));
  sl.registerLazySingleton<ChatRepositoryImp>(() => ChatRepositoryImp(sl()));
  sl.registerLazySingleton<PatientsProfileRepositoryImp>(
      () => PatientsProfileRepositoryImp(sl()));
  sl.registerLazySingleton<BlockRepositoryImp>(() => BlockRepositoryImp(sl()));
  sl.registerLazySingleton<GetPatientsRepositoryImp>(
      () => GetPatientsRepositoryImp(sl()));
  sl.registerLazySingleton<MedicalDescriptionRepositoryImp>(
      () => MedicalDescriptionRepositoryImp(sl()));
  sl.registerLazySingleton<HomePageRepositoryImp>(
      () => HomePageRepositoryImp(sl()));
  sl.registerLazySingleton<WalletRepositoryImp>(
      () => WalletRepositoryImp(sl()));
  sl.registerLazySingleton<NotificationRepository>(
      () => NotificationRepositoryImplementation(sl()));
  sl.registerLazySingleton<EditProfileRepository>(
      () => EditProfileRepositoryImpl(sl()));
  sl.registerLazySingleton<RegistrationDataCompleteRepoIpm>(
      () => RegistrationDataCompleteRepoIpm(sl()));
  sl.registerLazySingleton<DoctoreEmploymentRequestRepositoryImp>(
      () => DoctoreEmploymentRequestRepositoryImp(sl()));
  sl.registerLazySingleton<PatientRequestsRepositoryImp>(
      () => PatientRequestsRepositoryImp(sl()));
  sl.registerLazySingleton<PatientReservationsRepositoryImp>(
      () => PatientReservationsRepositoryImp(sl()));

// Datasources

  sl.registerLazySingleton<BlockDataSource>(
      () => BlockDataSource(client: http.Client()));
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(client: http.Client()));
  sl.registerLazySingleton<ChatDataSource>(
      () => ChatDataSource(client: http.Client()));
  sl.registerLazySingleton<HomePageDataSource>(
      () => HomePageDataSource(client: http.Client()));
  sl.registerLazySingleton<PatientProfileDataSource>(
      () => PatientProfileDataSource(client: http.Client()));
  sl.registerLazySingleton<GetAllTherapistDataSource>(
      () => GetAllTherapistDataSource(client: http.Client()));
  sl.registerLazySingleton<GetPatientsDataSource>(
      () => GetPatientsDataSource(client: http.Client()));
  sl.registerLazySingleton<WalletDataSource>(
      () => WalletDataSource(client: http.Client()));
  sl.registerLazySingleton<DoctorEmploymentDataSource>(
      () => DoctorEmploymentDataSource(client: http.Client()));
  // sl.registerLazySingleton<GetMyTherapistDataSource>(
  //     () => GetMyTherapistDataSource(client: http.Client()));
  sl.registerLazySingleton<NotificationDataSource>(
      () => NotificationDataSourceImp(client: http.Client()));
  sl.registerLazySingleton<ProfileDataSource>(
      () => ProfileDataSourceImpl(client: http.Client()));
  sl.registerLazySingleton<RegistrationDataCompleteRemoteDataSource>(
      () => RegistrationDataCompleteRemoteDataSourceImp(client: http.Client()));
  sl.registerLazySingleton<PatientRequestsDataSource>(
      () => PatientRequestsDataSource(client: http.Client()));
  sl.registerLazySingleton<PatientReservationsDataSource>(
      () => PatientReservationsDataSource(client: http.Client()));
  sl.registerLazySingleton<MedicalDescriptionSource>(
      () => MedicalDescriptionSource(client: http.Client()));

// Bloc
  sl.registerFactory(() => SignInCubit(authRemoteDataSource: sl()));
  sl.registerFactory(() => RegisterCubit(authRemoteDataSource: sl()));
  sl.registerLazySingleton(
      () => GetAllTherapistCubit(getAllTherapistRepositoryImp: sl()));
  sl.registerLazySingleton(
      () => GetPatientsCubit(getPatientsRepositoryImp: sl()));
  sl.registerLazySingleton(() => WalletCubit(walletRepositoryImp: sl()));
  sl.registerLazySingleton(() => VideoCallBloc(chatRepositoryImp: sl()));
  sl.registerLazySingleton(() => ChatBloc(chatRepositoryImp: sl()));
  sl.registerLazySingleton(() => HomePageBloc(homePageRepositoryImp: sl()));
  sl.registerLazySingleton(() => DoctorEmploymentRequestsCubit(
      doctoreEmploymentRequestRepositoryImp: sl()));
  sl.registerFactory(
      () => PatientRequestsCubit(patientRequestsRepositoryImp: sl()));
  sl.registerLazySingleton(
      () => PatientReservationsCubit(patientReservationsRepositoryImp: sl()));
  sl.registerFactory(() =>
      RegistrationDataCompleteCubit(registrationDataCompleteRepoIpm: sl()));
  sl.registerFactory(() => ProfileBloc(editProfileRepositoryImpl: sl()));
  sl.registerLazySingleton(() => LanguageBloc());
  sl.registerFactory(() => GetUserDataBloc());
  sl.registerLazySingleton(() => BottomNavigationWidgetBloc());
  sl.registerLazySingleton(
      () => NotificationBloc(notificationRepository: sl()));
  sl.registerLazySingleton(() => BlockBloc(blockRepositoryImp: sl()));
  sl.registerLazySingleton(
      () => MedicalDescriptionCubit(medicalDescriptionRepositoryImp: sl()));
  sl.registerLazySingleton(
      () => UserProfileCubit(patientsProfileRepositoryImp: sl()));
  sl.registerLazySingleton(() => ThemeBloc());

// External

  sl.registerLazySingleton(() => NavigationService());
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => PrefService());
}
