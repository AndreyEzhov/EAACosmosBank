//
//  EAABanksReader.h
//  EAACosmosBank
//
//  Created by Андрей Ежов on 27.05.17.
//  Copyright © 2017 Андрей Ежов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EAABankRecord.h"

@interface EAABanksReader : NSObject

/**Парсим объект который получили из интернета. Если у нас поменяется формат приходящих данных, какие-либо ключи, добавятся поля, то необходимо будет изменить EAABankRecord и этот метод
 */

-(void) readFromObject:(id _Nullable ) object
         forEachRecord:(void (^ _Nonnull)(EAABankRecord* _Nonnull bankRecord)) eachBlock
          onCompletion:(void (^ _Nonnull)(void)) completionBlock;

@end
