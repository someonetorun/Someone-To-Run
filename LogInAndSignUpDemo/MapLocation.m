//
//  MapLocation.m
//  mapExample
//
//  Created by Kat on 8/29/13.
//  Copyright (c) 2013 gonzoCorp. All rights reserved.
//

#import "MapLocation.h"

@implementation MapLocation



-(NSString*)title
{
    
    return @"הנה אני";
}
-(NSString*)subtitle
{
    //make a string for all the address info
    NSMutableString *result =[NSMutableString string];
    
    if (self.street)
    {
        [result appendString:self.street];
    }
    if (self.street && (self.city || self.state ||self.zip))
    {
        [result appendString:@", "];
    }
    if (self.city)
    {
        [result appendString:self.city];
    }
    if (self.city &&self.state)
    {
         [result appendString:@", "];
    }
    if(self.state)
    {
        [result appendString:self.state];
    }
    if(self.zip)
    {
        [result appendFormat:@" %@",self.zip];
    }
    return result;
    
}

@end
