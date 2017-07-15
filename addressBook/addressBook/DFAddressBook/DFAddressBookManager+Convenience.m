//
//  DFAddressBookManager+Convenience.m
//  addressBook
//
//  Created by WANG Haojiao on 2017/7/15.
//  Copyright © 2017年 wang. All rights reserved.
//

#import "DFAddressBookManager+Convenience.h"

@implementation DFAddressBookManager (Convenience)

+ (void)getAddressBookListInDFContactPersonEntityFormat:(DFAddressBookConvenienceBlock)block {
    NSMutableArray<DFContactPersonEntity*>* list = [[NSMutableArray alloc] init];
    [[self manager] requestDeviceAddressBookWithEnumerationBlock:^(CNContact * _Nullable contact, ABRecordRef  _Nullable person) {
        if (contact) {
            [list addObject:[self personFromContact:contact]];
        } else {
            [list addObject:[self personFromRef:person]];
        }
    } andResultBlock:^(BOOL accessGranted) {
        if (!accessGranted) {
            block(NO,nil);
        } else {
            block(YES,list);
        }
    }];
}

+ (DFContactPersonEntity*)personFromRef:(ABRecordRef)person {
    DFContactPersonEntity* dict = [[DFContactPersonEntity alloc] init];
    
    NSString *first = (__bridge NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    dict.firstName = first;
    
    NSString *last = (__bridge NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
    dict.lastName = last;

    ABMultiValueRef tmlphone =  ABRecordCopyValue(person, kABPersonPhoneProperty);
    
    NSString* telphone = (__bridge NSString*)ABMultiValueCopyValueAtIndex(tmlphone, 0);
    DFContactPhoneEntity* aPhone = [[DFContactPhoneEntity alloc] init];
    aPhone.number = telphone;
    dict.phoneNumbers = @[aPhone];
    
    return dict;
}

+ (DFContactPersonEntity*)personFromContact:(CNContact*)contact {
    DFContactPersonEntity* person = [[DFContactPersonEntity alloc] init];
    
    NSString *first = contact.givenName;
    person.firstName = first;
    
    NSString *last = contact.familyName;
    person.lastName = last;
    
    NSArray* phones=contact.phoneNumbers;
    
    NSMutableArray* array = [[NSMutableArray alloc] init];
    for (CNLabeledValue* number in phones) {
        
        CNPhoneNumber* someValue=number.value;
        
        NSString* tem=someValue.stringValue;
        
        DFContactPhoneEntity* phone = [[DFContactPhoneEntity alloc] init];
        phone.number = tem;
        phone.label = [CNLabeledValue localizedStringForLabel:number.label];
        [array addObject:phone];
    }
    person.phoneNumbers = array;
    return person;
}

@end
