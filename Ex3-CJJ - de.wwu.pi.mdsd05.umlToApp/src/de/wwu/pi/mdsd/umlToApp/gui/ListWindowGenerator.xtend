package de.wwu.pi.mdsd.umlToApp.gui

import org.eclipse.uml2.uml.Class
import static extension de.wwu.pi.mdsd.umlToApp.util.ModelAndPackageHelper.*

class ListWindowGenerator {
	def generateListWindow(Class clazz) 
		
	 '''
package �PACKAGE_STRING�.gui;

import java.util.Vector;

import de.wwu.pi.mdsd.framework.gui.AbstractListWindow;
import de.wwu.pi.mdsd.framework.gui.AbstractWindow;
import �PACKAGE_STRING�.logic.ServiceInitializer; 
import �PACKAGE_STRING�.data.�clazz.name�;
�FOR ext:clazz.listOfExtendingClasses�
	import �PACKAGE_STRING�.data.�ext.name�;
�ENDFOR�
	
public class �clazz.name�ListWindow extends AbstractListWindow<�clazz.name�> implements �clazz.name�ListingInterface{

	public �clazz.name�ListWindow(AbstractWindow parent) {
		super(parent);
	}

	@Override
	public void showEntryWindow(�clazz.name� entity) {
		//If entity is null -> initialize entity as new entity
		//show Entity Edit Window
		�IF clazz.listOfExtendingClasses.size==0�
		if(entity == null)
			entity = new �clazz.name�();
		new �clazz.name�EntryWindow(this,entity).open();
		�ELSE�
		if(entity == null) {
			�FOR ext:clazz.listOfExtendingClasses�
			if(cb_select.getSelectedItem().equals("�ext.name�"))
				entity = new �ext.name�();
			�ENDFOR�
		}
		�FOR ext:clazz.listOfExtendingClasses�
			if(entity instanceof �ext.name�)
				new �ext.name�EntryWindow(this, (�ext.name�) entity).open();
			�ENDFOR�
		�ENDIF�
	}
	
	�IF clazz.listOfExtendingClasses.size>0�
	javax.swing.JComboBox<String> cb_select;
	@Override //overrides superclass method to add a select box to the window
	public void createContents() {
		super.createContents();
		cb_select = new javax.swing.JComboBox<>();
		�FOR ext:clazz.listOfExtendingClasses�
			cb_select.addItem("�ext.name�");
		�ENDFOR�
		java.awt.GridBagConstraints gbc_btnAdd = new java.awt.GridBagConstraints();
		gbc_btnAdd.insets = new java.awt.Insets(0, 0, 5, 5);
		gbc_btnAdd.gridx = 1;
		gbc_btnAdd.gridy = 2;
		getPanel().add(cb_select, gbc_btnAdd);
	}
	�ENDIF�

	@Override
	public Vector<�clazz.name�> getElements() {
		return new Vector<�clazz.name�>(ServiceInitializer.getProvider().get�clazz.name.toFirstUpper�Service().getAll());
	}
	
	@Override
	public void initialize�clazz.name.toFirstUpper�Listings() {
		initializeList();
	}
}

interface �clazz.name�ListingInterface {
	public void initialize�clazz.name.toFirstUpper�Listings();
}
	'''
}

	

