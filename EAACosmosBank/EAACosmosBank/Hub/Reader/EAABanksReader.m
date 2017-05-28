//
//  EAABanksReader.m
//  EAACosmosBank
//
//  Created by Андрей Ежов on 27.05.17.
//  Copyright © 2017 Андрей Ежов. All rights reserved.
//

#import "EAABanksReader.h"

@implementation EAABanksReader

-(void) readFromObject:(id _Nullable ) object
         forEachRecord:(void (^ _Nonnull)(EAABankRecord* _Nonnull bankRecord)) eachBlock
          onCompletion:(void (^ _Nonnull)(void)) completionBlock {
    
    //очень тщательно проверяем, что бы то, что мы получили из интернета соответствовало нашим ожиданиям
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    
    if ([object isKindOfClass:[NSDictionary class]]) {
        
        NSArray* items = object[@"items"];
        
        if ([items isKindOfClass:[NSArray class]]) {
            
            for (NSDictionary* item in items) {
                
                if ([object isKindOfClass:[NSDictionary class]]) {
                    
                    EAABankRecord* i = [[EAABankRecord alloc] init];
                    
                    i.additionalInfo = item[@"additionalInfo"];
                    i.address = item[@"address"];
                    i.city = item[@"city"];
                    i.createdAt = [dateFormatter dateFromString:item[@"createdAt"]];
                    i.idStr = item[@"id"];
                    i.importantInfo = item[@"importantInfo"];
                    i.links = item[@"links"];
                    i.location = CLLocationCoordinate2DMake([item[@"location"][@"lat"] doubleValue], [item[@"location"][@"lng"] doubleValue]) ;
                    i.modifiedAt = [dateFormatter dateFromString:item[@"modifiedAt"]];
                    i.operations = item[@"operations"];
                    i.partner = item[@"partner"];
                    i.region = item[@"region"];
                    i.schedule = item[@"schedule"];
                    i.title = item[@"title"];
                    i.type = item[@"type"];
                    
                    eachBlock(i);
                }
                
            }
            
        }
        
    }
    
    completionBlock();
}


@end
