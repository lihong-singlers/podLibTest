//
//  ZHAddressBook.h
//  CGNB
//
//  Created by singers on 2017/10/11.
//  Copyright © 2017年 CGNB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHAddressBook : NSObject

@property (nonatomic,weak)UIViewController *viewController;

-(void)AddressBook:(void(^)(NSString *callback))callbackBlock;



@end
