package de.wwu.pi.mdsd.umlToApp.data;

import org.eclipse.uml2.uml.Class

class StartWindowClassGenerator {
	def generateStartWindowClass(Iterable<Class> clazzes) '''
	package somePackageString.gui;

import java.awt.GridBagConstraints;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.UIManager;
import javax.swing.UnsupportedLookAndFeelException;

import de.wwu.pi.mdsd.framework.gui.AbstractStartWindow;
import somePackageString.logic.ServiceInitializer;

public class StartWindowClass extends AbstractStartWindow {

	@Override
	protected void ListChoices() {
		�FOR clazz:clazzes�
		JButton �clazz.name�ListWindow = new JButton("List �clazz.name� Elements");
		GridBagConstraints gbc_�clazz.name�ListWindow = new GridBagConstraints();
		gbc_�clazz.name�ListWindow.insets = new Insets(0, 0, 5, 5);
		gbc_�clazz.name�ListWindow.gridx = 1;
		gbc_�clazz.name�ListWindow.gridy = getNextGridY();
		getPanel().add(�clazz.name�ListWindow, gbc_�clazz.name�ListWindow);
		�clazz.name�ListWindow.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent arg0) {
				new �clazz.name�ListWindow(StartWindowClass.this).open();
			}
		});
		�ENDFOR�
		
	}
	
	@Override
	protected void closeWindow()  {
		ServiceInitializer.serialize();
		super.closeWindow();
	}
	
	public static void main(String[] args) throws ClassNotFoundException, InstantiationException, IllegalAccessException, UnsupportedLookAndFeelException {
		UIManager.setLookAndFeel(
			UIManager.getSystemLookAndFeelClassName());
			//"com.sun.java.swing.plaf.windows.WindowsLookAndFeel");
		new StartWindowClass().open();
	}
}

	'''
}
