import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:scheduler_app/store/actions/locale.action.dart';
import 'package:scheduler_app/store/reducers/reducer.dart';
import 'package:scheduler_app/utils/localization.dart';

class LocaleSelector extends StatefulWidget {
  LocaleSelector({Key key, this.title}) : super(key: key);

  final String title;
  @override
  LocaleSelectorState createState() => new LocaleSelectorState();
}

class LocaleSelectorState extends State<LocaleSelector> {
  @override
  void initState() {
    super.initState();
  }

  void _switchLocale(String index) {
    Localization.setLocale(index);
  }

  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map>(converter: (store) {
      return {
        'setLang': (lang) {
          store.dispatch(SetLocale(lang));
        },
      };
    }, builder: (context, state) {
      var setLoc = state['setLang'];
      return Center(
          child: PopupMenuButton(
        icon: Icon(Icons.language, color: Colors.white),
        onSelected: (action) {
          action == 'RU' ? _switchLocale('ru') : _switchLocale('en');
          setLoc(action);
        },
        itemBuilder: (BuildContext context) {
          return ['RU', 'EN'].map((choice) {
            return PopupMenuItem(
              value: choice,
              child: Text(choice),
            );
          }).toList();
        },
      ));
    });
  }
}
