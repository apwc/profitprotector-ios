#import "Singleton.h"

@implementation Singleton

static NSMutableDictionary *_children;

+ (void)initialize
{
  if (!_children)
    _children = [[NSMutableDictionary alloc] init];
  
  [_children setObject:[[self alloc] init]
                forKey:NSStringFromClass([self class])];
}

+ (id)alloc
{
  id c;
  if ((c = [self instance]))
    return c;
  
  return [self allocWithZone:nil];
}

- (id)init
{
  id c;
  if ((c = [_children objectForKey:NSStringFromClass([self class])]))
    return c;
  
  self = [super init];
  return self;
}

+ (id)instance
{
  return [_children objectForKey:NSStringFromClass([self class])];
}

+ (id)singleton
{
  return [self instance];
}

+ (id)new
{
  return [self instance];
}

+ (id)copyWithZone:(NSZone *)zone
{
  return [self instance];
}

+ (id)mutableCopyWithZone:(NSZone *)zone
{
  return [self instance];
}

@end