// import 'package:flutter/material.dart';

// import '../../../core/services/connection_manager.dart' as conn;

// /// Banner widget that shows connection status to user
// /// Automatically shows/hides based on ConnectionSummary.shouldShowBanner
// class ConnectionBannerWidget extends StatelessWidget {
//   final ConnectionSummary connectionSummary;
//   final VoidCallback? onRetryPressed;

//   const ConnectionBannerWidget({
//     super.key,
//     required this.connectionSummary,
//     this.onRetryPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // Don't show banner if operational
//     if (!connectionSummary.shouldShowBanner) {
//       return const SizedBox.shrink();
//     }

//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       decoration: BoxDecoration(
//         color: _getBannerBackgroundColor(),
//         border: Border(
//           bottom: BorderSide(color: _getBannerBorderColor(), width: 2),
//         ),
//       ),
//       child: SafeArea(
//         bottom: false,
//         child: Row(
//           children: [
//             Icon(_getBannerIcon(), color: Colors.white, size: 20),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     connectionSummary.bannerMessage,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w600,
//                       fontSize: 14,
//                     ),
//                   ),
//                   if (_shouldShowDetails()) ...[
//                     const SizedBox(height: 4),
//                     Text(
//                       _getDetailMessage(),
//                       style: TextStyle(
//                         color: Colors.white.withOpacity(0.9),
//                         fontSize: 12,
//                       ),
//                     ),
//                   ],
//                 ],
//               ),
//             ),
//             if (_shouldShowRetryButton()) ...[
//               const SizedBox(width: 8),
//               TextButton(
//                 onPressed: onRetryPressed,
//                 style: TextButton.styleFrom(
//                   foregroundColor: Colors.white,
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 6,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(4),
//                     side: const BorderSide(color: Colors.white, width: 1),
//                   ),
//                 ),
//                 child: const Text('Retry', style: TextStyle(fontSize: 12)),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }

//   Color _getBannerBackgroundColor() {
//     switch (connectionSummary.currentState) {
//       case ConnectionState.initializing:
//         return Colors.blue;
//       case ConnectionState.connecting:
//       case ConnectionState.reconnecting:
//         return Colors.orange;
//       case ConnectionState.networkLost:
//       case ConnectionState.failed:
//         return Colors.red;
//       case ConnectionState.disconnected:
//         return Colors.grey;
//       case ConnectionState.operational:
//         return Colors.green; // Shouldn't be shown
//     }
//   }

//   Color _getBannerBorderColor() {
//     return _getBannerBackgroundColor().withOpacity(0.8);
//   }

//   IconData _getBannerIcon() {
//     switch (connectionSummary.currentState) {
//       case ConnectionState.initializing:
//         return Icons.refresh;
//       case ConnectionState.connecting:
//       case ConnectionState.reconnecting:
//         return Icons.sync;
//       case ConnectionState.networkLost:
//         return Icons.wifi_off;
//       case ConnectionState.failed:
//         return Icons.error_outline;
//       case ConnectionState.disconnected:
//         return Icons.cloud_off;
//       case ConnectionState.operational:
//         return Icons.check_circle_outline; // Shouldn't be shown
//     }
//   }

//   bool _shouldShowDetails() {
//     return connectionSummary.currentState == ConnectionState.networkLost ||
//         connectionSummary.currentState == ConnectionState.failed;
//   }

//   String _getDetailMessage() {
//     switch (connectionSummary.currentState) {
//       case ConnectionState.networkLost:
//         return 'Check your internet connection';
//       case ConnectionState.failed:
//         return 'Unable to connect to server';
//       default:
//         return '';
//     }
//   }

//   bool _shouldShowRetryButton() {
//     return connectionSummary.currentState == ConnectionState.failed ||
//         connectionSummary.currentState == ConnectionState.reconnecting;
//   }
// }

// /// Stream builder wrapper for connection banner
// class ConnectionBannerStreamWidget extends StatelessWidget {
//   final Stream<ConnectionSummary> connectionSummaryStream;
//   final VoidCallback? onRetryPressed;

//   const ConnectionBannerStreamWidget({
//     super.key,
//     required this.connectionSummaryStream,
//     this.onRetryPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<ConnectionSummary>(
//       stream: connectionSummaryStream,
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return const SizedBox.shrink();
//         }

//         return ConnectionBannerWidget(
//           connectionSummary: snapshot.data!,
//           onRetryPressed: onRetryPressed,
//         );
//       },
//     );
//   }
// }
