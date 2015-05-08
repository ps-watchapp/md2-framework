package de.wwu.md2.android.lib.controller.contentprovider;

import java.io.FileOutputStream;
import java.util.ArrayList;

import org.codehaus.jackson.type.TypeReference;

import android.app.Activity;
import android.content.Context;
import de.wwu.md2.android.lib.MD2Application;
import de.wwu.md2.android.lib.controller.contentprovider.LocalContentProvider;
import de.wwu.md2.android.lib.model.Entity;

public class LocalContentProviderSingle<T extends Entity> extends LocalContentProvider<T> {

	public LocalContentProviderSingle(MD2Application app, TypeReference<?> typeRef, Class<T> entityType,
			boolean isMany, String storageFilename) {
		super(app, typeRef, entityType, isMany, storageFilename);
		// TODO Auto-generated constructor stub
	}
	
	
	
}
