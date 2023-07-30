import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String calculateTimeOfMessage(
    int index, List<QueryDocumentSnapshot> messages, Timestamp? timestamp) {
  if (timestamp == null) {
    return ''; // Return an empty string if the timestamp is null
  }

  if (index == 0) {
    return _formatTimestamp(timestamp);
  }

  Timestamp? previousTimestamp =
      index - 1 >= 0 ? messages[index - 1]['timestamp'] as Timestamp? : null;
  if (previousTimestamp == null) {
    return _formatTimestamp(
        timestamp); // Return the formatted timestamp if the previous timestamp is null
  }

  Duration difference =
      timestamp.toDate().difference(previousTimestamp.toDate());

  if (difference.inMinutes >= 5) {
    return _formatTimestamp(timestamp);
  }

  return '';
}

String _formatTimestamp(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  String formattedTime =
      DateFormat.jm().format(dateTime); // Format time as 12-hour format
  return formattedTime;
}
