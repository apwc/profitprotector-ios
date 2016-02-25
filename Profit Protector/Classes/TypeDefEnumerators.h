typedef NS_ENUM(NSInteger, AccountStatus)
{
  Approved = 0,
  Pending,
  Denied,
  IncorrectPassword,
  LicenseDisabled
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