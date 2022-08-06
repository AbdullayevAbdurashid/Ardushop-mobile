import 'package:cirilla/constants/constants.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/utils/debug.dart';
import 'package:flutter/material.dart';

import 'cirilla_download_button.dart';

class CirillaDownloadItem extends StatefulWidget {
  final Download download;
  final VoidCallback? callbackDownload;

  const CirillaDownloadItem({
    Key? key,
    required this.download,
    this.callbackDownload,
  }) : super(key: key);

  @override
  State<CirillaDownloadItem> createState() => _CirillaDownloadItemState();
}

class _CirillaDownloadItemState extends State<CirillaDownloadItem> with DownloadMixin {
  late final DownloadController _downloadController;

  @override
  void initState() {
    _downloadController = HandleDownloadController(
      onOpenDownload: () {
        _openDownload();
      },
      onCallbackDownload: () => widget.callbackDownload?.call(),
    );
    super.initState();
  }

  void _openDownload() {
    avoidPrint('Open download');
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Card(
      elevation: 3,
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(borderRadius: borderRadius),
      child: Padding(
        padding: paddingMedium,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildProductName(context, download: widget.download, theme: theme),
                      const SizedBox(height: 8),
                      buildRemaining(context, download: widget.download, theme: theme),
                      buildFileName(context, download: widget.download, theme: theme),
                      buildExpire(context, download: widget.download, theme: theme),
                    ],
                  ),
                ),
                const SizedBox(width: itemPaddingMedium),
                buildButtonDownload(
                  download: widget.download,
                  button: AnimatedBuilder(
                    animation: _downloadController,
                    builder: (_, child) {
                      return CirillaDownloadButton(
                        status: _downloadController.downloadStatus,
                        onDownload: () => _downloadController.startDownload(widget.download),
                        onCancel: _downloadController.stopDownload,
                        onOpen: _downloadController.openDownload,
                      );
                    },
                  ),
                ),
              ],
            ),
            AnimatedBuilder(
              animation: _downloadController,
              builder: (context, child) {
                if (_downloadController.downloadStatus == DownloadStatus.downloading) {
                  return Padding(
                    padding: const EdgeInsets.only(top: itemPaddingMedium),
                    child: CirillaDownloadButtonLoading(
                      downloadProgress: _downloadController.progress,
                    ),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
