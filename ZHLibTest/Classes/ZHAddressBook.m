//
//  ZHAddressBook.m
//  CGNB
//
//  Created by singers on 2017/10/11.
//  Copyright © 2017年 CGNB. All rights reserved.
//

#import "ZHAddressBook.h"
#import <AddressBookUI/AddressBookUI.h>
#import <ContactsUI/ContactsUI.h>
#import <Contacts/Contacts.h>

typedef void(^callBackBlock)(NSString * obj);
@interface ZHAddressBook()<ABPeoplePickerNavigationControllerDelegate,CNContactPickerDelegate>
@property (nonatomic,copy)callBackBlock  callBack;

@end

@implementation ZHAddressBook

-(void)AddressBook:(void(^)(NSString *callback))callbackBlock {
    self.callBack = ^(NSString * obj) {
        callbackBlock (obj);
    };
    
    if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_9_0) {
        CNContactPickerViewController *peoplePicker = [[CNContactPickerViewController alloc] init];
        peoplePicker.delegate = self;
        NSArray *arrKeys = @[CNContactPhoneNumbersKey]; //display only phone numbers
        peoplePicker.displayedPropertyKeys = arrKeys;
        [self.viewController presentViewController:peoplePicker animated:YES completion:nil];
    } else {
        ABPeoplePickerNavigationController *peoplePicker = [ABPeoplePickerNavigationController new];
        peoplePicker.peoplePickerDelegate = self;
        [self.viewController presentViewController:peoplePicker animated:YES completion:nil];
    }
  
}

#pragma mark - ABPeoplePickerNavigationControllerDelegate
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person {
    // 取出电话的数据
    ABMultiValueRef multi = ABRecordCopyValue(person, kABPersonPhoneProperty);
    CFIndex count = ABMultiValueGetCount(multi);
    NSString *phone;
    for (int i = 0; i < count; i++) {
        phone = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(multi, i);
        phone = [phone stringByReplacingOccurrencesOfString:@"-" withString:@" "];
    }
    CFRelease(multi);
    [peoplePicker dismissViewControllerAnimated:YES completion:^{
        if (self.callBack) {
            self.callBack(phone);
        }
    }];
}

#pragma argumentsCNContactPickerDelegate
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty{
    
    CNPhoneNumber *phoneNumber = contactProperty.value;
    NSString *phoneStr;
    @try{
        phoneStr = phoneNumber.stringValue;
        phoneStr = [phoneStr stringByReplacingOccurrencesOfString:@"-" withString:@" "];
        
    }@catch(NSException *exception){
        phoneStr = @"error";
    }@finally{
        [picker dismissViewControllerAnimated:YES completion:^{
            if (self.callBack) {
                self.callBack(phoneStr);
            }
        }];
    }
   
}

@end
