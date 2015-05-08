//
//  ListViewWidget.h
//  Md2Library
//
//  Created by Student LS-PI on 08.08.13.
//
//

#import "Widget.h"
#import "ContentProvider.h"

@interface ListViewWidget : Widget
{
    ContentProvider *provider;
    ContentProvider *selection;
}

@property (retain, nonatomic) UITableView *listView;

-(ContentProvider*) getContentProvider;
-(void) setContentProvider: (ContentProvider*) contentprovider;
-(void) setSelection: (ContentProvider*) selectionProvider;
-(ContentProvider*) getSelection;
@end
