namespace His\Log;

enum LogLevel : int as int {
  EMERGENCY = 800;
  ALERT = 700;
  CRITICAL = 600;
  ERROR = 500;
  WARNING = 400;
  NOTICE = 300;
  INFO = 200;
  DEBUG = 100;
}