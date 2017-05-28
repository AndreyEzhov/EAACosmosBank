//
//  EAAHub.h
//  EAACosmosBank
//
//  Created by Андрей Ежов on 27.05.17.
//  Copyright © 2017 Андрей Ежов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EAABankDataSource.h"
#import "EAANetworkManager.h"
#import "EAABanksReader.h"

@interface EAAHub : NSObject

//Хранилище данных. Здесь мы храним объекты унаследованные от NSObject, с которыми мы можем работать в любом потоке. Объекты не должны дублироваться и если мы хотим до них достучаться мы используем это хранилище.
@property(strong, nonatomic) EAABankDataSource* banksDataSource;

//Объект который умеет ходить в сеть и приносить сырые данные. Пускай он всегда будет в памяти и мы всегда будем иметь к нему доступ
@property(strong, nonatomic) EAANetworkManager* networkManager;



+ (instancetype)sharedManager;

@end
