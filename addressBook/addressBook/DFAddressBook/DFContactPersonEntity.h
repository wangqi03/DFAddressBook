//
//  DFContactPersonEntity.h
//  addressBook
//
//  Created by WANG Haojiao on 2017/7/15.
//  Copyright © 2017年 wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ContactsUI/ContactsUI.h>
#import <AddressBook/AddressBook.h>

//**
@interface DFContactPhoneEntity : NSObject

@property (nonatomic,strong) NSString* label;
@property (nonatomic,strong) NSString* number;

@end

//**
@interface DFContactPersonEntity : NSObject

@property (nonatomic,strong) NSString* firstName;
@property (nonatomic,strong) NSString* lastName;
@property (nonatomic,strong) NSArray<DFContactPhoneEntity*>* phoneNumbers;
@property (nonatomic,strong) NSString* displayName;

@end
