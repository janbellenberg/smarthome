import 'dart:developer';

import 'package:Smarthome/constants/api.dart';
import 'package:Smarthome/constants/colors.dart';
import 'package:Smarthome/constants/constants.dart';
import 'package:Smarthome/redux/actions.dart' as redux;
import 'package:Smarthome/redux/actions.dart';
import 'package:Smarthome/redux/store.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<dynamic> runApiService(Function() apiOperation,
    {bool isString = false}) async {
  // activate wait screen
  store.dispatch(new redux.Action(redux.ActionTypes.startTask));

  // perform api fetch
  dynamic result = await apiOperation();

  // check for error
  if (result.runtimeType == HTTPError) {
    if (IS_DEBUGGING) {
      log(result.toString());
    }

    if (result == HTTPError.CONNECTION_ERROR) {
      store.dispatch(new Action(ActionTypes.setOffline));
    } else {
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
    }

    store.dispatch(new redux.Action(redux.ActionTypes.stopTask));
    if (!store.state.setupDone) {
      if (result == HTTPError.NOT_AUTHORIZED) {
        // goto login screen, if application cannot load correctly
        store.dispatch(
          new redux.Action(redux.ActionTypes.updateSessionID, payload: null),
        );
      } else {
        // goto offline screen, if application cannot load correctly
        store.dispatch(
          new redux.Action(redux.ActionTypes.setOffline),
        );
      }
      store.dispatch(
        new redux.Action(redux.ActionTypes.setupDone),
      );
    }
    return null;
  }

  // disable wait screen
  store.dispatch(new redux.Action(redux.ActionTypes.stopTask));
  return result.runtimeType == String && !isString ? null : result;
}
