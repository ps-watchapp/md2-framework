//
//  ListViewWidget.m
//  Md2Library
//
//  Created by Student LS-PI on 08.08.13.
//
//

#import "ListViewWidget.h"

@implementation ListViewWidget

-(id) initWithFrame: (CGRect) frame
{
    self = [super initWithFrame: frame];
    _listView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    if (self)
        [self loadWidget];
    
    return self;
}

-(void) loadWidget
{
    [super loadWidget];
}

-(void) setFrame: (CGRect) frame
{
    [super setFrame: frame];
    [label setFrame: LabelWidgetFrame(frame)]; //TODO adjust
}

-(void) setData: (NSString *) _data
{
    [super setData: _data];
}

-(void) setContentProvider: (ContentProvider*) contentprovider
{
    provider = contentprovider;
}

-(ContentProvider*) getContentProvider
{
    return provider;
}

-(void) setSelection: (ContentProvider*) selectionProvider
{
    selection= selectionProvider;
}

-(ContentProvider*) getSelection
{
    return selection;
}

@end
