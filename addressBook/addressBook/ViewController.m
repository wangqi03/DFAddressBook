//
//  ViewController.m
//  addressBook
//
//  Created by wanghaojiao on 2017/7/15.
//  Copyright © 2017年 wang. All rights reserved.
//

#import "ViewController.h"
#import "DFAddressBookManager+Convenience.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)clickedGet:(id)sender {
    //*
    [DFAddressBookManager getAddressBookListInDFContactPersonEntityFormat:^(BOOL granted, NSArray<DFContactPersonEntity *> *list) {
        
    }];
    /*/
    [[DFAddressBookManager manager] requestDeviceAddressBookWithEnumerationBlock:^(CNContact * _Nullable contact, ABRecordRef  _Nullable person) {
        
    } andResultBlock:^(BOOL accessGranted) {
        
    }];//*/
}


@end
