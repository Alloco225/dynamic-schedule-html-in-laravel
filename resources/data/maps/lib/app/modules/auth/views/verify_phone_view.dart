import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:ici/app/const/styles.dart';
import 'package:ici/app/modules/auth/controller/auth_form_controller.dart';
import 'package:ici/app/widgets/forms.dart';

class VerifyPhoneForm extends StatefulWidget {
  const VerifyPhoneForm({Key? key}) : super(key: key);

  @override
  State<VerifyPhoneForm> createState() => _VerifyPhoneFormState();
}

class _VerifyPhoneFormState extends State<VerifyPhoneForm> {
  final AuthFormController _authFormController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          const Icon(FeatherIcons.lock, size: 40),
          const SizedBox(height: 10),
          Text(
            "Entrez le code",
            style: Styles.h2.copyWith(color: Colors.blueGrey.shade700),
          ),
          const SizedBox(height: 10),

          const Text(
            "Nous avons envoyé un code sur le ",
            textAlign: TextAlign.center,
            style: Styles.small,
          ),
          InkWell(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  _authFormController.registerCredentials['phone'],
                  textAlign: TextAlign.center,
                  style: Styles.title.copyWith(color: Colors.blueGrey),
                ),
                const SizedBox(width: 5),
                Text(
                  "Modifier",
                  style: Styles.subtitle.copyWith(color: Colors.blueGrey),
                ),
                const SizedBox(width: 2),
                const Icon(FeatherIcons.edit2,
                    size: 13, color: Colors.blueGrey),
              ],
            ),
          ),

          /// ? OTP Code Input Form
          ///
          ///
          const Spacer(),
          
          const SizedBox(height: 10),
          ValidatedInputLabel(
            text: "",
            error: _authFormController.otpError,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          const Spacer(flex: 3),
        ],
      ),
    );
  }
}
