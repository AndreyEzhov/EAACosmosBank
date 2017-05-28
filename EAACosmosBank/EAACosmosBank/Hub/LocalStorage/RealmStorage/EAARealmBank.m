//
//  EAARealmBank.m
//  EAACosmosBank
//
//  Created by Андрей Ежов on 27.05.17.
//  Copyright © 2017 Андрей Ежов. All rights reserved.
//

#import "EAARealmBank.h"

@interface EAARealmBank ()

@property NSString* additionalInfo;
@property NSString* address;
@property NSString* city;
@property NSDate* createdAt;
@property NSString* idStr;
@property NSString* importantInfo;
@property NSDate* modifiedAt;
@property NSString* operations;
@property NSData* partner;
@property NSString* region;
@property NSString* schedule;
@property NSString* title;
@property NSString* type;
@property NSData* links;
@property double locationLon;
@property double locationLat;

@end


//Недостаток реалма в том, что мы не можем хранить NSDictionary и NSArray

@implementation EAARealmBank

-(instancetype)initWithRecord:(EAABankRecord*) record {
    self = [super init];
    if (self) {
        self.additionalInfo = record.additionalInfo;
        self.address = record.address;
        self.city = record.city;
        self.createdAt = record.createdAt;
        self.idStr = record.idStr;
        self.importantInfo = record.importantInfo;
        self.modifiedAt = record.modifiedAt;
        self.operations = record.operations;
        
        self.partner = [NSKeyedArchiver archivedDataWithRootObject:record.partner];
        
        self.region = record.region;
        self.schedule = record.schedule;
        self.title = record.title;
        self.type = record.type;
        self.links = [NSKeyedArchiver archivedDataWithRootObject:record.links];
        
        self.locationLat = record.location.latitude;
        self.locationLon = record.location.longitude;

    }
    return self;
}


-(EAABankRecord*)recordFromRealm {
    
    EAABankRecord* record = [[EAABankRecord alloc] init];
    
    record.additionalInfo = self.additionalInfo;
    record.address = self.address;
    record.city = self.city;
    record.createdAt = self.createdAt;
    record.idStr = self.idStr;
    record.importantInfo = self.importantInfo;
    record.modifiedAt = self.modifiedAt;
    record.operations = self.operations;
    
    record.partner = [NSKeyedUnarchiver unarchiveObjectWithData:self.partner];
    
    record.region = self.region;
    record.schedule = self.schedule;
    record.title = self.title;
    record.type = self.type;
    record.links = [NSKeyedUnarchiver unarchiveObjectWithData:self.links];;
    
    record.location = CLLocationCoordinate2DMake(self.locationLat, self.locationLon);
    
    return record;
}

#pragma mark - realm

+(NSString *)primaryKey {
    return @"idStr";
}

@end
