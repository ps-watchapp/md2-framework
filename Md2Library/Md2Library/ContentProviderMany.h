//
//  ContentProviderMany.h
//  Md2Library
//
//  Created by Student LS-PI on 04.07.13.
//
//

#import <Foundation/Foundation.h>
#import "ContentProvider.h"

@interface ContentProviderMany : ContentProvider
{
    NSArray *currentDataObjects;
    //NSManagedObject *currentDataObject;
}

-(NSArray *) getDataObjects;
-(void) setCurrentDataObject: (int)index;


@end
