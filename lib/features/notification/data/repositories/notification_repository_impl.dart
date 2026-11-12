import '../datasources/notification_remote_data_source.dart';
import '../models/notification_model.dart';

abstract class NotificationRepository {
  Future<List<NotificationModel>> getNotifications();
  Future<void> markAsRead(String id);
  Future<void> markAllAsRead();
  Future<void> addNotification({
    required String title,
    required String description,
    required String tagLabel,
    String? timeLabel,
    String? userId,
  });
}

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource remoteDataSource;

  NotificationRepositoryImpl({NotificationRemoteDataSource? remoteDataSource})
      : remoteDataSource = remoteDataSource ?? NotificationRemoteDataSourceImpl();

  @override
  Future<List<NotificationModel>> getNotifications() {
    return remoteDataSource.getNotifications();
  }

  @override
  Future<void> markAsRead(String id) {
    return remoteDataSource.markAsRead(id);
  }

  @override
  Future<void> markAllAsRead() {
    return remoteDataSource.markAllAsRead();
  }

  @override
  Future<void> addNotification({
    required String title,
    required String description,
    required String tagLabel,
    String? timeLabel,
    String? userId,
  }) {
    return remoteDataSource.addNotification(
      title: title,
      description: description,
      tagLabel: tagLabel,
      timeLabel: timeLabel,
      userId: userId,
    );
  }
}
