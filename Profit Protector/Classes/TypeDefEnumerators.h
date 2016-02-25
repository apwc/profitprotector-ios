typedef NS_ENUM(NSInteger, AccountStatus)
{
  Pending = 0,
  Denied,
  IncorrectPassword,
  LicenseDisabled,
  Approved
};

typedef NS_ENUM(NSInteger, NumericType)
{
  Numeric = 0,
  Percentage,
  Currency
};

typedef NS_ENUM(NSInteger, PropertyType)
{
  None = 0,
  Full,
  Select
};