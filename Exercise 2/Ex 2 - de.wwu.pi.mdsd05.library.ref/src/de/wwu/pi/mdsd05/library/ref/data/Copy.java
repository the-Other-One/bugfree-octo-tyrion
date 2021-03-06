package de.wwu.pi.mdsd05.library.ref.data;


import de.wwu.pi.mdsd05.framework.data.AbstractDataClass;

public class Copy extends AbstractDataClass{
	/**
	 * 
	 */
	private static final long serialVersionUID = -666969941790817425L;
	protected int inventoryNumber;
	public int getInventoryNumber() {
		return inventoryNumber;
	}
	public void setInventoryNumber(int inventoryNumber) {
		this.inventoryNumber = inventoryNumber;
	}
	
	protected Medium medium;
	public Medium getMedium() {
		return medium;
	}
	public void setMedium(Medium medium) {
		this.medium = medium;
	}
	
	
	//Constructor
	public Copy(int inventoryNumber, Medium medium) {
		setInventoryNumber(inventoryNumber);
		setMedium(medium);
	}
	
	public Copy() {
		super();
	}
	
	@Override
	public String toString() {
		return (getInventoryNumber()) + ", " + (getMedium())+ "";
	}
}
