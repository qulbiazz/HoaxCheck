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
											padding: const EdgeInsets.only( top: 26),
											child: Column(
												crossAxisAlignment: CrossAxisAlignment.start,
												children: [
													IntrinsicHeight(
														child: Container(
															margin: const EdgeInsets.only( bottom: 19, left: 16, right: 16),
															width: double.infinity,
															child: Row(
																mainAxisAlignment: MainAxisAlignment.spaceBetween,
																children: [
																	IntrinsicWidth(
																		child: IntrinsicHeight(
																			child: Container(
																				decoration: BoxDecoration(
																					borderRadius: BorderRadius.circular(9999),
																					color: Color(0xFFF0F3FF),
																				),
																				padding: const EdgeInsets.only( top: 4, bottom: 4, left: 10, right: 10),
																				child: Column(
																					children: [
																						Text(
																							"LANGKAH 2 DARI 3",
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
																	IntrinsicWidth(
																		child: IntrinsicHeight(
																			child: Container(
																				decoration: BoxDecoration(
																					borderRadius: BorderRadius.circular(8),
																				),
																				padding: const EdgeInsets.only( top: 6, bottom: 6, left: 11, right: 11),
																				child: Column(
																					crossAxisAlignment: CrossAxisAlignment.start,
																					children: [
																						Text(
																							"Lewati",
																							style: TextStyle(
																								color: Color(0xFF6D7A73),
																								fontSize: 14,
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
													IntrinsicHeight(
														child: Container(
															decoration: BoxDecoration(
																borderRadius: BorderRadius.circular(16),
																color: Color(0xFFF0F3FF),
																boxShadow: [
																	BoxShadow(
																		color: Color(0x0D000000),
																		blurRadius: 2,
																		offset: Offset(0, 1),
																	),
																],
															),
															margin: const EdgeInsets.only( bottom: 52, left: 17, right: 17),
															width: double.infinity,
															child: Stack(
																clipBehavior: Clip.none,
																children: [
																	Padding(
																		padding: const EdgeInsets.only( top: 31, bottom: 31, left: 16, right: 16),
																		child: Column(
																			crossAxisAlignment: CrossAxisAlignment.start,
																			children: [
																				IntrinsicHeight(
																					child: Container(
																						width: double.infinity,
																						child: Column(
																							crossAxisAlignment: CrossAxisAlignment.start,
																							children: [
																								IntrinsicHeight(
																									child: Container(
																										decoration: BoxDecoration(
																											borderRadius: BorderRadius.circular(12),
																											color: Color(0xFFFFFFFF),
																											boxShadow: [
																												BoxShadow(
																													color: Color(0x0D000000),
																													blurRadius: 2,
																													offset: Offset(0, 1),
																												),
																											],
																										),
																										padding: const EdgeInsets.only( top: 12, bottom: 12, left: 11, right: 11),
																										margin: const EdgeInsets.only( bottom: 12),
																										width: double.infinity,
																										child: Row(
																											crossAxisAlignment: CrossAxisAlignment.start,
																											children: [
																												Container(
																													decoration: BoxDecoration(
																														borderRadius: BorderRadius.circular(8),
																													),
																													margin: const EdgeInsets.only( right: 12),
																													width: 32,
																													height: 32,
																													child: ClipRRect(
																														borderRadius: BorderRadius.circular(8),
																														child: Image.network(
																															"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ysr4wGraxe/2a90sfy7_expires_30_days.png",
																															fit: BoxFit.fill,
																														)
																													)
																												),
																												Expanded(
																													child: IntrinsicHeight(
																														child: Container(
																															width: double.infinity,
																															child: Column(
																																crossAxisAlignment: CrossAxisAlignment.start,
																																children: [
																																	IntrinsicHeight(
																																		child: Container(
																																			margin: const EdgeInsets.only( bottom: 4),
																																			width: double.infinity,
																																			child: Row(
																																				mainAxisAlignment: MainAxisAlignment.spaceBetween,
																																				children: [
																																					Text(
																																						"Teks Masuk",
																																						style: TextStyle(
																																							color: Color(0xFF6D7A73),
																																							fontSize: 11,
																																							fontWeight: FontWeight.bold,
																																						),
																																					),
																																					Text(
																																						"142 Kata",
																																						style: TextStyle(
																																							color: Color(0xFF00694C),
																																							fontSize: 11,
																																						),
																																					),
																																				]
																																			),
																																		),
																																	),
																																	Container(
																																		width: double.infinity,
																																		child: Text(
																																			"\"Beredar pesan rantai bahwa subsidi minyak goreng...\"",
																																			style: TextStyle(
																																				color: Color(0xFF3D4A43),
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
																								IntrinsicHeight(
																									child: Container(
																										decoration: BoxDecoration(
																											borderRadius: BorderRadius.circular(12),
																											color: Color(0xFFFFFFFF),
																											boxShadow: [
																												BoxShadow(
																													color: Color(0x0D000000),
																													blurRadius: 2,
																													offset: Offset(0, 1),
																												),
																											],
																										),
																										padding: const EdgeInsets.all(12),
																										margin: const EdgeInsets.only( bottom: 12),
																										width: double.infinity,
																										child: Row(
																											children: [
																												Expanded(
																													child: IntrinsicHeight(
																														child: Container(
																															margin: const EdgeInsets.only( right: 43),
																															width: double.infinity,
																															child: Row(
																																children: [
																																	Container(
																																		decoration: BoxDecoration(
																																			borderRadius: BorderRadius.circular(8),
																																		),
																																		margin: const EdgeInsets.only( right: 10),
																																		width: 32,
																																		height: 32,
																																		child: ClipRRect(
																																			borderRadius: BorderRadius.circular(8),
																																			child: Image.network(
																																				"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ysr4wGraxe/9gjwk2pt_expires_30_days.png",
																																				fit: BoxFit.fill,
																																			)
																																		)
																																	),
																																	Expanded(
																																		child: IntrinsicHeight(
																																			child: Container(
																																				width: double.infinity,
																																				child: Column(
																																					crossAxisAlignment: CrossAxisAlignment.start,
																																					children: [
																																						Text(
																																							"Mesin NLP Klaritas",
																																							style: TextStyle(
																																								color: Color(0xFF151C27),
																																								fontSize: 16,
																																								fontWeight: FontWeight.bold,
																																							),
																																						),
																																						IntrinsicHeight(
																																							child: Container(
																																								width: double.infinity,
																																								child: Column(
																																									crossAxisAlignment: CrossAxisAlignment.start,
																																									children: [
																																										Text(
																																											"Analisis semantik & fakta",
																																											style: TextStyle(
																																												color: Color(0xFF6D7A73),
																																												fontSize: 12,
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
																																	),
																																]
																															),
																														),
																													),
																												),
																												IntrinsicWidth(
																													child: IntrinsicHeight(
																														child: Container(
																															decoration: BoxDecoration(
																																borderRadius: BorderRadius.circular(9999),
																																color: Color(0xFF8DF7C5),
																															),
																															padding: const EdgeInsets.only( top: 4, bottom: 4, left: 9, right: 9),
																															child: Row(
																																children: [
																																	Container(
																																		decoration: BoxDecoration(
																																			borderRadius: BorderRadius.circular(9999),
																																		),
																																		margin: const EdgeInsets.only( right: 4),
																																		width: 12,
																																		height: 12,
																																		child: ClipRRect(
																																			borderRadius: BorderRadius.circular(9999),
																																			child: Image.network(
																																				"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ysr4wGraxe/dc2hbaxq_expires_30_days.png",
																																				fit: BoxFit.fill,
																																			)
																																		)
																																	),
																																	Text(
																																		"98.4%",
																																		style: TextStyle(
																																			color: Color(0xFF002114),
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
																								IntrinsicHeight(
																									child: Container(
																										decoration: BoxDecoration(
																											borderRadius: BorderRadius.circular(12),
																											color: Color(0xFFFFFFFF),
																											boxShadow: [
																												BoxShadow(
																													color: Color(0x0D000000),
																													blurRadius: 2,
																													offset: Offset(0, 1),
																												),
																											],
																										),
																										padding: const EdgeInsets.all(12),
																										width: double.infinity,
																										child: Row(
																											mainAxisAlignment: MainAxisAlignment.spaceBetween,
																											children: [
																												IntrinsicWidth(
																													child: IntrinsicHeight(
																														child: Row(
																															children: [
																																Container(
																																	decoration: BoxDecoration(
																																		borderRadius: BorderRadius.circular(8),
																																	),
																																	margin: const EdgeInsets.only( right: 10),
																																	width: 32,
																																	height: 32,
																																	child: ClipRRect(
																																		borderRadius: BorderRadius.circular(8),
																																		child: Image.network(
																																			"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ysr4wGraxe/tfviydmy_expires_30_days.png",
																																			fit: BoxFit.fill,
																																		)
																																	)
																																),
																																IntrinsicWidth(
																																	child: IntrinsicHeight(
																																		child: Column(
																																			children: [
																																				IntrinsicWidth(
																																					child: IntrinsicHeight(
																																						child: Container(
																																							padding: const EdgeInsets.only( right: 29),
																																							child: Column(
																																								crossAxisAlignment: CrossAxisAlignment.start,
																																								children: [
																																									Text(
																																										"Klasifikasi Otomatis",
																																										style: TextStyle(
																																											color: Color(0xFF6D7A73),
																																											fontSize: 11,
																																											fontWeight: FontWeight.bold,
																																										),
																																									),
																																								]
																																							),
																																						),
																																					),
																																				),
																																				Text(
																																					"Terindikasi Hoaks",
																																					style: TextStyle(
																																						color: Color(0xFF151C27),
																																						fontSize: 16,
																																						fontWeight: FontWeight.bold,
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
																												IntrinsicWidth(
																													child: IntrinsicHeight(
																														child: Container(
																															decoration: BoxDecoration(
																																borderRadius: BorderRadius.circular(9999),
																																color: Color(0xFFFFDAD6),
																															),
																															padding: const EdgeInsets.only( top: 4, bottom: 4, left: 9, right: 9),
																															child: Row(
																																children: [
																																	Container(
																																		decoration: BoxDecoration(
																																			borderRadius: BorderRadius.circular(9999),
																																		),
																																		margin: const EdgeInsets.only( right: 4),
																																		width: 9,
																																		height: 11,
																																		child: ClipRRect(
																																			borderRadius: BorderRadius.circular(9999),
																																			child: Image.network(
																																				"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ysr4wGraxe/frz7t3w0_expires_30_days.png",
																																				fit: BoxFit.fill,
																																			)
																																		)
																																	),
																																	Text(
																																		"Palsu",
																																		style: TextStyle(
																																			color: Color(0xFF93000A),
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
																							]
																						),
																					),
																				),
																			]
																		),
																	),
																	Positioned(
																		top: 3,
																		left: 0,
																		width: 144,
																		height: 144,
																		child: Container(
																			decoration: BoxDecoration(
																				borderRadius: BorderRadius.circular(9999),
																				color: Color(0x668DF7C5),
																			),
																			width: 144,
																			height: 144,
																			child: SizedBox(),
																		),
																	),
																	Positioned(
																		bottom: 0,
																		right: 0,
																		width: 104,
																		height: 53,
																		child: Container(
																			decoration: BoxDecoration(
																				borderRadius: BorderRadius.circular(9999),
																				color: Color(0x80CDE5FF),
																			),
																			width: 104,
																			height: 53,
																			child: SizedBox(),
																		),
																	),
																]
															),
														),
													),
													IntrinsicHeight(
														child: Container(
															margin: const EdgeInsets.only( bottom: 42, left: 17, right: 17),
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
																													padding: const EdgeInsets.only( top: 4, bottom: 4, left: 11, right: 11),
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
																																		"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ysr4wGraxe/4umtunkv_expires_30_days.png",
																																		fit: BoxFit.fill,
																																	)
																																)
																															),
																															Text(
																																"Alur Praktis 3 Detik",
																																style: TextStyle(
																																	color: Color(0xFF002114),
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
																							padding: const EdgeInsets.only( right: 11),
																							width: double.infinity,
																							child: Column(
																								crossAxisAlignment: CrossAxisAlignment.start,
																								children: [
																									Container(
																										width: double.infinity,
																										child: Text(
																											"Masukkan atau tempel teks yang ingin kamu periksa,\nlalu biarkan HoaxCheck menganalisisnya secara\nobjektif dengan kecerdasan buatan.",
																											style: TextStyle(
																												color: Color(0xFF3D4A43),
																												fontSize: 14,
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
																			padding: const EdgeInsets.only( top: 12, bottom: 12, left: 16, right: 16),
																			width: double.infinity,
																			child: Row(
																				children: [
																					Expanded(
																						child: IntrinsicHeight(
																							child: Container(
																								decoration: BoxDecoration(
																									borderRadius: BorderRadius.circular(12),
																									color: Color(0xFFFFFFFF),
																									boxShadow: [
																										BoxShadow(
																											color: Color(0x0D000000),
																											blurRadius: 2,
																											offset: Offset(0, 1),
																										),
																									],
																								),
																								padding: const EdgeInsets.all(10),
																								margin: const EdgeInsets.only( right: 8),
																								width: double.infinity,
																								child: Column(
																									crossAxisAlignment: CrossAxisAlignment.start,
																									children: [
																										IntrinsicHeight(
																											child: Container(
																												margin: const EdgeInsets.only( bottom: 7),
																												width: double.infinity,
																												child: Row(
																													mainAxisAlignment: MainAxisAlignment.spaceBetween,
																													children: [
																														Text(
																															"01",
																															style: TextStyle(
																																color: Color(0xFF00694C),
																																fontSize: 11,
																																fontWeight: FontWeight.bold,
																															),
																														),
																														Container(
																															decoration: BoxDecoration(
																																borderRadius: BorderRadius.circular(6),
																															),
																															width: 24,
																															height: 24,
																															child: ClipRRect(
																																borderRadius: BorderRadius.circular(6),
																																child: Image.network(
																																	"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ysr4wGraxe/60vsdd0u_expires_30_days.png",
																																	fit: BoxFit.fill,
																																)
																															)
																														),
																													]
																												),
																											),
																										),
																										IntrinsicHeight(
																											child: Container(
																												width: double.infinity,
																												child: Column(
																													crossAxisAlignment: CrossAxisAlignment.start,
																													children: [
																														Text(
																															"Tempel",
																															style: TextStyle(
																																color: Color(0xFF151C27),
																																fontSize: 12,
																																fontWeight: FontWeight.bold,
																															),
																														),
																														IntrinsicHeight(
																															child: Container(
																																width: double.infinity,
																																child: Column(
																																	crossAxisAlignment: CrossAxisAlignment.start,
																																	children: [
																																		Text(
																																			"Input teks",
																																			style: TextStyle(
																																				color: Color(0xFF6D7A73),
																																				fontSize: 12,
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
																									]
																								),
																							),
																						),
																					),
																					Expanded(
																						child: IntrinsicHeight(
																							child: Container(
																								decoration: BoxDecoration(
																									borderRadius: BorderRadius.circular(12),
																									color: Color(0xFFE7EEFE),
																									boxShadow: [
																										BoxShadow(
																											color: Color(0x0D000000),
																											blurRadius: 2,
																											offset: Offset(0, 1),
																										),
																									],
																								),
																								padding: const EdgeInsets.all(10),
																								margin: const EdgeInsets.only( right: 8),
																								width: double.infinity,
																								child: Column(
																									crossAxisAlignment: CrossAxisAlignment.start,
																									children: [
																										IntrinsicHeight(
																											child: Container(
																												margin: const EdgeInsets.only( bottom: 7),
																												width: double.infinity,
																												child: Row(
																													mainAxisAlignment: MainAxisAlignment.spaceBetween,
																													children: [
																														Text(
																															"02",
																															style: TextStyle(
																																color: Color(0xFF00694C),
																																fontSize: 11,
																																fontWeight: FontWeight.bold,
																															),
																														),
																														Container(
																															decoration: BoxDecoration(
																																borderRadius: BorderRadius.circular(6),
																															),
																															width: 24,
																															height: 24,
																															child: ClipRRect(
																																borderRadius: BorderRadius.circular(6),
																																child: Image.network(
																																	"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ysr4wGraxe/rrk3a4iv_expires_30_days.png",
																																	fit: BoxFit.fill,
																																)
																															)
																														),
																													]
																												),
																											),
																										),
																										IntrinsicHeight(
																											child: Container(
																												width: double.infinity,
																												child: Column(
																													crossAxisAlignment: CrossAxisAlignment.start,
																													children: [
																														Text(
																															"Analisis",
																															style: TextStyle(
																																color: Color(0xFF151C27),
																																fontSize: 12,
																																fontWeight: FontWeight.bold,
																															),
																														),
																														IntrinsicHeight(
																															child: Container(
																																width: double.infinity,
																																child: Column(
																																	crossAxisAlignment: CrossAxisAlignment.start,
																																	children: [
																																		Text(
																																			"Model NLP",
																																			style: TextStyle(
																																				color: Color(0xFF00694C),
																																				fontSize: 12,
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
																									]
																								),
																							),
																						),
																					),
																					Expanded(
																						child: IntrinsicHeight(
																							child: Container(
																								decoration: BoxDecoration(
																									borderRadius: BorderRadius.circular(12),
																									color: Color(0xFFFFFFFF),
																									boxShadow: [
																										BoxShadow(
																											color: Color(0x0D000000),
																											blurRadius: 2,
																											offset: Offset(0, 1),
																										),
																									],
																								),
																								padding: const EdgeInsets.all(10),
																								width: double.infinity,
																								child: Column(
																									crossAxisAlignment: CrossAxisAlignment.start,
																									children: [
																										IntrinsicHeight(
																											child: Container(
																												margin: const EdgeInsets.only( bottom: 7),
																												width: double.infinity,
																												child: Row(
																													mainAxisAlignment: MainAxisAlignment.spaceBetween,
																													children: [
																														Text(
																															"03",
																															style: TextStyle(
																																color: Color(0xFF00694C),
																																fontSize: 11,
																																fontWeight: FontWeight.bold,
																															),
																														),
																														Container(
																															decoration: BoxDecoration(
																																borderRadius: BorderRadius.circular(6),
																															),
																															width: 24,
																															height: 24,
																															child: ClipRRect(
																																borderRadius: BorderRadius.circular(6),
																																child: Image.network(
																																	"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ysr4wGraxe/buabmdyh_expires_30_days.png",
																																	fit: BoxFit.fill,
																																)
																															)
																														),
																													]
																												),
																											),
																										),
																										IntrinsicHeight(
																											child: Container(
																												width: double.infinity,
																												child: Column(
																													crossAxisAlignment: CrossAxisAlignment.start,
																													children: [
																														Text(
																															"Hasil",
																															style: TextStyle(
																																color: Color(0xFF151C27),
																																fontSize: 12,
																																fontWeight: FontWeight.bold,
																															),
																														),
																														IntrinsicHeight(
																															child: Container(
																																width: double.infinity,
																																child: Column(
																																	crossAxisAlignment: CrossAxisAlignment.start,
																																	children: [
																																		Text(
																																			"Skor akurasi",
																																			style: TextStyle(
																																				color: Color(0xFF6D7A73),
																																				fontSize: 12,
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
															margin: const EdgeInsets.only( bottom: 48, left: 18, right: 18),
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
																							color: Color(0xFF00694C),
																						),
																						margin: const EdgeInsets.only( right: 8),
																						width: 28,
																						height: 8,
																						child: SizedBox(),
																					),
																					Container(
																						decoration: BoxDecoration(
																							borderRadius: BorderRadius.circular(9999),
																							color: Color(0xFFBCCAC1),
																						),
																						width: 8,
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
																								"Berikutnya",
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
																									"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ysr4wGraxe/xou4ytr5_expires_30_days.png",
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