//
//  EAALocationManager.m
//  EAACosmosBank
//
//  Created by Андрей Ежов on 28.05.17.
//  Copyright © 2017 Андрей Ежов. All rights reserved.
//

#import "EAALocationManager.h"
#import <MapKit/MapKit.h>

@interface EAALocationManager () <CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    CLLocation* userLocation;
}

@end

@implementation EAALocationManager

-(instancetype)init {
    self = [super init];
    if (self) {
        locationManager = [[CLLocationManager alloc] init];
        
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
            [locationManager requestWhenInUseAuthorization];
        }
        
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [locationManager startUpdatingLocation];
    }
    return self;
}

-(NSString*) distanceCounter:(CLLocationCoordinate2D) coord {
    
    NSString* result;
 
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse) {
        
        result = @"?";
        
    } else {
        
        CLLocation* loc = [[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude];
        CLLocationDistance distance = [userLocation distanceFromLocation:loc];
        
        if (distance > 1000) {
            result = [NSString stringWithFormat:@"%d км", (int)distance/1000];
        } else {
            result = [NSString stringWithFormat:@"%d м", (int)distance];
        }
    }
    
    return [NSString stringWithFormat:@"Расстояние: %@", result];
    
}

#pragma mark - CLLocationManagerDelegate

//Не забываем обновлять расстояние до объектов.
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    
    userLocation = newLocation;
    
    [self.delegate locationDidChanged];
    
}



@end
