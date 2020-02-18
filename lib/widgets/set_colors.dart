import 'package:flutter/material.dart';

const appBarBgColors = Color(0xFF2196F3);
const appBarLineBgColors = Color(0xFFFF9800);
const btnBgColors = Color(0xFFF57C00);
const bgWhite = Color(0xffffffff);

const bgGradientAppBar = LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: <Color>[
                        Color(0xFF42A5F5),
                        Color(0xFF1E88E5),
                        Color(0xFF1976D2),
                  ],
                );

const bgGradient = LinearGradient(
                            colors: <Color> 
                            [
                            Color(0xFF1565C0),
                            Color(0xFF1976D2),
                            Color(0xFF1E88E5),
                            Color(0xFF2196F3),
                            Color(0xFF42A5F5),
                            Color(0xFF64B5F6),
                            Color(0xFF90CAF9),
                            Color(0xFFBBDEFB),
                            Color(0xFFFFE0B2),
                            Color(0xFFFFE0B2),
                                
                            ],
                             begin: Alignment.topCenter,
                             end: Alignment.bottomCenter,
                             
                          );
const btnColor = LinearGradient(
                        colors: <Color>  [
                        Color(0xFFF57C00),
                        Color(0xFFFF9800),
                        Color(0xFFF57C00),
                        ],
                      );

const bgAppBar = LinearGradient(
                colors: <Color>[
                      Color(0xFF0099FF),
                      Color(0xFF0033CC),
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                
               );
const bgPage = LinearGradient(
            colors: [
               Color(0xFFF0F8FF),
               Color(0xFFF0F8FF),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          );
const bgPageWhite = LinearGradient(
            colors: [
               Color(0xFFFFFFFF),
               Color(0xFFFFFFFF),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          );

const bgPageOrange = LinearGradient(
            colors: [
               Color(0xFFFFE0B2),
              Color(0xFFFFE0B2),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          );

const bgPageBlue = LinearGradient(
            colors: [
              Color(0xFFBBDEFB),
             Color(0xFFBBDEFB),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          );