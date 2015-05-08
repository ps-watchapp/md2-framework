//
//  ContentProviderMany.m
//  Md2Library
//
//  Created by Student LS-PI on 04.07.13.
//
//

#import "ContentProviderMany.h"
#import "DatabaseAccess.h"
#import "Utilities.h"
#import "Filter.h"
#import "DataTransferObject.h"

@implementation ContentProviderMany

static NSString *separator = @".";

-(void) fetchDataObjects
{
    LocalReadRequest *request = [[LocalReadRequest alloc] initWithDataObjectName: dataObjectName filter: filter dataObjectIdentifier: [super getCurrentObjectId]];
    [request execute];
    
    if (request.dataObjects != nil)
    {
        currentDataObjects = request.dataObjects;
    }
}


-(NSArray*) getDataObjects
{
    [self fetchDataObjects];
    return currentDataObjects;
}

/*
-(NSManagedObject *) getDataObject{
    return currentDataObject;
}

-(id) getDataObjectValueForKey: (NSString *) key
{
    if (key != nil)
    {
        if ([key rangeOfString: separator].length != 0)
        {
            NSArray *pathElements = [key componentsSeparatedByString: separator];
            if ([linkedContentProviders valueForKey: [pathElements objectAtIndex: 0]] != nil)
                return [[linkedContentProviders valueForKey: [pathElements objectAtIndex: 0]] getDataObjectValueForKey: [[pathElements subarrayWithRange: NSMakeRange(1, pathElements.count - 1)] componentsJoinedByString: @""]];
            return [[self getLastRelationshipObjectForPathElements: pathElements] valueForKey: [pathElements objectAtIndex: (pathElements.count - 1)]];
        }
        if (currentDataObject != nil)
        {
            if ( [currentDataObject.entity relationshipsByName].count > 0 && [[currentDataObject.entity relationshipsByName] objectForKey: key] != nil)
            {
                NSMutableSet *set = [currentDataObject mutableSetValueForKey: key];
                return set;
            }
            if ([currentDataObject containsAttributeForKey: key])
                return [currentDataObject valueForKey: key];
        }
    }
    return nil;
}

-(void) setDataObjectValue: (id) value forKey: (NSString *) key
{
    if (key != nil && value != nil)
    {
        if (isDebug)
            NSLog(@"key=%@, value=%@", key, value);
        if ([key rangeOfString: separator].length != 0)
        {
            NSArray *pathElements = [key componentsSeparatedByString: separator];
            if ([linkedContentProviders valueForKey: [pathElements objectAtIndex: 0]] != nil)
                [[linkedContentProviders valueForKey: [pathElements objectAtIndex: 0]] setDataObjectValue: value forKey: [[pathElements subarrayWithRange: NSMakeRange(1, pathElements.count - 1)] componentsJoinedByString: @""]];
            id object = [self getLastRelationshipObjectForPathElements: pathElements];
            [object setValue: value forKey: [pathElements objectAtIndex: (pathElements.count - 1)]];
        }
        
        if (currentDataObject != nil && [currentDataObject containsAttributeForKey: key])
        {
            if ([[currentDataObject.entity relationshipsByName] objectForKey: key] != nil)
                [[currentDataObject.entity relationshipsByName] setValue: value forKey: key];
            else
                [currentDataObject setValue: value forKey: key];
        }
        
        //        [self persistDataObject];
    }
}


#pragma mark Data Object Read Methods

-(void) fetchDataObject
{
    LocalReadRequest *request = [[LocalReadRequest alloc] initWithDataObjectName: dataObjectName filter: filter dataObjectIdentifier: [self getCurrentObjectId]];
    [request execute];
    
    if (request.dataObject != nil)
    {
        currentDataObject = request.dataObject;
        
    }
}

#pragma mark Data Object Update Methods

-(void) persistDataObject
{
    if (currentDataObject != nil)
    {
        [[[LocalUpdateRequest alloc] initWithDataObjectName: dataObjectName dataObject: currentDataObject] execute];
        [self saveCurrentObjectId];
    }
}

#pragma mark Data Object Deletion Methods

-(void) removeDataObject
{
    if (currentDataObject != nil)
    {
        [[[LocalDeleteRequest alloc] initWithDataObject: currentDataObject] execute];
        [self persistDataObject];
    }
}

#pragma mark Data Object Creation Methods

-(void) createNewDataObject
{
    LocalCreateRequest *request = [[LocalCreateRequest alloc] initWithDataObjectName: dataObjectName];
    [request execute];
    currentDataObject = request.dataObject;
}


#pragma mark Helper Methods

-(void) saveCurrentObjectId
{
    [[NSUserDefaults standardUserDefaults] setObject: ((DataTransferObject *) currentDataObject).identifier forKey: [NSString stringWithFormat: @"%@%@", dataObjectName, NSStringFromClass([self class])]];
}

-(id) getLastRelationshipObjectForPathElements: (NSArray *) pathElements
{
    id object = currentDataObject;
    id reference = nil;
    for (NSString *element in pathElements)
    {
        if ([pathElements indexOfObject: element] <= (pathElements.count - 2))
        {
            NSString *relationshipName = ((NSRelationshipDescription *) [[[object entity] relationshipsByName] objectForKey: element]).name;
            reference = [object valueForKey: relationshipName];
            object = reference;
        }
        else
            break;
    }
    return object;
}
*/
-(NSNumber *) getCurrentObjectId
{
    return [[NSUserDefaults standardUserDefaults] objectForKey: [NSString stringWithFormat: @"%@%@", dataObjectName, NSStringFromClass([self class])]];
}

-(void) setCurrentDataObject:(int)index{
    currentDataObject = [currentDataObjects objectAtIndex:index];
}

@end
