package de.wwu.md2.framework.generator.android.lollipop

import de.wwu.md2.framework.generator.AbstractPlatformGenerator
import de.wwu.md2.framework.generator.IExtendedFileSystemAccess
import de.wwu.md2.framework.generator.android.lollipop.controller.Activity
import de.wwu.md2.framework.generator.android.lollipop.controller.Application
import de.wwu.md2.framework.generator.android.lollipop.misc.AndroidManifest
import de.wwu.md2.framework.generator.android.lollipop.misc.Gradle
import de.wwu.md2.framework.generator.android.lollipop.misc.Proguard
import de.wwu.md2.framework.generator.android.lollipop.view.Layout
import de.wwu.md2.framework.generator.android.lollipop.view.Values
import de.wwu.md2.framework.generator.util.MD2GeneratorUtil
import de.wwu.md2.framework.mD2.ViewGUIElement

import static de.wwu.md2.framework.util.MD2Util.*
import de.wwu.md2.framework.generator.android.lollipop.util.MD2AndroidLollipopUtil
import org.apache.log4j.Logger

class AndroidLollipopGenerator extends AbstractPlatformGenerator {

	override doGenerate(IExtendedFileSystemAccess fsa) {
		// just for easy breakpoints while debugging

		val dcModel = dataContainer.getModel
		val dcView = dataContainer.getView
		val dcController = dataContainer.getController
		val dcWorkflow = dataContainer.getWorkflow
		val dcContentProvider = dataContainer.getContentProviders
		val dcApps = dataContainer.apps
		val dcMain = dataContainer.main
		val dcRootViews = dataContainer.rootViewContainers
		val dcCustomActions = dataContainer.customActions
		val dcEntities = dataContainer.entities
		val dcEnums = dataContainer.enums
		val dcWorkflowElements = dataContainer.getWorkflowElements		
		
		
		
		val Logger log = Logger.getLogger(this.class)
			
		log.info("Android Lollipop Generator started")

		for (app : dataContainer.apps) {		
		
			log.info("Start: generate app: \"" + app.appName + "\"")
		
			/***************************************************
			 * 
			 * Data for the generators
			 * 
			 ***************************************************/
			// Folders
			val rootFolder = rootFolder + "/md2_app_" + app.name

			// main package and path for java code within the app
			val mainPackage = MD2GeneratorUtil.getBasePackageName(processedInput).replace("^/", ".").toLowerCase
			val mainPath = mainPackage.replace(".", "/") + "/"

			// all root views for current app
			val rootViews = app.workflowElements.map [ wer |
				dataContainer.rootViewContainers.get(wer.workflowElementReference)
			].flatten
			
			// all GUI elements
			val viewGUIElements = rootViews + rootViews.map[rv | rv.eAllContents.filter(ViewGUIElement).toSet].flatten
			
			
			//all workflow elements
			val workflowElements = dataContainer.workflowElementsForApp(app)

			/***************************************************
			 * 
			 * MD2 Library for android
			 * 
			 ***************************************************/
			// copy md2Library in the project
			fsa.generateFileFromInputStream(
				getSystemResource(Settings.MD2_RESOURCE_PATH + Settings.MD2LIBRARY_DEBUG_NAME),
				rootFolder + Settings.MD2LIBRARY_DEBUG_PATH + Settings.MD2LIBRARY_DEBUG_NAME)

			// copy mipmap resources
			// TODO: copy whole folder instead of each file separately
			fsa.generateFileFromInputStream(
				getSystemResource(Settings.MD2_RESOURCE_MIPMAP_PATH + "mipmap-hdpi/ic_launcher.png"),
				rootFolder + Settings.MIPMAP_PATH + "mipmap-hdpi/ic_launcher.png")
			fsa.generateFileFromInputStream(
				getSystemResource(Settings.MD2_RESOURCE_MIPMAP_PATH + "mipmap-mdpi/ic_launcher.png"),
				rootFolder + Settings.MIPMAP_PATH + "mipmap-mdpi/ic_launcher.png")
			fsa.generateFileFromInputStream(
				getSystemResource(Settings.MD2_RESOURCE_MIPMAP_PATH + "mipmap-xhdpi/ic_launcher.png"),
				rootFolder + Settings.MIPMAP_PATH + "mipmap-xhdpi/ic_launcher.png")
			fsa.generateFileFromInputStream(
				getSystemResource(Settings.MD2_RESOURCE_MIPMAP_PATH + "mipmap-xxhdpi/ic_launcher.png"),
				rootFolder + Settings.MIPMAP_PATH + "mipmap-xxhdpi/ic_launcher.png")

			/***************************************************
			 * 
			 * Misc 
			 * Manifest, Gradle and Proguard
			 * 
			 ***************************************************/
			// android manifest					
			fsa.generateFile(rootFolder + Settings.MAIN_PATH + Settings.ANDROID_MANIFEST_NAME,
				AndroidManifest.generateProjectAndroidManifest(app, rootViews, mainPackage))

fsa.generateFile(rootFolder + Settings.MD2LIBRARY_DEBUG_PATH + "somefile.txt",
				Gradle.generateMd2LibrarayBuild)

			// gradle build files
			fsa.generateFile(rootFolder + Settings.MD2LIBRARY_DEBUG_PATH + Settings.GRADLE_BUILD,
				Gradle.generateMd2LibrarayBuild)
			fsa.generateFile(rootFolder + "/" + Settings.GRADLE_BUILD, Gradle.generateProjectBuild)
			fsa.generateFile(rootFolder + "/" + Settings.GRADLE_SETTINGS, Gradle.generateProjectSettings)
			fsa.generateFile(rootFolder + Settings.APP_PATH + Settings.GRADLE_BUILD,
				Gradle.generateAppBuild(mainPackage, dataContainer.main.appVersion))

			// proguard rules
			fsa.generateFile(rootFolder + Settings.APP_PATH + Settings.PROGUARD_RULES_NAME,
				Proguard.generateProjectProguardRules)

			/***************************************************
			 * 
			 * Model
			 * 
			 ***************************************************/
			 fsa.generateFile(rootFolder + )
			 
			 
			/***************************************************
			 * 
			 * View
			 * 
			 ***************************************************/
			// Element Ids
			fsa.generateFile(rootFolder + Settings.VALUES_PATH + Settings.IDS_XML_NAME,
				Values.generateIdsXml(viewGUIElements))

			// Strings
			fsa.generateFile(rootFolder + Settings.VALUES_PATH + Settings.STRINGS_XML_NAME,
				Values.generateStringsXml(app, rootViews, viewGUIElements))

			// Views resource file
			fsa.generateFile(rootFolder + Settings.VALUES_PATH + Settings.VIEWS_XML_NAME,
				Values.generateViewsXml(rootViews, mainPackage))

			// Styles
			fsa.generateFile(rootFolder + Settings.VALUES_PATH + Settings.STYLES_XML_NAME, Values.generateStylesXml)

			// Dimensions
			fsa.generateFile(rootFolder + Settings.VALUES_PATH + Settings.DIMENS_XML_NAME, Values.generateDimensXml)
			
			// Layouts
			Layout.generateLayouts(fsa, rootFolder, mainPath, mainPackage, rootViews)

		/***************************************************
		 * 
		 * Controller
		 * 
		 ***************************************************/
		 
		 // Application class
		 fsa.generateFile(rootFolder + Settings.JAVA_PATH + mainPath + app.name.toFirstUpper + ".java", Application.generateAppClass(mainPackage, app))
		 Activity.generateActivities(fsa, rootFolder, mainPath, mainPackage, rootViews)
		 
		/***************************************************
		 * 
		 * Workflow
		 * 
		 ***************************************************/
		 log.info("End: generate app: \"" + app.appName + "\"")
		}
		log.info("Android Lollipop Generator finished")
	}

	override getPlatformPrefix() {
		Settings.PLATTFORM_PREFIX
	}

}