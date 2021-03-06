package library.loans;

import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import java.awt.GridBagLayout;
import javax.swing.JTextField;
import java.awt.GridBagConstraints;
import javax.swing.JLabel;
import java.awt.Insets;
import javax.swing.JButton;

public class ManageLoans_old extends JFrame {

	private JPanel contentPane;
	private JTextField textField;
	private JTextField textField_1;
	private JTextField textField_2;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					ManageLoans_old frame = new ManageLoans_old();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the frame.
	 */
	public ManageLoans_old() {
		setTitle("Manage Loans");
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 450, 300);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		GridBagLayout gbl_contentPane = new GridBagLayout();
		gbl_contentPane.columnWidths = new int[]{0, 0, 0};
		gbl_contentPane.rowHeights = new int[]{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
		gbl_contentPane.columnWeights = new double[]{0.0, 1.0, Double.MIN_VALUE};
		gbl_contentPane.rowWeights = new double[]{1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, 0.0, 1.0, Double.MIN_VALUE};
		contentPane.setLayout(gbl_contentPane);
		
		JLabel lblRetrieveABook = new JLabel("Retrieve a loan:");
		GridBagConstraints gbc_lblRetrieveABook = new GridBagConstraints();
		gbc_lblRetrieveABook.anchor = GridBagConstraints.EAST;
		gbc_lblRetrieveABook.insets = new Insets(0, 0, 5, 5);
		gbc_lblRetrieveABook.gridx = 0;
		gbc_lblRetrieveABook.gridy = 1;
		contentPane.add(lblRetrieveABook, gbc_lblRetrieveABook);
		
		JLabel lblIsbn = new JLabel("Inventory Number");
		GridBagConstraints gbc_lblIsbn = new GridBagConstraints();
		gbc_lblIsbn.insets = new Insets(0, 0, 5, 5);
		gbc_lblIsbn.anchor = GridBagConstraints.EAST;
		gbc_lblIsbn.gridx = 0;
		gbc_lblIsbn.gridy = 2;
		contentPane.add(lblIsbn, gbc_lblIsbn);
		
		textField = new JTextField();
		GridBagConstraints gbc_textField = new GridBagConstraints();
		gbc_textField.insets = new Insets(0, 0, 5, 0);
		gbc_textField.fill = GridBagConstraints.HORIZONTAL;
		gbc_textField.gridx = 1;
		gbc_textField.gridy = 2;
		contentPane.add(textField, gbc_textField);
		textField.setColumns(10);
		
		JLabel lblUserId = new JLabel("User ID");
		GridBagConstraints gbc_lblUserId = new GridBagConstraints();
		gbc_lblUserId.anchor = GridBagConstraints.EAST;
		gbc_lblUserId.insets = new Insets(0, 0, 5, 5);
		gbc_lblUserId.gridx = 0;
		gbc_lblUserId.gridy = 3;
		contentPane.add(lblUserId, gbc_lblUserId);
		
		textField_1 = new JTextField();
		textField_1.setColumns(10);
		GridBagConstraints gbc_textField_1 = new GridBagConstraints();
		gbc_textField_1.insets = new Insets(0, 0, 5, 0);
		gbc_textField_1.fill = GridBagConstraints.HORIZONTAL;
		gbc_textField_1.gridx = 1;
		gbc_textField_1.gridy = 3;
		contentPane.add(textField_1, gbc_textField_1);
		
		JLabel lblIssueDate = new JLabel("Issue Date");
		GridBagConstraints gbc_lblIssueDate = new GridBagConstraints();
		gbc_lblIssueDate.anchor = GridBagConstraints.EAST;
		gbc_lblIssueDate.insets = new Insets(0, 0, 5, 5);
		gbc_lblIssueDate.gridx = 0;
		gbc_lblIssueDate.gridy = 4;
		contentPane.add(lblIssueDate, gbc_lblIssueDate);
		
		textField_2 = new JTextField();
		textField_2.setColumns(10);
		GridBagConstraints gbc_textField_2 = new GridBagConstraints();
		gbc_textField_2.insets = new Insets(0, 0, 5, 0);
		gbc_textField_2.fill = GridBagConstraints.HORIZONTAL;
		gbc_textField_2.gridx = 1;
		gbc_textField_2.gridy = 4;
		contentPane.add(textField_2, gbc_textField_2);
		
		JButton btnNewButton = new JButton("Retrieve");
		GridBagConstraints gbc_btnNewButton = new GridBagConstraints();
		gbc_btnNewButton.insets = new Insets(0, 0, 5, 0);
		gbc_btnNewButton.anchor = GridBagConstraints.WEST;
		gbc_btnNewButton.gridx = 1;
		gbc_btnNewButton.gridy = 5;
		contentPane.add(btnNewButton, gbc_btnNewButton);
		
		JLabel lblCreateABook = new JLabel("Create loan:");
		GridBagConstraints gbc_lblCreateABook = new GridBagConstraints();
		gbc_lblCreateABook.anchor = GridBagConstraints.EAST;
		gbc_lblCreateABook.insets = new Insets(0, 0, 5, 5);
		gbc_lblCreateABook.gridx = 0;
		gbc_lblCreateABook.gridy = 7;
		contentPane.add(lblCreateABook, gbc_lblCreateABook);
		
		JButton btnCreate = new JButton("Create");
		GridBagConstraints gbc_btnCreate = new GridBagConstraints();
		gbc_btnCreate.insets = new Insets(0, 0, 5, 0);
		gbc_btnCreate.anchor = GridBagConstraints.WEST;
		gbc_btnCreate.gridx = 1;
		gbc_btnCreate.gridy = 7;
		contentPane.add(btnCreate, gbc_btnCreate);
		
		JLabel lblListAllBooks = new JLabel("List all loans:");
		GridBagConstraints gbc_lblListAllBooks = new GridBagConstraints();
		gbc_lblListAllBooks.anchor = GridBagConstraints.EAST;
		gbc_lblListAllBooks.insets = new Insets(0, 0, 5, 5);
		gbc_lblListAllBooks.gridx = 0;
		gbc_lblListAllBooks.gridy = 9;
		contentPane.add(lblListAllBooks, gbc_lblListAllBooks);
		
		JButton btnListAll = new JButton("List all");
		GridBagConstraints gbc_btnListAll = new GridBagConstraints();
		gbc_btnListAll.insets = new Insets(0, 0, 5, 0);
		gbc_btnListAll.anchor = GridBagConstraints.WEST;
		gbc_btnListAll.gridx = 1;
		gbc_btnListAll.gridy = 9;
		contentPane.add(btnListAll, gbc_btnListAll);
		
		JButton btnBack = new JButton("Back");
		GridBagConstraints gbc_btnBack = new GridBagConstraints();
		gbc_btnBack.insets = new Insets(0, 0, 5, 0);
		gbc_btnBack.anchor = GridBagConstraints.WEST;
		gbc_btnBack.gridx = 1;
		gbc_btnBack.gridy = 11;
		contentPane.add(btnBack, gbc_btnBack);
	}

}
