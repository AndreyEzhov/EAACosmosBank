//
//  EAAHub.m
//  EAACosmosBank
//
//  Created by Андрей Ежов on 27.05.17.
//  Copyright © 2017 Андрей Ежов. All rights reserved.
//

#import "EAAHub.h"
#import "EAARealmStorage.h"


@implementation EAAHub

+ (instancetype)sharedManager {
    static EAAHub *hub = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hub = [[self alloc] init];
    });
    return hub;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.banksDataSource = [[EAABankDataSource alloc] init];
        self.networkManager = [[EAANetworkManager alloc] init];
    }
    return self;
}

@end
