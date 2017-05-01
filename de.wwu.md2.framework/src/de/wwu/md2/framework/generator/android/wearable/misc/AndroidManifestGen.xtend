package de.wwu.md2.framework.generator.android.wearable.misc

import de.wwu.md2.framework.mD2.App
import de.wwu.md2.framework.mD2.ContainerElement

class AndroidManifestGen {	
	
	// generates android manifest for the project
	def static String generateProjectAndroidManifest(App app, Iterable<ContainerElement> rootViews, String packageName)'''
		<?xml version="1.0" encoding="utf-8"?>
		<!-- generated in de.wwu.md2.framework.generator.android.lollipop.misc.AndroidManifest.generateProjectAndroidManifest() -->
		<manifest xmlns:android="http://schemas.android.com/apk/res/android"
		    package="«packageName»" >
		    
		     <uses-feature android:name="android.hardware.type.watch" />
		     
		    <application
		        android:name=".«app.name»"
		        android:allowBackup="true"
		        android:icon="@mipmap/ic_launcher"
		        android:label="TEst"
		        android:theme="@style/AppTheme" >
					<activity
					          android:name=".StartActivity"
					          android:label="@string/app_name" >
					          <intent-filter>
					              <action android:name="android.intent.action.MAIN" />			
					              <category android:name="android.intent.category.LAUNCHER" />
					          </intent-filter>
					      </activity>
					 </application>
		</manifest>
	'''
}