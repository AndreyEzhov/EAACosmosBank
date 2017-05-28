//
//  EAALocationManager.h
//  EAACosmosBank
//
//  Created by Андрей Ежов on 28.05.17.
//  Copyright © 2017 Андрей Ежов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@protocol EAALocationManagerDelegate <NSObject>

-(void)locationDidChanged;

@end


@interface EAALocationManager : NSObject

@property(weak, nonatomic) id<EAALocationManagerDelegate> delegate;

//Может стоит возвращать int, с указанием размерности или уже готовую строку, как сейчас. Зависит от дальнейших задач
-(NSString*) distanceCounter:(CLLocationCoordinate2D) coord;

@end
