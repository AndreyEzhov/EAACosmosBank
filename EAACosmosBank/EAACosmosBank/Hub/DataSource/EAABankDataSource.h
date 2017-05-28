//
//  EAABankDataSource.h
//  EAACosmosBank
//
//  Created by Андрей Ежов on 27.05.17.
//  Copyright © 2017 Андрей Ежов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EAABankRecord.h"

/**Хотим ли мы иметь доступ по ключу в банку? Хотим ли мы искать банк по предикату? или фильтровать их по какому либо признаку?
 С большой вероятностью, хорошей идеей было бы хранить все банки по ключу в NSDictionary или в NSMapTable. Если бы мы захотели отфильтровать например по имени, то мы передали бы предикат в EAABankDataSource, который в свою очередь сделал бы запрос в RealmStorage. В RealmStorage есть возможность проиндексировать по имени, что ускорит поиск. В этот объект нам вернулись бы id подходящих элементов, которые мы бы взяли из NSMapTable/NSDictionary и вернули бы подходящие элементы класса EAABankRecord.
 */

@interface EAABankDataSource : NSObject

/**
 Обновляем хранилище. Как оно будет обновляться и откуда, нас это не касается. Когда все закончится вызовется onCompletion с ошибкой или без нее
 */
-(void) updateOnCompletion:(void (^_Nullable)(NSString* __nullable error)) onCompletion;


-(NSInteger) banksCount;
-(EAABankRecord*_Nonnull) bankAtIndex:(NSInteger) index;

@end
