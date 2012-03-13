/*
 *  ofWindowManagerCocoa.mm
 *  openFrameworksLib
 *
 *  Created by Philip Whitfield on 3/8/12.
 *  Copyright 2012 undef.ch. All rights reserved.
 *
 */

#include "ofWindowManagerCocoa.h"

#include "ofWindowCocoa.h"


@interface CocoaAppDelegate : NSObject {
}
- (BOOL)application:(NSApplication *)theApplication openFile:(NSString *)filename;
- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender;
- (void)applicationWillTerminate:(NSNotification *)aNotification;
- (void)applicationWillBecomeActive:(NSNotification *)aNotification;
@end

@implementation CocoaAppDelegate : NSObject
- (BOOL)application:(NSApplication *)theApplication openFile:(NSString *)filename
{
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender
{
}

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
	
}

- (void)applicationWillBecomeActive:(NSNotification *)aNotification
{
}
@end



void ofWindowManagerCocoa::init(){
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

	[NSApplication sharedApplication];	
	
	CocoaAppDelegate *appDelegate = [[CocoaAppDelegate alloc] init];
	[NSApp setDelegate:appDelegate];
	
	[[NSNotificationCenter defaultCenter]
	 postNotificationName:NSApplicationWillFinishLaunchingNotification
	 object:NSApp];
	
	[[NSNotificationCenter defaultCenter]
	 postNotificationName:NSApplicationDidFinishLaunchingNotification
	 object:NSApp];
	
	[pool drain];
}

ofWindow* ofWindowManagerCocoa::createSystemWindow(){
	return new ofWindowCocoa();
}

void ofWindowManagerCocoa::processEvents(){
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSEvent *event =
	[NSApp
	 nextEventMatchingMask:NSAnyEventMask
	 untilDate:[NSDate distantPast]
	 inMode:NSDefaultRunLoopMode
	 dequeue:YES];
	if (event != nil) {
		[NSApp sendEvent:event];
	}
	[NSApp updateWindows];
	[pool drain];
}