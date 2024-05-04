import 'package:provider/provider.dart';

import '../controllers/movies_widget_controller.dart';

final Provider<MoviesWidgetController> makeMoviesWidgetController =
    Provider<MoviesWidgetController>(
  create: (_) => MoviesWidgetController(),
);
