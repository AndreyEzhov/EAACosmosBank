//
//  EAALocalStorageProtocol.h
//  EAACosmosBank
//
//  Created by Андрей Ежов on 27.05.17.
//  Copyright © 2017 Андрей Ежов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EAABankRecord.h"

@protocol EAALocalStorageProtocol <NSObject>

-(void) updateLocalStorageOnCompletion:(void (^_Nonnull)(NSString* __nullable error)) onCompletion;
-(NSArray<EAABankRecord*>*_Nonnull) allBanks;

@end
