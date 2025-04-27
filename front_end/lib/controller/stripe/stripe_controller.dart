import 'dart:convert';
import 'package:front_end/core/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class StripeController {
  static Future<Map<String, dynamic>> getRevenueAndPayments() async {
    final url = Uri.parse('https://api.stripe.com/v1/payment_intents?limit=100');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $secretKey',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List payments = data['data'];

      double totalRevenue = 0;
      int successfulPayments = 0;
      final Map<String, double> revenuePerDay = {};

      for (var payment in payments) {
        if (payment['status'] == 'succeeded') {
          final amount = payment['amount'] / 100;
          totalRevenue += amount;
          successfulPayments++;

          final timestamp = payment['created']; // UNIX timestamp (giây)
          final date = DateFormat('yyyy-MM-dd')
              .format(DateTime.fromMillisecondsSinceEpoch(timestamp * 1000));

          revenuePerDay.update(date, (value) => value + amount, ifAbsent: () => amount);
        }
      }

      return {
        'totalRevenue': totalRevenue,
        'successfulPayments': successfulPayments,
        'revenuePerDay': revenuePerDay.entries.map((e) => {
          'date': e.key,
          'revenue': e.value,
        }).toList(),
      };
    } else {
      throw Exception('Failed to fetch Stripe data');
    }
  }
}
