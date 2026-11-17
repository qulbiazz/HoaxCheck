import 'package:flutter/material.dart';
class OnBoarding extends StatefulWidget {
	const OnBoarding({super.key});
	@override
	OnBoardingState createState() => OnBoardingState();
}
class OnBoardingState extends State<OnBoarding> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: SafeArea(
				child: Container(
					constraints: const BoxConstraints.expand(),
					color: Color(0xFFFFFFFF),
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							Expanded(
								child: IntrinsicHeight(
									child: Container(
										color: Color(0xFFF9F9FF),
										width: double.infinity,
										height: double.infinity,
										child: SingleChildScrollView(
											padding: const EdgeInsets.only( top: 32),
											child: Column(
												crossAxisAlignment: CrossAxisAlignment.start,
												children: [
													IntrinsicHeight(
														child: Container(
															margin: const EdgeInsets.only( bottom: 25, left: 29, right: 29),
															width: double.infinity,
															child: Row(
																mainAxisAlignment: MainAxisAlignment.spaceBetween,
																children: [
																	Container(
																		width: 14,
																		height: 14,
																		child: Image.network(
																			"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ysr4wGraxe/97dpsbix_expires_30_days.png",
																			fit: BoxFit.fill,
																		)
																	),
																	Text(
																		"Mulai",
																		style: TextStyle(
																			color: Color(0xFF00694C),
																			fontSize: 14,
																		),
																	),
																]
															),
														),
													),
													Container(
														decoration: BoxDecoration(
															borderRadius: BorderRadius.circular(16),
														),
														margin: const EdgeInsets.only( bottom: 52, left: 16, right: 16),
														height: 280,
														width: double.infinity,
														child: ClipRRect(
															borderRadius: BorderRadius.circular(16),
															child: Image.network(
																"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ysr4wGraxe/l6mobbf6_expires_30_days.png",
																fit: BoxFit.fill,
															)
														)
													),
													IntrinsicHeight(
														child: Container(
															margin: const EdgeInsets.only( bottom: 96, left: 16, right: 16),
															width: double.infinity,
															child: Column(
																crossAxisAlignment: CrossAxisAlignment.start,
																children: [
																	IntrinsicHeight(
																		child: Container(
																			margin: const EdgeInsets.only( bottom: 22),
																			width: double.infinity,
																			child: Column(
																				crossAxisAlignment: CrossAxisAlignment.start,
																				children: [
																					IntrinsicWidth(
																						child: IntrinsicHeight(
																							child: Container(
																								padding: const EdgeInsets.only( bottom: 10),
																								child: Column(
																									children: [
																										IntrinsicWidth(
																											child: IntrinsicHeight(
																												child: Container(
																													decoration: BoxDecoration(
																														borderRadius: BorderRadius.circular(9999),
																														color: Color(0xFF8DF7C5),
																													),
																													padding: const EdgeInsets.only( top: 4, bottom: 4, left: 12, right: 12),
																													child: Row(
																														children: [
																															Container(
																																decoration: BoxDecoration(
																																	borderRadius: BorderRadius.circular(9999),
																																),
																																margin: const EdgeInsets.only( right: 6),
																																width: 10,
																																height: 12,
																																child: ClipRRect(
																																	borderRadius: BorderRadius.circular(9999),
																																	child: Image.network(
																																		"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ysr4wGraxe/89umf758_expires_30_days.png",
																																		fit: BoxFit.fill,
																																	)
																																)
																															),
																															Text(
																																"Fondasi Literasi Digital",
																																style: TextStyle(
																																	color: Color(0xFF00694C),
																																	fontSize: 11,
																																	fontWeight: FontWeight.bold,
																																),
																															),
																														]
																													),
																												),
																											),
																										),
																									]
																								),
																							),
																						),
																					),
																					IntrinsicHeight(
																						child: Container(
																							padding: const EdgeInsets.only( bottom: 6, right: 43),
																							width: double.infinity,
																							child: Column(
																								crossAxisAlignment: CrossAxisAlignment.start,
																								children: [
																									Container(
																										width: double.infinity,
																										child: Text(
																											"Periksa Teks dengan Mudah",
																											style: TextStyle(
																												color: Color(0xFF151C27),
																												fontSize: 24,
																												fontWeight: FontWeight.bold,
																											),
																										),
																									),
																								]
																							),
																						),
																					),
																					IntrinsicHeight(
																						child: Container(
																							padding: const EdgeInsets.only( right: 36),
																							width: double.infinity,
																							child: Column(
																								crossAxisAlignment: CrossAxisAlignment.start,
																								children: [
																									Container(
																										width: double.infinity,
																										child: Text(
																											"HoaxCheck adalah alat bantu deteksi awal,\nbukan pengganti verifikasi fakta.",
																											style: TextStyle(
																												color: Color(0xFF3D4A43),
																												fontSize: 16,
																											),
																										),
																									),
																								]
																							),
																						),
																					),
																				]
																			),
																		),
																	),
																	IntrinsicHeight(
																		child: Container(
																			decoration: BoxDecoration(
																				borderRadius: BorderRadius.circular(12),
																				color: Color(0xFFE7EEFE),
																			),
																			padding: const EdgeInsets.all(8),
																			margin: const EdgeInsets.only( top: 16),
																			width: double.infinity,
																			child: Row(
																				children: [
																					Container(
																						decoration: BoxDecoration(
																							borderRadius: BorderRadius.circular(12),
																						),
																						margin: const EdgeInsets.only( right: 8),
																						width: 28,
																						height: 30,
																						child: ClipRRect(
																							borderRadius: BorderRadius.circular(12),
																							child: Image.network(
																								"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ysr4wGraxe/x7l9jfzy_expires_30_days.png",
																								fit: BoxFit.fill,
																							)
																						)
																					),
																					Expanded(
																						child: IntrinsicHeight(
																							child: Container(
																								padding: const EdgeInsets.only( right: 17),
																								width: double.infinity,
																								child: Column(
																									crossAxisAlignment: CrossAxisAlignment.start,
																									children: [
																										Container(
																											width: double.infinity,
																											child: Text(
																												"Selalu periksa informasi melalui sumber terpercaya\nsebelum mempercayai atau membagikannya.",
																												style: TextStyle(
																													color: Color(0xFF20608E),
																													fontSize: 12,
																												),
																											),
																										),
																									]
																								),
																							),
																						),
																					),
																				]
																			),
																		),
																	),
																]
															),
														),
													),
													IntrinsicHeight(
														child: Container(
															padding: const EdgeInsets.only( top: 4),
															margin: const EdgeInsets.only( bottom: 48, left: 17, right: 17),
															width: double.infinity,
															child: Column(
																crossAxisAlignment: CrossAxisAlignment.start,
																children: [
																	IntrinsicHeight(
																		child: Container(
																			padding: const EdgeInsets.symmetric(vertical: 4),
																			margin: const EdgeInsets.only( bottom: 16),
																			width: double.infinity,
																			child: Row(
																				mainAxisAlignment: MainAxisAlignment.center,
																				children: [
																					Container(
																						decoration: BoxDecoration(
																							borderRadius: BorderRadius.circular(9999),
																							color: Color(0xFFBCCAC1),
																						),
																						margin: const EdgeInsets.only( right: 8),
																						width: 8,
																						height: 8,
																						child: SizedBox(),
																					),
																					Container(
																						decoration: BoxDecoration(
																							borderRadius: BorderRadius.circular(9999),
																							color: Color(0xFFBCCAC1),
																						),
																						margin: const EdgeInsets.only( right: 8),
																						width: 8,
																						height: 8,
																						child: SizedBox(),
																					),
																					Container(
																						decoration: BoxDecoration(
																							borderRadius: BorderRadius.circular(9999),
																							color: Color(0xFF00694C),
																						),
																						width: 28,
																						height: 8,
																						child: SizedBox(),
																					),
																				]
																			),
																		),
																	),
																	InkWell(
																		onTap: () { print('Pressed'); },
																		child: IntrinsicHeight(
																			child: Container(
																				decoration: BoxDecoration(
																					borderRadius: BorderRadius.circular(12),
																					color: Color(0x00FFFFFF),
																					boxShadow: [
																						BoxShadow(
																							color: Color(0x1A000000),
																							blurRadius: 4,
																							offset: Offset(0, 2),
																						),
																					],
																				),
																				padding: const EdgeInsets.symmetric(vertical: 12),
																				width: double.infinity,
																				child: Row(
																					mainAxisAlignment: MainAxisAlignment.center,
																					children: [
																						Container(
																							margin: const EdgeInsets.only( right: 7),
																							child: Text(
																								"Mulai",
																								style: TextStyle(
																									color: Color(0xFFFFFFFF),
																									fontSize: 18,
																									fontWeight: FontWeight.bold,
																								),
																							),
																						),
																						Container(
																							decoration: BoxDecoration(
																								borderRadius: BorderRadius.circular(12),
																							),
																							width: 13,
																							height: 13,
																							child: ClipRRect(
																								borderRadius: BorderRadius.circular(12),
																								child: Image.network(
																									"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ysr4wGraxe/rsxzzie4_expires_30_days.png",
																									fit: BoxFit.fill,
																								)
																							)
																						),
																					]
																				),
																			),
																		),
																	),
																]
															),
														),
													),
												],
											)
										),
									),
								),
							),
						],
					),
				),
			),
		);
	}
}