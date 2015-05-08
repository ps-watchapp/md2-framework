package de.wwu.md2.framework.generator.android

import de.wwu.md2.framework.mD2.ContainerElement
import de.wwu.md2.framework.generator.util.DataContainer
import de.wwu.md2.framework.generator.android.util.JavaClassDef
import de.wwu.md2.framework.mD2.List
import de.wwu.md2.framework.mD2.ReferencedModelType
import de.wwu.md2.framework.mD2.Entity
import de.wwu.md2.framework.mD2.PathDefinition
import de.wwu.md2.framework.mD2.ViewElementType
import de.wwu.md2.framework.mD2.ViewElementRef
import de.wwu.md2.framework.mD2.ViewElementDef
import de.wwu.md2.framework.mD2.GridLayoutPane
import de.wwu.md2.framework.mD2.FlowLayoutPane
import de.wwu.md2.framework.mD2.ViewGUIElement
import de.wwu.md2.framework.mD2.MappingTask

class CheckboxList {
	
	def generateCheckboxList(String basePackage, ViewGUIElement e, DataContainer dataContainer) '''
	
package «basePackage».adapter;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import de.wwu.md2.android.lib.controller.contentprovider.LocalContentProviderMany;
import de.wwu.masterthesis.reference.android.models.Contact;
import de.wwu.masterthesis.reference.android.models.Group;
import «basePackage».models.«((e as List).itemtype as ReferencedModelType).entity.name.toFirstUpper»;
import «basePackage».models.«((getMapping(e, dataContainer) as PathDefinition).tail.attributeRef.eContainer as Entity).name»;
import «basePackage».R;
import de.wwu.md2.android.lib.model.Entity;

import android.content.Context;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.CheckBox;
import android.widget.TextView;

public class CheckboxAdapter<E extends Entity, T extends Entity> extends ArrayAdapter<E>{
	
	private ArrayList<E> contentList;
	private LocalContentProviderMany<T> selectionContentProvider;
	private Context context;
	private ViewHolder holder; 


	public CheckboxAdapter(Context context, int resource, int textViewResourceId, ArrayList<E> contentList, LocalContentProviderMany<T> selectionContentProvider) {
		super(context, resource, textViewResourceId, contentList);
		this.contentList = contentList;
		this.selectionContentProvider = selectionContentProvider;
		this.context = context;
		this.holder = null;
	}
	
	private class ViewHolder {
		   protected CheckBox checkbox;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	  public View getView(final int position, View convertView, ViewGroup parent) {
		
	   Log.v("ConvertView", String.valueOf(position));
	  
	   final E contentItem = contentList.get(position);
	   if (convertView == null) {
		   LayoutInflater vi = (LayoutInflater)context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
		   convertView = vi.inflate(R.layout.checkboxlist, null);
		   
		   holder = new ViewHolder();
		   
		   //cache the view
		   holder.checkbox = (CheckBox) convertView.findViewById(R.id.checkBox1);
		   holder.checkbox.setText(((«((e as List).itemtype as ReferencedModelType).entity.name.toFirstUpper») contentItem).getName());
		   holder.checkbox.setTag(contentItem);

			if(((«((getMapping(e, dataContainer) as PathDefinition).tail.attributeRef.eContainer as Entity).name») selectionContentProvider.getEntity()).get«(getMapping(e, dataContainer) as PathDefinition).tail.attributeRef.name.toFirstUpper»().contains(contentItem)){
				holder.checkbox.setChecked(true);
			}
			else{
			  	holder.checkbox.setChecked(false);
			}
		 
		   //link the chached views to the convertview
		   convertView.setTag(holder); 
	   }
	   else {
			if(((«((getMapping(e, dataContainer) as PathDefinition).tail.attributeRef.eContainer as Entity).name») selectionContentProvider.getEntity()).get«(getMapping(e, dataContainer) as PathDefinition).tail.attributeRef.name.toFirstUpper»().contains(contentItem)){
			//if(!equalItems(((ArrayList<E>) ((«((getMapping(e, dataContainer) as PathDefinition).tail.attributeRef.eContainer as Entity).name») selectionContentProvider.getEntity()).get«((e as List).itemtype as ReferencedModelType).entity.name.toFirstUpper»()), contentItem)){
				holder.checkbox.setChecked(true);
			}
			else{
			  	holder.checkbox.setChecked(false);
			}
	    holder = (ViewHolder) convertView.getTag();
	    
	   }
	   
	   
	   this.notifyDataSetChanged();
	   convertView.refreshDrawableState();
	   holder.checkbox.setOnClickListener(new OnClickListener() {
		
		@SuppressWarnings("unchecked")
		@Override
		public void onClick(View v) {
			if(!((«((getMapping(e, dataContainer) as PathDefinition).tail.attributeRef.eContainer as Entity).name») selectionContentProvider.getEntity()).get«(getMapping(e, dataContainer) as PathDefinition).tail.attributeRef.name.toFirstUpper»().contains(contentItem)){
			//if(!equalItems(((ArrayList<E>) ((Contact) selectionContentProvider.getEntity()).get«(getMapping(e, dataContainer) as PathDefinition).tail.attributeRef.name.toFirstUpper»()), contentItem)){
			    ((«((getMapping(e, dataContainer) as PathDefinition).tail.attributeRef.eContainer as Entity).name») selectionContentProvider.getEntity()).get«(getMapping(e, dataContainer) as PathDefinition).tail.attributeRef.name.toFirstUpper»().add((«((e as List).itemtype as ReferencedModelType).entity.name.toFirstUpper») contentItem);
			}
			else{
			    ((«((getMapping(e, dataContainer) as PathDefinition).tail.attributeRef.eContainer as Entity).name») selectionContentProvider.getEntity()).get«(getMapping(e, dataContainer) as PathDefinition).tail.attributeRef.name.toFirstUpper»().remove(contentItem);
			}
	       v.refreshDrawableState();
			
		}
	});
	 
	   return convertView;
	  }
	
	private boolean equalItems(ArrayList<E> itemList, E item){
		boolean contains = false;
		 for(Iterator<E> i = itemList.iterator(); i.hasNext(); ){
			 if(i.next().getInternalId() == (item.getInternalId()))
				 contains = true;
		 }
		
		return contains;
		
	}

}
	
	'''
/////////////////////////////////////////
	// Helper methods
	/////////////////////////////////////////
	

	
	def private static getMapping(ViewGUIElement element, DataContainer dataContainer){
	var PathDefinition pd = null;
	for(customAction : dataContainer.customActions)
	{
		for(fragment : customAction.codeFragments){
			if(fragment instanceof MappingTask){
				if((fragment as MappingTask).selection){
					if((fragment as MappingTask).selection && (fragment as MappingTask).referencedViewField.ref.equals(element)){
					pd =(fragment as MappingTask).pathDefinition;
				}
				}
			}
		}
	}
	pd;
   }	
}