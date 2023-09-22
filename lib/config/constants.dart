class Config {
  static const Map envConfig = {
    'dev': {
      "BASE_URL": "https://xxx-dev.com/",
      "PUB_KEY": "",
    },
    'ppe': {
      "BASE_URL": "https://xxx-ppe.com/",
      "PUB_KEY": "",
    },
    'prd': {
      "BASE_URL": "https://xxx-prd.com/",
      "PUB_KEY": "",
    },
  };
  static const String envName = String.fromEnvironment('EnvName');
  static const String env = envName == '' ? 'dev' : envName;
  static const String SENTRY_DSN = '';
  static String get baseUrl => envConfig[env]["BASE_URL"];
  static String get pubKey => envConfig[env]["PUB_KEY"];
  static String get sentryDsn => SENTRY_DSN;
}
