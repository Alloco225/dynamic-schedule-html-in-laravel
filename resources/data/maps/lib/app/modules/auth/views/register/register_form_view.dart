import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app/modules/auth/controller/auth_controller.dart';
import '/app/modules/auth/controller/auth_form_controller.dart';

import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:ici/app/widgets/forms.dart';

class RegisterFormView extends StatelessWidget {
  const RegisterFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// ? Controller
    ///
    AuthFormController _authFormController = Get.find();

    /// ? Opens terms and conditions webpage
    ///
    _openTerms() async {
      debugPrint(">> openTerms ");
    }

    return Obx(
      () => Column(
        // direction: Axis.vertical,
        children: [
          // Nom
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeOut,
            child: ValidatedInputLabel(
                text: "Nom prénoms", error: _authFormController.nameError),
          ),
          InputFormView(
            hintText: "Nom",
            textStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            textEditingController: _authFormController.nameController,
            focusNode: _authFormController.nameFocusNode,
            keyboardType: TextInputType.name,
            // onChanged: (_) => _authFormController.onChanged(_, _nameController),
            // onEditingComplete: () => _authFormController.onEditingComplete(_nameController),
            // onSubmitted: (_) => _authFormController.onSubmitted(_, _nameController),
            onChanged: _authFormController.onNameChanged,
            onEditingComplete: _authFormController.onNameEditingComplete,
            onSubmitted: _authFormController.onNameSubmitted,
          ),

          /// ? Phone number
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeOut,
            child: ValidatedInputLabel(
                text: "Numéro de téléphone",
                error: _authFormController.phoneError),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            child: InternationalPhoneNumberInput(
              onInputChanged: _authFormController.onPhoneChanged,
              onFieldSubmitted: _authFormController.onPhoneSubmitted,
              selectorConfig: const SelectorConfig(
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
              ),
              ignoreBlank: false,
              autoValidateMode: AutovalidateMode.disabled,
              selectorTextStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              initialValue: _authFormController.number,
              textFieldController: _authFormController.phoneController,
              focusNode: _authFormController.phoneFocusNode,
              // formatInput: false,
              keyboardType: const TextInputType.numberWithOptions(
                signed: true,
              ),
              inputBorder: InputBorder.none,
              textStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          /// * // ? Terms n conditions
          const Spacer(),

          /// ?
          ///
          AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            opacity: _authFormController.termsAccepted ? 0 : 1,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 0, 10),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeOut,
                child: ValidatedInputLabel(
                    text: null, error: _authFormController.termsError),
              ),
            ),
          ),
          InkWell(
            onTap: _openTerms,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
              child: Flex(
                direction: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: _authFormController.toggleTerms,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: _authFormController.termsAccepted
                            ? null
                            : Colors.blueGrey.shade100,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: _authFormController.termsAccepted
                          ? const Icon(
                              Icons.verified,
                              color: Colors.green,
                            )
                          : Container(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Flexible(
                    fit: FlexFit.loose,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text:
                                "J'accepte et je reconnais avoir lu et compris ",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.blueGrey,
                            ),
                          ),
                          TextSpan(
                            text:
                                "les conditions d'utilisation et la politique de confidentialité",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                      softWrap: true,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
