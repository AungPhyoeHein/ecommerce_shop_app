
import 'package:ecommerce_shop_app/core/widgets/dynamic_loader_widget.dart';
import 'package:flutter/material.dart';

extension WidgetExt on Widget {
  Widget loading(bool isLoading){
    return DynamicLoaderWidget(originalWidget: this, isLoading: isLoading);
  }
}