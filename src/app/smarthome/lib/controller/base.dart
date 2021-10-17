import 'dart:developer';

import 'package:Smarthome/constants/api.dart';
import 'package:Smarthome/constants/colors.dart';
import 'package:Smarthome/constants/constants.dart';
import 'package:Smarthome/redux/actions.dart' as redux;
import 'package:Smarthome/redux/store.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<Map<String, dynamic>?> performApiOperation(
  Function() apiOperation,
) async {
  // activate wait screen
  store.dispatch(new redux.Action(redux.ActionTypes.updateWaiting, true));

  // perform api fetch
  dynamic result = await apiOperation();

  // check for error
  if (result.runtimeType == HTTPError) {
    if (IS_DEBUGGING) {
      log(result.toString());
    }

    Fluttertoast.showToast(
      msg: errorDescription[result] ??
          "Es ist ein unbekannter Fehler aufgetreten",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: BLACK,
      textColor: WHITE,
      fontSize: 16.0,
    );

    store.dispatch(new redux.Action(redux.ActionTypes.updateWaiting, false));
    return null;
  }

  // disable wait screen
  store.dispatch(new redux.Action(redux.ActionTypes.updateWaiting, false));
  return result.runtimeType == String ? {} : result;
}
