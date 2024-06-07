import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:graduation_project_therapist_dashboard/app/features/registration_data_complete/data_sorce/models/complete_register_model.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/select_state_drop_down.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';
import 'package:http_parser/http_parser.dart';
import 'package:graduation_project_therapist_dashboard/app/core/server/server_config.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class RegistrationDataCompleteRemoteDataSource {
  Future<Response> completeRegister(
    CompleteRegisterModel completeRegisterModel,
  );
}

class RegistrationDataCompleteRemoteDataSourceImp
    implements RegistrationDataCompleteRemoteDataSource {
  http.Client client;
  RegistrationDataCompleteRemoteDataSourceImp({
    required this.client,
  });

  @override
  Future<Response> completeRegister(
    CompleteRegisterModel completeRegisterModel,
  ) async {
    String token = sharedPreferences!.getString('token') ?? '';
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(ServerConfig.url + ServerConfig.completeRegister),
    );

    request.headers.addAll(
      {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers":
            "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "POST, OPTIONS",
        'Authorization': token
      },
    );
    bool isDoctor = sharedPreferences!.getString('doctorOrTherapist') == '1';
    if (completeRegisterModel.userLatLng != null && isDoctor) {
      request.fields['latitude'] =
          completeRegisterModel.userLatLng!.latitude.toString();
      request.fields['longitude'] =
          completeRegisterModel.userLatLng!.longitude.toString();
    }
    if (isDoctor) {
      request.fields['clinicName'] = completeRegisterModel.clinicName!;
      request.fields['cityId'] =
          getCityId(completeRegisterModel.selectedCity!).toString();
      request.fields['address'] =
          getCityId(completeRegisterModel.locationInfo!).toString();
    }
    List<int> listOFMedicalSpecialtyID = [];
    for (String medicalSpecialty
        in completeRegisterModel.selectedMedicalSpecialty) {
      listOFMedicalSpecialtyID.add(getSpecialtyId(medicalSpecialty));
    }
    request.fields['categories'] = listOFMedicalSpecialtyID.join(',');

    // Add image if available
    for (Uint8List? imageBytes in completeRegisterModel.certificationImages) {
      if (imageBytes != null) {
        request.files.add(
          http.MultipartFile.fromBytes('doc', imageBytes,
              filename: 'doc', contentType: MediaType('image', 'jpeg')),
        );
      }
    }

    // Send the request
    final response = await request.send();

    final responseBody = await response.stream.bytesToString();
    debugPrint('error in datasource data complete: $responseBody');
    debugPrint('error in datasource data complete: ${response.statusCode}');

    if (response.statusCode != 500) {
      return http.Response(responseBody, response.statusCode);
    } else {
      return http.Response('Server Error', response.statusCode);
    }
  }
}
