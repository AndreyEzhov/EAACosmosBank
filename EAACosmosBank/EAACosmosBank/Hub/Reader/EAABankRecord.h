//
//  EAABankRecord.h
//  EAACosmosBank
//
//  Created by Андрей Ежов on 27.05.17.
//  Copyright © 2017 Андрей Ежов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

//Модель с которой мы работаем во всем приложении.

@interface EAABankRecord : NSObject

@property(strong, nonatomic) NSString* additionalInfo;
@property(strong, nonatomic) NSString* address;
@property(strong, nonatomic) NSString* city;
@property(strong, nonatomic) NSDate* createdAt;
@property(strong, nonatomic) NSString* idStr;
@property(strong, nonatomic) NSString* importantInfo;
@property(strong, nonatomic) NSDate* modifiedAt;
@property(strong, nonatomic) NSString* operations;
@property(strong, nonatomic) NSDictionary* partner;
@property(strong, nonatomic) NSString* region;
@property(strong, nonatomic) NSString* schedule;
@property(strong, nonatomic) NSString* title;
@property(strong, nonatomic) NSString* type;
@property(strong, nonatomic) NSArray* links;
@property(assign, nonatomic) CLLocationCoordinate2D location;

@end
