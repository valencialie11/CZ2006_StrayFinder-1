import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'dart:convert' as convert;
import 'package:flutter/material.dart';

/// Represents the boundary class which handles input related to the Report function
class ReportUI {

  /// The method to reedirect to the user tabs
  static void goUserTabs(BuildContext context) {
    Navigator.pushNamed(
      context,
      '/usertabs',
    );
  }

  /// The method to redirect to the describe injury page
  static void goDescribeInjury(BuildContext context, int id, String name,
      GeoPoint lastSeen) {
    Navigator.pushNamed(
        context,
        '/describeinjury',
        arguments: {
          'id': id,
          'name': name,
          'lastSeen': lastSeen
        }
    );
  }

  /// The method to redirect to the thank you for reporting page
  static void goThankYouForReporting(BuildContext context) {
    Navigator.pushNamed(
        context,
        '/thankyouforreporting',
    );
  }

  /// The method to redirect to the leave contact details page
  static void goLeaveContactDetails(BuildContext context, int id,
      String desc, List<String> images, String name, GeoPoint lastSeen) {
      Navigator.pushNamed(
        context,
        '/report', arguments: {
      'id': id,
      'description': desc,
      'images': images,
      'name': name,
      'lastSeen': lastSeen
    }
    );
  }

  /// The method to redirect to the bring to vet page
  static void goBringToVet(BuildContext context, int id, String desc, List<String> images, String name,
      GeoPoint lastSeen) {
    Navigator.pushNamed(
        context,
        '/bringtovet',
        arguments: {
          'id': id,
          'description': desc,
          'images': images,
          'name': name,
          'lastSeen': lastSeen
        }
    );
  }

  /// The method to redirect to the name cat found page
  static void goNameCatFound(BuildContext context, int id, String breed, String imgURL) {
    Navigator.pushNamed(
        context,
        '/namecatfound',
        arguments: {
          'id': id,
          'breed': breed,
          'imgURL': imgURL,
        }
    );
  }

  /// The method to redirect to the ask if injured page
  static void goAskIfInjured(BuildContext context, int id,
      String name, String breed, String image, bool is_existing) {
    Navigator.pushNamed(
        context,
        '/askifinjured',
        arguments:
        {
          'id': id,
          'name': name,
          'breed': breed,
          'image': image,
          'is_existing': is_existing
        }
    );
  }

  /// The method to redirect to the is this the cat page
  static void goToIsThisTheCatPage(BuildContext context, String image,
      String breed) {
    Navigator.pushNamed(
        context,
        '/isthisthecat',
        arguments: {
          'image': image,
          'breed': breed
        }
    );
  }

  /// The method to check if the image uploaded is that of a cat
  static Future<String> checkCat(File imagePicker) async {
    File image = File(imagePicker.path);
    var formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(image.path)
    });
    var response = await Dio().post(
        'https://catclassifier-aljhyhz73a-as.a.run.app/predict',
        data: formData);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.toString()) as Map<String, dynamic>;
      var result = jsonResponse['result'];
      return result;
    } else {
      throw "Request failed with status: ${response.statusCode}.";
    }
  }

  /// The method to predict the breed of the reported stray cat
  static Future<String> predictBreed(File imagePicker) async {
    File image = File(imagePicker.path);
    var formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(image.path)
    });
    var response = await Dio().post(
        'https://breedpredictor-qvdglufpcq-as.a.run.app/predict',
        data: formData);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.toString()) as Map<
          String,
          dynamic>;
      var breed = jsonResponse['result'];
      return breed;
    } else {
      throw "Request failed with status: ${response.statusCode}.";
    }
  }
}
