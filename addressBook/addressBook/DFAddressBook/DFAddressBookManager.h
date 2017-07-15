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

// MARK: - blocks & enums
//only one of them will be assigned
typedef void (^DFAddressBookEnumBlock)(CNContact* _Nullable  contact, __nullable ABRecordRef person);

//result block
typedef void (^DFAddressBookResultBlock)(BOOL accessGranted);

//auth status
typedef enum {
    DFAddressBookAuthStatusNotDetermined,
    DFAddressBookAuthStatusRestricted,
    DFAddressBookAuthStatusDenied,
    DFAddressBookAuthStatusAuthorized
} DFAddressBookAuthStatus;

// MARK: - the class itself
@interface DFAddressBookManager : NSObject

// MARK: instance
+ (instancetype _Nonnull )manager;

// MARK: getters
- (DFAddressBookAuthStatus)authStatus;
- (void)requestDeviceAddressBookWithEnumerationBlock:(DFAddressBookEnumBlock _Nullable )enumeration andResultBlock:(DFAddressBookResultBlock _Nullable )result;


@end
