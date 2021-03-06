package de.wwu.pi.mdsd05.library.ref.gui;

import java.awt.Container;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JSeparator;

import de.wwu.pi.mdsd05.framework.gui.AbstractWindow;
import de.wwu.pi.mdsd05.library.ref.logic.ServiceInitializer;

public class StartWindowClass extends AbstractWindow {

	private int curGridY = 0;

	public int getNextGridY() {
		return curGridY++;
	}

	/**
	 * Create the application.
	 */

	public StartWindowClass() {
		super(null);
	}

	/**
	 * Initialize the content of the frame.
	 * 
	 */
	@Override
	public void createContents() {
		Container frame = getPanel();
		frame.setBounds(100, 100, 450, 300);
		GridBagLayout gridBagLayout = new GridBagLayout();
		gridBagLayout.columnWidths = new int[] { 0, 0, 0 };
		frame.setLayout(gridBagLayout);

		JLabel lblNewLabel = new JLabel("Please Select an Option");
		GridBagConstraints gbc_lblNewLabel = new GridBagConstraints();
		gbc_lblNewLabel.gridwidth = 3;
		gbc_lblNewLabel.insets = new Insets(0, 0, 5, 0);
		gbc_lblNewLabel.gridx = 0;
		gbc_lblNewLabel.gridy = getNextGridY();
		frame.add(lblNewLabel, gbc_lblNewLabel);

		// emtpy grid line
		getNextGridY();

		JButton userListWindow = new JButton("List User Elements");
		GridBagConstraints gbc_UserListWindow = new GridBagConstraints();
		gbc_UserListWindow.insets = new Insets(0, 0, 5, 5);
		gbc_UserListWindow.gridx = 1;
		gbc_UserListWindow.gridy = getNextGridY();
		getPanel().add(userListWindow, gbc_UserListWindow);
		userListWindow.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent arg0) {
				new UserListWindow(StartWindowClass.this).open();
			}
		});

		// emtpy grid line
		getNextGridY();

		JButton loanListWindow = new JButton("List Loan Elements");
		GridBagConstraints gbc_LoanListWindow = new GridBagConstraints();
		gbc_LoanListWindow.insets = new Insets(0, 0, 5, 5);
		gbc_LoanListWindow.gridx = 1;
		gbc_LoanListWindow.gridy = getNextGridY();
		getPanel().add(loanListWindow, gbc_LoanListWindow);
		loanListWindow.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent arg0) {
				new LoanListWindow(StartWindowClass.this).open();
			}
		});

		// emtpy grid line
		getNextGridY();

		JButton CDListWindow = new JButton("List CD Elements");
		GridBagConstraints gbc_CDListWindow = new GridBagConstraints();
		gbc_CDListWindow.insets = new Insets(0, 0, 5, 5);
		gbc_CDListWindow.gridx = 1;
		gbc_CDListWindow.gridy = getNextGridY();
		getPanel().add(CDListWindow, gbc_CDListWindow);
		CDListWindow.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent arg0) {
				new CDListWindow(StartWindowClass.this).open();
			}
		});

		// emtpy grid line
		getNextGridY();
		
		
		JButton copyListWindow = new JButton("List Copy Elements");
		GridBagConstraints gbc_CopyListWindow = new GridBagConstraints();
		gbc_CopyListWindow.insets = new Insets(0, 0, 5, 5);
		gbc_CopyListWindow.gridx = 1;
		gbc_CopyListWindow.gridy = getNextGridY();
		getPanel().add(copyListWindow, gbc_CopyListWindow);
		copyListWindow.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent arg0) {
				new CopyListWindow(StartWindowClass.this).open();
			}
		});
		
		// emtpy grid line
		getNextGridY();

		JButton bookListWindow = new JButton("List Book Elements");
		GridBagConstraints gbc_BookListWindow = new GridBagConstraints();
		gbc_BookListWindow.insets = new Insets(0, 0, 5, 5);
		gbc_BookListWindow.gridx = 1;
		gbc_BookListWindow.gridy = getNextGridY();
		getPanel().add(bookListWindow, gbc_BookListWindow);
		bookListWindow.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent arg0) {
				new BookListWindow(StartWindowClass.this).open();
			}
		});

		// Separator at the bottom to create empty
		// space at the end of the window
		JSeparator separator = new JSeparator();
		GridBagConstraints gbc_separator = new GridBagConstraints();
		gbc_separator.insets = new Insets(0, 0, 0, 5);
		gbc_separator.gridx = 1;
		gbc_separator.gridy = getNextGridY();
		gbc_separator.weighty = 1;
		frame.add(separator, gbc_separator);
	}

	@Override
	protected String getTitle() {
		return "Application Start Window";
	}
	
	protected void closeWindow()  {
		ServiceInitializer.serialize();
		super.closeWindow();
	}
	
	public static void main(String[] args) {
		new StartWindowClass().open();
	}
}