//
//  EAARealmStorage.m
//  EAACosmosBank
//
//  Created by Андрей Ежов on 27.05.17.
//  Copyright © 2017 Андрей Ежов. All rights reserved.
//

#import "EAARealmStorage.h"
#import "EAABanksReader.h"
#import "EAAHub.h"
#import "EAARealmBank.h"


@interface EAARealmStorage ()

@property (strong, nonatomic) EAABanksReader* reader;
@property (weak, nonatomic) EAANetworkManager* netManager;
@property (strong, nonatomic) RLMRealm* realm;

@end



@implementation EAARealmStorage


-(instancetype)init {
    self = [super init];
    if (self) {
        self.reader = [[EAABanksReader alloc] init];
        self.realm = [RLMRealm defaultRealm];
    }
    return self;
}


#pragma mark - EAALocalStorageProtocol

-(void) updateLocalStorageOnCompletion:(void (^_Nonnull)(NSString* __nullable error)) onCompletion {
    
    //Получив ответ, обновляем базу. Тут хороший вопрос, что если в ответе не будет каких-либо точек, которые уже есть в базе. Можно конечно удалять базу и писать как с нуля, а может есть запрос, который вернет ID удаленных точек. Оставим пока этот вопрос
    
    [self.netManager get:GET_ALL_BANKS_URL
            onCompletion:^(id responseObject, NSError *error) {
                
                if (error) {
                    
                    onCompletion(error.localizedDescription);
                    
                } else {
                    
                    NSMutableArray<EAARealmBank*>* realmBanks = [NSMutableArray array];
                    
                    [self.reader readFromObject:responseObject
                                  forEachRecord:^(EAABankRecord * _Nonnull bankRecord) {
                                      
                                      EAARealmBank* realmUnit = [[EAARealmBank alloc] initWithRecord:bankRecord];
                                      if (realmUnit) {
                                          [realmBanks addObject:realmUnit];
                                      }
                                      
                                  } onCompletion:^{
                                      
                                      [self.realm transactionWithBlock:^{
                                          [self.realm addOrUpdateObjectsFromArray:realmBanks];
                                      }];
                                      
                                      onCompletion(nil);
                                      
                                  }];
                }
                
            }];
    
}


-(NSArray<EAABankRecord*>*) allBanks {
    
    RLMResults * result = [EAARealmBank allObjects];
    
    NSMutableArray* allBanks = [[NSMutableArray alloc] initWithCapacity:[result count]];
    
    for (EAARealmBank* bank in result) {
        [allBanks addObject:[bank recordFromRealm]];
    }
    
    return allBanks;
}


-(EAANetworkManager *)netManager {
    if (_netManager == nil) {
        _netManager = [EAAHub sharedManager].networkManager;
    }
    return _netManager;
}

@end
