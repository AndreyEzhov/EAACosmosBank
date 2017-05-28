//
//  EAANetworkManager.h
//  EAACosmosBank
//
//  Created by Андрей Ежов on 27.05.17.
//  Copyright © 2017 Андрей Ежов. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EAANetworkManager : NSObject

/**возвращаем все банки, если у нас поменяется URL или формат данных, вместо JSON будет XML, то что бы их получить необходимо будет изменить только этот метод
 */

-(void) get:(NSString*) url
onCompletion:(void (^)(id responseObject, NSError *error)) completionHandler;

@end
