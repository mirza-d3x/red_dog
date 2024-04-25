import 'dart:convert';

import 'package:reddog_mobile_app/models/acquisition_top_channels_model.dart';
import 'package:reddog_mobile_app/models/user_profile_model.dart';

import '../utilities/api_helpers.dart';

Resource<AcquisitionTopChannelsModel> getTopChannelApi(
    dynamic googleId,
    dynamic googleToken,
    dynamic viewId,
    dynamic fromDate,
    dynamic toDate
    ) {
  return Resource(
      url:
      'https://app.reddog.live/api/aquasition/channels/$googleId/$googleToken/$viewId/$fromDate/$toDate/true',
      body: json.encode({
        "googleId": googleId
      }),
      parse: (response) {
        Map<String, dynamic> topChannelResultMap = jsonDecode(response.body);
        AcquisitionTopChannelsModel topChannelResult = AcquisitionTopChannelsModel.fromJson(topChannelResultMap);
        return topChannelResult;
      });
}