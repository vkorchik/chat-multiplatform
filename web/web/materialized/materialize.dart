import 'package:react/react.dart';

var materialButton = (Map<String, dynamic> props, dynamic children) => button(
    props
      ..addAll({
        "className": "waves-effect waves-light btn",
      }),
    children);

var materialTextarea = (Map<String, dynamic> props) => div(
      {
        'className': 'input-field',
      },
      textarea(props
        ..addAll({
          'className': 'materialize-textarea',
        })),
    );

var collection = (Map<String, dynamic> props, dynamic children) =>
    ul(props..addAll({'className': 'collection'}), children);

var collectionItem = (Map<String, dynamic> props, dynamic children) =>
    li(props..addAll({'className': 'collection-item'}), children);
