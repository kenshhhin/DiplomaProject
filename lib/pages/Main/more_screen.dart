import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Экран "Дополнительно", где пользователь может увидеть свой email,
/// перейти в настройки, узнать об приложении и выйти из аккаунта.
class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Получаем текущего пользователя из Firebase Authentication
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Дополнительно"), // Заголовок экрана
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Заголовок "Профиль"
            const Text(
              "Профиль",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            /// Информация о текущем пользователе
            ListTile(
              leading: const Icon(Icons.account_circle, size: 40), // Иконка профиля
              title: Text(user?.email ?? "Неизвестный пользователь"), // Email пользователя или заглушка
              subtitle: const Text("Email пользователя"),
            ),
            const Divider(), // Разделительная линия

            /// Пункт "Настройки"
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Настройки"),
              onTap: () {
                // TODO: Добавить переход на страницу настроек
              },
            ),

            /// Пункт "О приложении"
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text("О приложении"),
              onTap: () {
                // TODO: Добавить переход на страницу "О приложении"
              },
            ),

            const Spacer(), // Занимает всё оставшееся пространство, чтобы кнопка выхода была внизу

            /// Кнопка выхода из аккаунта
            Center(
              child: ElevatedButton.icon(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut(); // Выход из аккаунта
                  Navigator.pushReplacementNamed(context, '/splash'); // Перенаправление на экран входа
                },
                icon: const Icon(Icons.logout), // Иконка выхода
                label: const Text("Выйти"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Красная кнопка
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
