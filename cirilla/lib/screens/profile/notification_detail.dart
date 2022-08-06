import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/utils/id_replace.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:flutter/material.dart';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

import 'package:cirilla/constants/color_block.dart';
import 'package:cirilla/constants/constants.dart';
import 'package:cirilla/models/message/message.dart';
import 'package:cirilla/service/helpers/request_helper.dart';
import 'package:cirilla/store/store.dart';
import 'package:ui/ui.dart';

class NotificationDetail extends StatefulWidget {
  static const routeName = '/notification_detail';

  final Map<String, dynamic> args;

  const NotificationDetail({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  State<NotificationDetail> createState() => _NotificationDetailState();
}

class _NotificationDetailState extends State<NotificationDetail> with AppBarMixin, NavigationMixin, Utility {
  late AppStore _appStore;
  late MessageStore _messageStore;
  late AuthStore _authStore;
  MessageData? _message;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _authStore = Provider.of<AuthStore>(context);
    _appStore = Provider.of<AppStore>(context);

    String key = "notification_store";

    if (_appStore.getStoreByKey(key) == null) {
      MessageStore store = MessageStore(Provider.of<RequestHelper>(context), _authStore, key: key);

      _appStore.addStore(store);
      _messageStore = store;
    } else {
      _messageStore = _appStore.getStoreByKey(key);
    }

    final message = widget.args['message'];
    if (message is MessageData) {
      _message = message;
      _messageStore.putRead(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_message == null) {
      return Container();
    }

    ThemeData theme = Theme.of(context);

    String title = get(_message?.payload, ['title'], '');

    String body = get(_message?.payload, ['body'], '');

    Map<String, dynamic> action = get(_message?.action, [], '');

    String? sentTime = _message?.createdAt;

    TextStyle defaultStyle = theme.textTheme.bodyText2!.copyWith(color: ColorBlock.blueGray);
    TextStyle linkStyle = theme.textTheme.bodyText2!.copyWith(color: theme.primaryColor);

    String? bodyHtml = IdReplace.idReplaceAllMapped(body);

    Widget html = Html(
      data: "<p>$bodyHtml</p>",
      style: {
        'p': Style.fromTextStyle(defaultStyle),
      },
      customRenders: {
        tagMatcher('a'): CustomRender.widget(widget: (context, buildChildren) {
          String? txt = context.tree.element?.innerHtml;
          return InkWell(
            onTap: () => navigate(context.buildContext, action),
            child: SizedBox(
              height: 18,
              child: Text(txt ?? '', style: linkStyle),
            ),
          );
        }),
      },
    );

    return Theme(
      data: theme.copyWith(canvasColor: Colors.transparent),
      child: Scaffold(
        appBar: baseStyleAppBar(
          context,
          title: AppLocalizations.of(context)!.translate('notifications_detail_title'),
        ),
        bottomSheet: Padding(
          padding: paddingHorizontal.add(paddingVerticalLarge),
          child: SizedBox(
            height: 48,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => buildDialog(context, _message!),
              style: ElevatedButton.styleFrom(padding: paddingHorizontalLarge),
              child: Text(AppLocalizations.of(context)!.translate('notifications_detail_delete')),
            ),
          ),
        ),
        body: Column(
          children: [
            NotificationItem(
              onTap: () {},
              title: Text(
                title,
                style: Theme.of(context).textTheme.subtitle2,
              ),
              leading: Icon(FeatherIcons.messageCircle, color: Theme.of(context).primaryColor, size: 22),
              date: Text(
                  sentTime is String && sentTime != 'null' ? formatDate(date: sentTime, dateFormat: 'MMMM d, y') : '',
                  style: Theme.of(context).textTheme.caption),
              time: Text(sentTime is String && sentTime != 'null' ? formatDate(date: sentTime, dateFormat: 'jm') : '',
                  style: Theme.of(context).textTheme.caption),
            ),
            Padding(padding: paddingHorizontalLarge, child: html),
          ],
        ),
      ),
    );
  }

  Future<void> buildDialog(BuildContext context, MessageData data) async {
    String? result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.translate('notifications_detail_dialog_title')),
        content: Text(AppLocalizations.of(context)!.translate('notifications_detail_dialog_description')),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: Text(AppLocalizations.of(context)!.translate('notifications_detail_dialog_cancel')),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: Text(AppLocalizations.of(context)!.translate('notifications_detail_dialog_ok')),
          ),
        ],
      ),
    );
    if (result == "OK") {
      if (!_messageStore.loadingData) {
        _messageStore.removeMessageById(id: data.id);
      }
      if (mounted) Navigator.of(context).pop();
    }
  }
}
