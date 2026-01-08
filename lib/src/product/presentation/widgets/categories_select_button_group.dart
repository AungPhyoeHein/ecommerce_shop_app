import 'package:ecommerce_shop_app/core/extensions/text_style_extension.dart';
import 'package:ecommerce_shop_app/core/res/styles/text.dart';
import 'package:ecommerce_shop_app/src/category/presentation/app/adapter/category_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_button/group_button.dart';

const _height = 90.0;

class CategoriesSelectButtonGroup extends StatelessWidget {
  const CategoriesSelectButtonGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (BuildContext context, state) {
        if (state is GotCategories) {
          if (state.categories.isEmpty) {
            return SizedBox(
              height: _height,
              child: Center(
                child: Center(
                  child: Text(
                    "Category is Empty.",
                    style: TextStyles.paragraphRegular.adaptiveColor(context),
                  ),
                ),
              ),
            );
          }
          return GroupButton(
            isRadio: true,

            options: GroupButtonOptions(
              borderRadius: BorderRadius.circular(10),
              mainGroupAlignment: MainGroupAlignment.start,
            ),

            onSelected: (value, index, isSelected) {},
            buttons: state.categories.map((category) => category.name).toList(),
          );
        }

        return SizedBox(
          height: _height,
          child: Center(
            child: Text(
              "Unknown Error",
              style: TextStyles.paragraphRegular.adaptiveColor(context),
            ),
          ),
        );
      },
    );
  }
}
