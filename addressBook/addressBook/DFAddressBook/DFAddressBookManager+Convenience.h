//
//  DFAddressBookManager+Convenience.h
//  addressBook
//
//  Created by WANG Haojiao on 2017/7/15.
//  Copyright © 2017年 wang. All rights reserved.
//

#import "DFAddressBookManager.h"
#import "DFContactPersonEntity.h"

typedef void (^DFAddressBookConvenienceBlock)(BOOL granted, NSArray<DFContactPersonEntity*>* list);

@interface DFAddressBookManager (Convenience)

+ (void)getAddressBookListInDFContactPersonEntityFormat:(DFAddressBookConvenienceBlock)block;

@end
