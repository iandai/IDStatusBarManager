## IDStatusBarManager

IDStatusBarManager provides an easy way to add animation on status bar.  


## Demo

![alt-text](https://github.com/iandai/IDStatusBarManager/blob/master/demo.gif)


## Usage

### IDStatusBarManager

```objective-c
#import "IDStatusBarManager.h"

NSDictionary *attrs = @{ NSFontAttributeName : [UIFont systemFontOfSize:15] };
NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:@"✓ Email has sent." attributes:attrs];
[IDStatusBarManager animatewAt:DRPositionCenter text:attrStr duration:3 completion:^(BOOL finished) {}];
```

## TODO
- Swift support
- iPhoneX support