//
//  DFAddressBookManager.h
//  addressBook
//
//  Created by wanghaojiao on 2017/7/15.
//  Copyright © 2017年 wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBookUI/AddressBookUI.h>
#import <ContactsUI/ContactsUI.h>
#import <AddressBook/AddressBook.h>
#import <Contacts/Contacts.h>

//only one of them will be assigned
typedef void (^DFAddressBookEnumBlock)(__nullable ABRecordRef person,  CNContact* _Nullable  contact);
typedef void (^DFAddressBookResultBlock)(BOOL accessGranted);

//the class itself
@interface DFAddressBookManager : NSObject

+ (instancetype)manager;

- (void)requestDeviceAddressBookAuth;
- (void)requestDeviceAddressBookWithEnumerationBlock:(DFAddressBookEnumBlock)enumeration andResultBlock:(DFAddressBookResultBlock)result;

@end
