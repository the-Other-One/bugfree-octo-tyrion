package de.wwu.pi.mdsd05.library.ref.data;

import de.wwu.pi.mdsd05.framework.data.AbstractDataClass;

public class Book extends Medium {
	
	protected int ISBN;
	public int getISBN(){
		return this.ISBN;
	}
	
	public void setISBN(int ISBN){
		this.ISBN = ISBN;
	}
	
	protected String author;
	public String getAuthor(){
		return this.author;
	}

	public void setAuthor(String author){
		this.author = author;
	}

	public Book (int ISBN, String author, String name){
		super(name);
		this.ISBN = ISBN;
		this.author = author;
	}

	
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return null;
	}

}
