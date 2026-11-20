import 'package:flutter/material.dart';
class Register extends StatefulWidget {
	const Register({super.key});
	@override
	RegisterState createState() => RegisterState();
}
class RegisterState extends State<Register> {
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
											padding: const EdgeInsets.only( top: 32, bottom: 32, left: 25, right: 25),
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
																			padding: const EdgeInsets.only( top: 8),
																			margin: const EdgeInsets.only( bottom: 24),
																			width: double.infinity,
																			child: Column(
																				children: [
																					InkWell(
																						onTap: () { print('Pressed'); },
																						child: IntrinsicWidth(
																							child: IntrinsicHeight(
																								child: Container(
																									decoration: BoxDecoration(
																										borderRadius: BorderRadius.circular(12),
																										color: Color(0xFF00694C),
																									),
																									padding: const EdgeInsets.only( top: 16, bottom: 16, left: 18, right: 18),
																									margin: const EdgeInsets.only( bottom: 12),
																									child: Column(
																										crossAxisAlignment: CrossAxisAlignment.start,
																										children: [
																											Container(
																												width: 32,
																												height: 36,
																												child: Image.network(
																													"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ysr4wGraxe/g01ny3lx_expires_30_days.png",
																													fit: BoxFit.fill,
																												)
																											),
																										]
																									),
																								),
																							),
																						),
																					),
																					Container(
																						margin: const EdgeInsets.only( bottom: 4),
																						child: Text(
																							"Buat Akun HoaxCheck",
																							style: TextStyle(
																								color: Color(0xFF151C27),
																								fontSize: 24,
																								fontWeight: FontWeight.bold,
																							),
																						),
																					),
																					IntrinsicHeight(
																						child: Container(
																							margin: const EdgeInsets.symmetric(horizontal: 19),
																							width: double.infinity,
																							child: Column(
																								children: [
																									Text(
																										"Daftar untuk mulai menggunakan HoaxCheck.",
																										style: TextStyle(
																											color: Color(0xFF3D4A43),
																											fontSize: 14,
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
																				borderRadius: BorderRadius.circular(16),
																				color: Color(0xFFFFFFFF),
																				boxShadow: [
																					BoxShadow(
																						color: Color(0x0D000000),
																						blurRadius: 2,
																						offset: Offset(0, 1),
																					),
																				],
																			),
																			padding: const EdgeInsets.all(24),
																			margin: const EdgeInsets.only( bottom: 24),
																			width: double.infinity,
																			child: Column(
																				crossAxisAlignment: CrossAxisAlignment.start,
																				children: [
																					IntrinsicHeight(
																						child: Container(
																							margin: const EdgeInsets.only( bottom: 16),
																							width: double.infinity,
																							child: Column(
																								crossAxisAlignment: CrossAxisAlignment.start,
																								children: [
																									IntrinsicHeight(
																										child: Container(
																											margin: const EdgeInsets.only( bottom: 4),
																											width: double.infinity,
																											child: Column(
																												crossAxisAlignment: CrossAxisAlignment.start,
																												children: [
																													Text(
																														"Nama Lengkap",
																														style: TextStyle(
																															color: Color(0xFF151C27),
																															fontSize: 12,
																															fontWeight: FontWeight.bold,
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
																												color: Color(0xFFF0F3FF),
																											),
																											padding: const EdgeInsets.only( top: 12, bottom: 12, left: 16, right: 16),
																											width: double.infinity,
																											child: Row(
																												children: [
																													Container(
																														decoration: BoxDecoration(
																															borderRadius: BorderRadius.circular(12),
																														),
																														width: 21,
																														height: 13,
																														child: ClipRRect(
																															borderRadius: BorderRadius.circular(12),
																															child: Image.network(
																																"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ysr4wGraxe/frbbma66_expires_30_days.png",
																																fit: BoxFit.fill,
																															)
																														)
																													),
																													Expanded(
																														child: IntrinsicHeight(
																															child: Container(
																																padding: const EdgeInsets.symmetric(vertical: 1),
																																width: double.infinity,
																																child: Column(
																																	crossAxisAlignment: CrossAxisAlignment.start,
																																	children: [
																																		Text(
																																			"Masukkan nama kamu",
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
																								]
																							),
																						),
																					),
																					IntrinsicHeight(
																						child: Container(
																							margin: const EdgeInsets.only( bottom: 16),
																							width: double.infinity,
																							child: Column(
																								crossAxisAlignment: CrossAxisAlignment.start,
																								children: [
																									IntrinsicHeight(
																										child: Container(
																											margin: const EdgeInsets.only( bottom: 4),
																											width: double.infinity,
																											child: Column(
																												crossAxisAlignment: CrossAxisAlignment.start,
																												children: [
																													Text(
																														"Email",
																														style: TextStyle(
																															color: Color(0xFF151C27),
																															fontSize: 12,
																															fontWeight: FontWeight.bold,
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
																												color: Color(0xFFF0F3FF),
																											),
																											padding: const EdgeInsets.only( top: 12, bottom: 12, left: 16, right: 16),
																											width: double.infinity,
																											child: Row(
																												children: [
																													Container(
																														decoration: BoxDecoration(
																															borderRadius: BorderRadius.circular(12),
																														),
																														width: 24,
																														height: 13,
																														child: ClipRRect(
																															borderRadius: BorderRadius.circular(12),
																															child: Image.network(
																																"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ysr4wGraxe/1yy9tr3a_expires_30_days.png",
																																fit: BoxFit.fill,
																															)
																														)
																													),
																													Expanded(
																														child: IntrinsicHeight(
																															child: Container(
																																padding: const EdgeInsets.symmetric(vertical: 1),
																																width: double.infinity,
																																child: Column(
																																	crossAxisAlignment: CrossAxisAlignment.start,
																																	children: [
																																		Text(
																																			"nama@email.com",
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
																								]
																							),
																						),
																					),
																					IntrinsicHeight(
																						child: Container(
																							margin: const EdgeInsets.only( bottom: 16),
																							width: double.infinity,
																							child: Column(
																								crossAxisAlignment: CrossAxisAlignment.start,
																								children: [
																									IntrinsicHeight(
																										child: Container(
																											margin: const EdgeInsets.only( bottom: 4),
																											width: double.infinity,
																											child: Column(
																												crossAxisAlignment: CrossAxisAlignment.start,
																												children: [
																													Text(
																														"Password",
																														style: TextStyle(
																															color: Color(0xFF151C27),
																															fontSize: 12,
																															fontWeight: FontWeight.bold,
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
																												color: Color(0xFFF0F3FF),
																											),
																											padding: const EdgeInsets.only( top: 12, bottom: 12, left: 16, right: 16),
																											margin: const EdgeInsets.only( bottom: 4),
																											width: double.infinity,
																											child: Row(
																												children: [
																													Container(
																														decoration: BoxDecoration(
																															borderRadius: BorderRadius.circular(12),
																														),
																														width: 21,
																														height: 17,
																														child: ClipRRect(
																															borderRadius: BorderRadius.circular(12),
																															child: Image.network(
																																"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ysr4wGraxe/m8uoqzzv_expires_30_days.png",
																																fit: BoxFit.fill,
																															)
																														)
																													),
																													Expanded(
																														child: IntrinsicHeight(
																															child: Container(
																																padding: const EdgeInsets.only( bottom: 4),
																																width: double.infinity,
																																child: Column(
																																	crossAxisAlignment: CrossAxisAlignment.start,
																																	children: [
																																		IntrinsicHeight(
																																			child: Container(
																																				padding: const EdgeInsets.symmetric(vertical: 1),
																																				margin: const EdgeInsets.only( right: 17),
																																				width: double.infinity,
																																				child: Column(
																																					crossAxisAlignment: CrossAxisAlignment.start,
																																					children: [
																																						Text(
																																							"Minimal 8 karakter",
																																							style: TextStyle(
																																								color: Color(0xFF6D7A73),
																																								fontSize: 14,
																																							),
																																						),
																																					]
																																				),
																																			),
																																		),
																																		IntrinsicHeight(
																																			child: Container(
																																				width: double.infinity,
																																				child: Column(
																																					crossAxisAlignment: CrossAxisAlignment.end,
																																					children: [
																																						Container(
																																							decoration: BoxDecoration(
																																								borderRadius: BorderRadius.circular(12),
																																							),
																																							width: 18,
																																							height: 12,
																																							child: ClipRRect(
																																								borderRadius: BorderRadius.circular(12),
																																								child: Image.network(
																																									"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ysr4wGraxe/was9yx1h_expires_30_days.png",
																																									fit: BoxFit.fill,
																																								)
																																							)
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
																									IntrinsicHeight(
																										child: Container(
																											padding: const EdgeInsets.only( top: 2),
																											width: double.infinity,
																											child: Column(
																												crossAxisAlignment: CrossAxisAlignment.start,
																												children: [
																													IntrinsicWidth(
																														child: IntrinsicHeight(
																															child: Row(
																																children: [
																																	Container(
																																		margin: const EdgeInsets.only( right: 4),
																																		width: 11,
																																		height: 11,
																																		child: Image.network(
																																			"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ysr4wGraxe/dtlj3t76_expires_30_days.png",
																																			fit: BoxFit.fill,
																																		)
																																	),
																																	Text(
																																		"Minimal 8 karakter",
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
																							margin: const EdgeInsets.only( bottom: 16),
																							width: double.infinity,
																							child: Column(
																								crossAxisAlignment: CrossAxisAlignment.start,
																								children: [
																									IntrinsicHeight(
																										child: Container(
																											margin: const EdgeInsets.only( bottom: 4),
																											width: double.infinity,
																											child: Column(
																												crossAxisAlignment: CrossAxisAlignment.start,
																												children: [
																													Text(
																														"Konfirmasi Password",
																														style: TextStyle(
																															color: Color(0xFF151C27),
																															fontSize: 12,
																															fontWeight: FontWeight.bold,
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
																												color: Color(0xFFF0F3FF),
																											),
																											padding: const EdgeInsets.only( top: 12, bottom: 12, left: 16, right: 16),
																											width: double.infinity,
																											child: Row(
																												children: [
																													Container(
																														decoration: BoxDecoration(
																															borderRadius: BorderRadius.circular(12),
																														),
																														width: 24,
																														height: 16,
																														child: ClipRRect(
																															borderRadius: BorderRadius.circular(12),
																															child: Image.network(
																																"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ysr4wGraxe/lainzixh_expires_30_days.png",
																																fit: BoxFit.fill,
																															)
																														)
																													),
																													Expanded(
																														child: IntrinsicHeight(
																															child: Container(
																																padding: const EdgeInsets.symmetric(vertical: 1),
																																width: double.infinity,
																																child: Column(
																																	crossAxisAlignment: CrossAxisAlignment.start,
																																	children: [
																																		Text(
																																			"Masukkan kembali password",
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
																								]
																							),
																						),
																					),
																					IntrinsicHeight(
																						child: Container(
																							padding: const EdgeInsets.only( top: 4),
																							margin: const EdgeInsets.only( bottom: 16),
																							width: double.infinity,
																							child: Row(
																								children: [
																									IntrinsicWidth(
																										child: IntrinsicHeight(
																											child: Container(
																												padding: const EdgeInsets.symmetric(vertical: 2),
																												margin: const EdgeInsets.only( right: 8),
																												child: Column(
																													children: [
																														Container(
																															decoration: BoxDecoration(
																																borderRadius: BorderRadius.circular(2),
																																color: Color(0xFF00694C),
																															),
																															width: 16,
																															height: 16,
																															child: SizedBox(),
																														),
																													]
																												),
																											),
																										),
																									),
																									Text(
																										"Saya menyetujui Kebijakan Privasi HoaxCheck.",
																										style: TextStyle(
																											color: Color(0xFF3D4A43),
																											fontSize: 12,
																										),
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
																									color: Color(0xFF00694C),
																									boxShadow: [
																										BoxShadow(
																											color: Color(0x0D000000),
																											blurRadius: 2,
																											offset: Offset(0, 1),
																										),
																									],
																								),
																								padding: const EdgeInsets.symmetric(vertical: 15),
																								margin: const EdgeInsets.only( top: 8, bottom: 16),
																								width: double.infinity,
																								child: Row(
																									mainAxisAlignment: MainAxisAlignment.center,
																									children: [
																										Container(
																											margin: const EdgeInsets.only( right: 3),
																											child: Text(
																												"Daftar Akun",
																												style: TextStyle(
																													color: Color(0xFFFFFFFF),
																													fontSize: 16,
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
																													"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ysr4wGraxe/an9kbqxu_expires_30_days.png",
																													fit: BoxFit.fill,
																												)
																											)
																										),
																									]
																								),
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
																											color: Color(0x4000694C),
																											blurRadius: 4,
																											offset: Offset(0, 2),
																										),
																									],
																								),
																								padding: const EdgeInsets.symmetric(vertical: 14),
																								width: double.infinity,
																								child: Row(
																									mainAxisAlignment: MainAxisAlignment.center,
																									children: [
																										Container(
																											decoration: BoxDecoration(
																												borderRadius: BorderRadius.circular(12),
																											),
																											margin: const EdgeInsets.only( right: 7),
																											width: 16,
																											height: 16,
																											child: ClipRRect(
																												borderRadius: BorderRadius.circular(12),
																												child: Image.network(
																													"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ysr4wGraxe/ewoegk8n_expires_30_days.png",
																													fit: BoxFit.fill,
																												)
																											)
																										),
																										Text(
																											"Register dengan Google",
																											style: TextStyle(
																												color: Color(0xFF00694C),
																												fontSize: 14,
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
																			width: double.infinity,
																			child: Column(
																				children: [
																					IntrinsicWidth(
																						child: IntrinsicHeight(
																							child: Container(
																								margin: const EdgeInsets.only( bottom: 4),
																								child: Row(
																									children: [
																										Container(
																											margin: const EdgeInsets.only( right: 9),
																											child: Text(
																												"Sudah punya akun? ",
																												style: TextStyle(
																													color: Color(0xFF3D4A43),
																													fontSize: 14,
																												),
																											),
																										),
																										Text(
																											"Masuk",
																											style: TextStyle(
																												color: Color(0xFF00694C),
																												fontSize: 16,
																												fontWeight: FontWeight.bold,
																											),
																										),
																									]
																								),
																							),
																						),
																					),
																					IntrinsicHeight(
																						child: Container(
																							padding: const EdgeInsets.symmetric(vertical: 4),
																							margin: const EdgeInsets.symmetric(horizontal: 45),
																							width: double.infinity,
																							child: Row(
																								children: [
																									Container(
																										margin: const EdgeInsets.only( right: 6),
																										width: 9,
																										height: 12,
																										child: Image.network(
																											"https://storage.googleapis.com/tagjs-prod.appspot.com/v1/ysr4wGraxe/sywzmh2t_expires_30_days.png",
																											fit: BoxFit.fill,
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
																															"Enkripsi 256-bit standar privasi data publik",
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