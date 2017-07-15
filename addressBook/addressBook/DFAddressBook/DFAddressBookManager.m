//
//  DFAddressBookManager.m
//  addressBook
//
//  Created by wanghaojiao on 2017/7/15.
//  Copyright © 2017年 wang. All rights reserved.
//

#import "DFAddressBookManager.h"

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

- (void)requestDeviceAddressBookWithEnumerationBlock:(DFAddressBookEnumBlock)enumeration andResultBlock:(DFAddressBookResultBlock)result {
    if ([[[UIDevice currentDevice] systemVersion] compare:@"9.0" options:NSNumericSearch] == NSOrderedAscending) {
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            if (granted) {
                
                CFArrayRef ref=ABAddressBookCopyArrayOfAllPeople(addressBook);
                
                for (int i=0; i<CFArrayGetCount(ref); i++) {
                    
                    ABRecordRef person = CFArrayGetValueAtIndex(ref, i);
                    
                    enumeration(person,nil);
                }
                
                CFRelease(ref);
                
                result(true);
            } else {
                result(false);
            }
            
        });
    } else {
        CNContactStore* store=[[CNContactStore alloc] init];
        [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                
                id temp=[CNContactFormatter descriptorForRequiredKeysForStyle:CNContactFormatterStyleFullName];
                CNContactFetchRequest* request=[[CNContactFetchRequest alloc] initWithKeysToFetch:@[temp,CNContactPhoneNumbersKey]];
                [store enumerateContactsWithFetchRequest:request error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
                    
                    enumeration(nil,contact);
                }];
                
                result(true);
            } else {
                result(false);
            }
        }];
    }
}

@end
