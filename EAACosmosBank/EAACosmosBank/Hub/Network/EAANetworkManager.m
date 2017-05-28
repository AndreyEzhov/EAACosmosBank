//
//  EAANetworkManager.m
//  EAACosmosBank
//
//  Created by Андрей Ежов on 27.05.17.
//  Copyright © 2017 Андрей Ежов. All rights reserved.
//

#import "EAANetworkManager.h"
#import <AFNetworking/AFNetworking.h>

@implementation EAANetworkManager

-(void) getAllBanks:(void (^)(id responseObject, NSError *error))completionHandler {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://gymn652.ru/tmp/unicorn.txt-2.json"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:URL
                                                  cachePolicy:NSURLRequestReloadIgnoringCacheData
                                              timeoutInterval:20];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request
                                                completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                                    completionHandler(responseObject, error);
                                                }];
    [dataTask resume];
}

@end
