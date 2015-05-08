package de.wwu.md2.android.lib.controller.binding;

import java.io.Serializable;

import android.view.View;
import android.widget.BaseAdapter;
import android.widget.ListView;
import de.wwu.md2.android.lib.controller.binding.Mapping;
import de.wwu.md2.android.lib.controller.binding.PathResolver;
import de.wwu.md2.android.lib.controller.contentprovider.ContentProvider;
import de.wwu.md2.android.lib.controller.events.MD2EventBus;
import de.wwu.md2.android.lib.model.Entity;

public class ListViewMapping<E extends Entity> extends Mapping<E, Integer> {
	
	

	public ListViewMapping(ListView listView, ContentProvider<E> modelContentProvider, PathResolver<E, Integer> resolver, MD2EventBus eventBus, String viewName, String activityName) {
		super(listView, modelContentProvider, resolver, eventBus, viewName,
				activityName);
		// TODO Auto-generated constructor stub
	}



	@Override
	public void updateView() {
		ListView listView = (ListView)this.getView();
		listView.refreshDrawableState();
		listView.invalidate();
		
	}


	@Override
	protected Integer getViewValue() {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	protected void setViewValue(Integer value) {
		// TODO Auto-generated method stub
		
	}


}
