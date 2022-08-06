import 'package:cirilla/screens/screens.dart';
import 'package:cirilla/types/types.dart';
import 'package:cirilla/utils/app_localization.dart';
import 'package:cirilla/widgets/cirilla_tile.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'profile_content.dart';

class ProfileContentLogout extends ProfileContent {
  final ShowMessageType? showMessage;

  const ProfileContentLogout({
    Key? key,
    String? phone,
    Widget? footer,
    bool? enablePhone,
    bool? enableHelpInfo,
    this.showMessage,
  }) : super(
          key: key,
          enablePhone: enablePhone,
          phone: phone,
          footer: footer,
          enableHelpInfo: enableHelpInfo,
        );

  @override
  Widget buildLayout(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;
    return Column(
      children: [
        Text(
          translate('login_sign_in_to_receive'),
          style: theme.textTheme.bodyText1,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pushNamed(RegisterScreen.routeName),
                  style: ElevatedButton.styleFrom(
                    textStyle: theme.textTheme.subtitle2,
                  ),
                  child: Text(
                    translate('login_btn_create_account'),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(LoginScreen.routeName, arguments: {'showMessage': showMessage}),
                  style: ElevatedButton.styleFrom(
                    textStyle: theme.textTheme.subtitle2,
                  ),
                  child: Text(
                    translate('login_btn_login'),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),
        buildInfo(
          context,
          title: translate('settings'),
          child: Column(
            children: [
              CirillaTile(
                title: Text(translate('app_settings'), style: theme.textTheme.subtitle2),
                leading: const Icon(
                  FeatherIcons.settings,
                  size: 16,
                ),
                onTap: () => Navigator.of(context).pushNamed(SettingScreen.routeName),
              ),
              if (enableHelpInfo == true)
                CirillaTile(
                  title: Text(translate('help_info'), style: theme.textTheme.subtitle2),
                  leading: const Icon(
                    FeatherIcons.info,
                    size: 16,
                  ),
                  onTap: () => Navigator.of(context).pushNamed(HelpInfoScreen.routeName),
                ),
              if (enablePhone!)
                CirillaTile(
                  title: Text(translate('hotline'), style: theme.textTheme.subtitle2),
                  leading: const Icon(
                    FeatherIcons.phoneForwarded,
                    size: 16,
                  ),
                  trailing: Text(phone!, style: theme.textTheme.bodyText1),
                  onTap: () => launch("tel://$phone"),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
