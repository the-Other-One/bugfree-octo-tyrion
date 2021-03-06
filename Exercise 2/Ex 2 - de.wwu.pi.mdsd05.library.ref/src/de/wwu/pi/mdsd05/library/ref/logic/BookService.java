
package de.wwu.pi.mdsd05.library.ref.logic;

import java.util.Collection;

import de.wwu.pi.mdsd05.framework.logic.AbstractServiceProvider;
import de.wwu.pi.mdsd05.framework.logic.ValidationException;
import de.wwu.pi.mdsd05.library.ref.data.Book;

public class BookService extends AbstractServiceProvider<Book> {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6640997992843405228L;

	//Constructor
	protected BookService() {
		super();
	}

	public boolean validateBook(String name, int ISBN, String author) throws ValidationException {
		if(name == null)
			throw new ValidationException("Name", "cannot be empty");
		if(ISBN == 0)
			throw new ValidationException("ISBN", "cannot be empty");
		//if(ISBNAlreadyExists(ISBN))
		//	throw new ValidationException("ISBN", "already exists");
		if(author == null)
			throw new ValidationException("Author", "cannot be empty");
		return true;
	}
	
	public Book saveBook(int id, String name, int ISBN, String author) {
	Book elem = getByOId(id);
	if(elem == null)
		elem = new Book();
	elem.setName(name);
	elem.setISBN(ISBN);
	elem.setAuthor(author);
	persist(elem);
	return elem;
	}
	
	
	
	public Book getByISBN(int ISBN)
	{
		Collection<Book> books = getAll();

			for (Book elem: books)
			{
				if(elem.getISBN() == ISBN) return elem;
				
			}
			return null;
	
	}


}

