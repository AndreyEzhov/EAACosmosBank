//
//  EAABankDataSource.m
//  EAACosmosBank
//
//  Created by Андрей Ежов on 27.05.17.
//  Copyright © 2017 Андрей Ежов. All rights reserved.
//

#import "EAABankDataSource.h"
#import "EAARealmStorage.h"


@interface EAABankDataSource()

@property(strong, nonatomic) id<EAALocalStorageProtocol> localStorage;
@property(strong, nonatomic) NSArray<EAABankRecord*>* banksArray;

@end



@implementation EAABankDataSource

- (instancetype)init {
    self = [super init];
    if (self) {
        //По большому счету мы можем использовать и не реалмовское хранилище. Можно кордату, а можно и sqlite, а можно и на диск писать. Главное имплементироваться протокол EAALocalStorageProtocol и тогда придется переписать всего один класс не трогая другие
        self.localStorage = [[EAARealmStorage alloc] init];
    }
    return self;
}


-(void) updateOnCompletion:(void (^_Nullable)(NSString* __nullable error)) onCompletion {
    [self.localStorage updateLocalStorageOnCompletion:^(NSString * _Nullable error) {
        self.banksArray = [self.localStorage allBanks];
        onCompletion(error);
    }];

}


-(NSInteger) banksCount {
    return [self.banksArray count];
}

-(EAABankRecord*) bankAtIndex:(NSInteger) index {
    return self.banksArray[index];
}


@end
