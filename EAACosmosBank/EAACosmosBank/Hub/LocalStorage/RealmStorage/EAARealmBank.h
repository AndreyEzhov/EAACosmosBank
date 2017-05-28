//
//  EAARealmBank.h
//  EAACosmosBank
//
//  Created by Андрей Ежов on 27.05.17.
//  Copyright © 2017 Андрей Ежов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "EAABankRecord.h"

RLM_ARRAY_TYPE(EAARealmBank)


@interface EAARealmBank : RLMObject


-(instancetype)initWithRecord:(EAABankRecord*) record;
-(EAABankRecord*)recordFromRealm;

@end
