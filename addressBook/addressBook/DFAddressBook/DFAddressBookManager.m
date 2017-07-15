//
//  DFAddressBookManager.m
//  addressBook
//
//  Created by wanghaojiao on 2017/7/15.
//  Copyright © 2017年 wang. All rights reserved.
//

#import "DFAddressBookManager.h"

@interface DFAddressBookManager()

@property (nonatomic,strong) CNContactStore* store;

@end

@implementation DFAddressBookManager

#pragma mark - singleton
+ (instancetype)manager {
    static DFAddressBookManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (DFAddressBookAuthStatus)authStatus {
    if ([self lessThanIOS9]) {
        ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
        switch (status) {
            case kABAuthorizationStatusDenied:
                return DFAddressBookAuthStatusDenied;
            case kABAuthorizationStatusAuthorized:
                return DFAddressBookAuthStatusAuthorized;
            case kABAuthorizationStatusRestricted:
                return DFAddressBookAuthStatusRestricted;
            default:
                return DFAddressBookAuthStatusNotDetermined;
        }
    } else {
        CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        switch (status) {
            case CNAuthorizationStatusDenied:
                return DFAddressBookAuthStatusDenied;
            case CNAuthorizationStatusAuthorized:
                return DFAddressBookAuthStatusAuthorized;
            case CNAuthorizationStatusRestricted:
                return DFAddressBookAuthStatusRestricted;
            default:
                return DFAddressBookAuthStatusNotDetermined;
        }
    }
}

- (void)requestDeviceAddressBookWithEnumerationBlock:(DFAddressBookEnumBlock)enumeration andResultBlock:(DFAddressBookResultBlock)result {
    if ([self lessThanIOS9]) {
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            if (granted) {
                
                CFArrayRef ref=ABAddressBookCopyArrayOfAllPeople(addressBook);
                
                for (int i=0; i<CFArrayGetCount(ref); i++) {
                    
                    ABRecordRef person = CFArrayGetValueAtIndex(ref, i);
                    
                    enumeration(nil,person);
                }
                
                CFRelease(ref);
                
                result(true);
            } else {
                result(false);
            }
            
        });
    } else {
        [self.store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                
                id temp=[CNContactFormatter descriptorForRequiredKeysForStyle:CNContactFormatterStyleFullName];
                CNContactFetchRequest* request=[[CNContactFetchRequest alloc] initWithKeysToFetch:@[temp,CNContactPhoneNumbersKey]];
                [self.store enumerateContactsWithFetchRequest:request error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
                    
                    enumeration(contact,nil);
                }];
                
                result(true);
            } else {
                result(false);
            }
        }];
    }
}

- (CNContactStore*)store {
    if (!_store) {
        _store =[[CNContactStore alloc] init];
    }
    
    return _store;
}

- (BOOL)lessThanIOS9 {
    return [[[UIDevice currentDevice] systemVersion] compare:@"9.0" options:NSNumericSearch] == NSOrderedAscending;
}

@end
