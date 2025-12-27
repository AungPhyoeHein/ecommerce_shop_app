import 'package:country_picker/country_picker.dart';
import 'package:ecommerce_shop_app/core/extensions/context_extension.dart';
import 'package:ecommerce_shop_app/core/extensions/string_extensions.dart';
import 'package:ecommerce_shop_app/core/extensions/widget_extension.dart';
import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:ecommerce_shop_app/core/utils/core_utils.dart';
import 'package:ecommerce_shop_app/core/widgets/input_field.dart';
import 'package:ecommerce_shop_app/core/widgets/rounded_button.dart';
import 'package:ecommerce_shop_app/core/widgets/vertical_label_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gap/gap.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final countryController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final obsecurePasswordNotifier = ValueNotifier(true);
  final obseureConfirmPasswordNotifier = ValueNotifier(true);

  final countryNotifier = ValueNotifier<Country?>(null);

  void pickCountry() {
    showCountryPicker(
      context: context,
      countryListTheme: CountryListThemeData(
        backgroundColor: CoreUtils.adaptiveColor(
          context,
          lightModeColor: MyColors.darkThemeDarkSharpColor,
          darkModeColor: MyColors.lightThemeTintStockColour,
        ),
        textStyle: TextStyle(color: MyColors.classicAdaptiveTextColor(context)),
        searchTextStyle: TextStyle(
          color: MyColors.classicAdaptiveTextColor(context),
        ),
        inputDecoration: InputDecoration(
          labelText: 'Search',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
          labelStyle: TextStyle(
            color: MyColors.classicAdaptiveTextColor(context),
          ),
          floatingLabelStyle: TextStyle(color: MyColors.lightThemePrimaryColor),
        ),
      ),

      onSelect: (country) {
        if (country != countryNotifier.value) countryNotifier.value = country;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    countryNotifier.addListener(() {
      if (countryNotifier.value == null) {
        phoneController.clear();
        countryController.clear();
      } else {
        countryController.text =
            '${countryNotifier.value!.flagEmoji} +${countryNotifier.value!.phoneCode}';
      }
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    obsecurePasswordNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          VerticalLabelField(
            'Name',
            controller: nameController,
            hintText: 'Enter your name',
            keyboardType: TextInputType.name,
          ),
          const Gap(20),

          VerticalLabelField(
            'Email',
            controller: emailController,
            hintText: 'Enter your email',
            keyboardType: TextInputType.emailAddress,
            defaultValidation: false,
            validator: (value) {
              if (value == null || value == '' || value.isEmpty) {
                return "Required Field.";
              }
              if (!value.isValidateEmail) {
                return "Invalid Email";
              }
              return null;
            },
          ),
          const Gap(20),

          ValueListenableBuilder(
            valueListenable: countryNotifier,
            builder: (context, country, child) => VerticalLabelField(
              'Phone',
              controller: phoneController,
              hintText: 'Enter your phone number',
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (countryController.text.isEmpty) {
                  return 'Pick a country.';
                }

                if (!isPhoneValid(
                  value!,
                  defaultCountryCode: country?.countryCode,
                )) {
                  return 'Invalid Phone number';
                }
                return null;
              },
              inputFormatter: [
                PhoneInputFormatter(
                  defaultCountryCode: country?.countryCode,
                  allowEndlessPhone: true,
                ),
              ],
              mainFieldFlex: 2,
              prefix: InputField(
                controller: countryController,
                readOnly: true,
                contentPadding: const EdgeInsets.only(left: 5),
                suffixIconConstraints: BoxConstraints(
                  maxWidth: context.width * .10,
                ),
                suffixIcon: GestureDetector(
                  onTap: pickCountry,
                  child: const Icon(
                    Icons.arrow_drop_down,
                    color: MyColors.lightThemePrimaryColor,
                  ),
                ),
                defaultValidation: false,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !isPhoneValid(
                        phoneController.text,
                        defaultCountryCode: country?.countryCode,
                      )) {
                    return '';
                  }
                  return null;
                },
              ),
            ),
          ),
          const Gap(20),
          ValueListenableBuilder(
            valueListenable: obsecurePasswordNotifier,
            builder: (context, obscurePassword, child) {
              return VerticalLabelField(
                'Password',
                controller: passwordController,
                hintText: 'Enter your password',
                keyboardType: TextInputType.visiblePassword,
                obscureText: obscurePassword,
                suffixIcon: GestureDetector(
                  onTap: () {
                    obsecurePasswordNotifier.value =
                        !obsecurePasswordNotifier.value;
                  },
                  child: Icon(
                    obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: MyColors.lightThemePrimaryTint,
                  ),
                ),
              );
            },
          ),
          const Gap(20),
          ValueListenableBuilder(
            valueListenable: obseureConfirmPasswordNotifier,
            builder: (context, obscureConfirmPassword, child) {
              return VerticalLabelField(
                'Confirm Password',
                controller: confirmPasswordController,
                hintText: 'Re-enter your password.',
                keyboardType: TextInputType.visiblePassword,
                obscureText: obscureConfirmPassword,
                validator: (value) {
                  if (value! != passwordController.text.trim()) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                suffixIcon: GestureDetector(
                  onTap: () {
                    obseureConfirmPasswordNotifier.value =
                        !obseureConfirmPasswordNotifier.value;
                  },
                  child: Icon(
                    obscureConfirmPassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: MyColors.lightThemePrimaryTint,
                  ),
                ),
              );
            },
          ),
          // const Gap(20),
          // SizedBox(
          //   width: double.maxFinite,
          //   child: Align(
          //     alignment: Alignment.centerRight,
          //     child: GestureDetector(
          //       onTap: () {},
          //       child: Text(
          //         'ForgotPassword',
          //         style: TextStyles.paragraphSubTextRegular1.primary,
          //       ),
          //     ),
          //   ),
          // ),
          const Gap(40),
          RoundedButton(
            text: 'Sign Up',
            onPressed: () {
              if (formKey.currentState!.validate()) {}
            },
            height: 50,
          ).loading(false),
        ],
      ),
    );
  }
}
