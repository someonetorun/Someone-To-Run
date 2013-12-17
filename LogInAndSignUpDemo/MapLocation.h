//
//  MapLocation.h
//  mapExample
//
//  Created by Kat on 8/29/13.
//  Copyright (c) 2013 gonzoCorp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapLocation : NSObject <MKAnnotation>

@property(strong,nonatomic) NSString *street;
@property(strong,nonatomic) NSString *city;
@property(strong,nonatomic) NSString *state;
@property(strong,nonatomic) NSString *zip;
@property(nonatomic,readwrite)  CLLocationCoordinate2D coordinate;



@end
