namespace His\Log;

final class LogLevelNameMap {

  private static dict<arraykey, LogLevelName> $map = dict[
    LogLevel::DEBUG     => LogLevelName::DEBUG,
    LogLevel::INFO      => LogLevelName::INFO,
    LogLevel::NOTICE    => LogLevelName::NOTICE,
    LogLevel::WARNING   => LogLevelName::WARNING,
    LogLevel::ERROR     => LogLevelName::ERROR,
    LogLevel::CRITICAL  => LogLevelName::CRITICAL,
    LogLevel::ALERT     => LogLevelName::ALERT,
    LogLevel::EMERGENCY => LogLevelName::EMERGENCY,
  ];

  public static function mapLevelToName(LogLevel $level): LogLevelName {
    return self::$map[$level];
  }
}