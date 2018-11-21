//
//  ZHAddressBook.h
//  CGNB
//
//  Created by singers on 2017/10/11.
//  Copyright © 2017年 CGNB. All rights reserved.
//

#import "ZHBasicPlugin.h"

@interface ZHAddressBook : NSObject

-(void)AddressBook:(void(^)(NSString *callback))callbackBlock;

@end
