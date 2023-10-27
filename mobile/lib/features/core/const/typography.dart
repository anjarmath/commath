// Typography
import 'package:flutter/material.dart';

TextStyle regular12_5 = const TextStyle(fontFamily: 'Outfit', fontSize: 12.5);
TextStyle regular14 = regular12_5.copyWith(fontSize: 14);

TextStyle semibold12_5 = regular12_5.copyWith(fontWeight: FontWeight.w500);
TextStyle semibold14 = semibold12_5.copyWith(fontSize: 14, letterSpacing: 0.1);
TextStyle semibold16 = semibold12_5.copyWith(fontSize: 16, letterSpacing: 0.1);

TextStyle bold16 = regular12_5.copyWith(
    fontWeight: FontWeight.w700, fontSize: 16, letterSpacing: 0.1);
TextStyle bold18 = bold16.copyWith(fontSize: 18, letterSpacing: -0.5);
TextStyle bold20 = bold16.copyWith(fontSize: 20, letterSpacing: -0.5);

TextStyle title16 = const TextStyle(fontFamily: 'Dela', fontSize: 16);
TextStyle title18 = title16.copyWith(fontSize: 18);
TextStyle title20 = title16.copyWith(fontSize: 20);
TextStyle title24 = title16.copyWith(fontSize: 24);
