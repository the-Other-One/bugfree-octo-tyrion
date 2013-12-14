/*
 * generated by Xtext
 */
package de.wwu.pi.mdsd05.scoping

import de.wwu.pi.mdsd05.group05DSL.EntryWindow
import de.wwu.pi.mdsd05.group05DSL.Field
import org.eclipse.emf.ecore.EReference
import org.eclipse.xtext.scoping.IScope
import org.eclipse.xtext.scoping.Scopes
import org.eclipse.xtext.scoping.impl.AbstractDeclarativeScopeProvider
import static extension de.wwu.pi.mdsd05.helper.HelperMethods.*

/**
 * This class contains custom scoping description.
 * 
 * see : http://www.eclipse.org/Xtext/documentation.html#scoping
 * on how and when to use it 
 *
 */
class Group05DSLScopeProvider extends AbstractDeclarativeScopeProvider {

	def IScope scope_Field_property(Field ctx, EReference ref)
	{
		val fieldEntitytype = (ctx.eContainer() as EntryWindow).getEntitytype();
		return Scopes.scopeFor(fieldEntitytype.getAllPropertiesIncludingSuperproperties);
	}
	
	// TODO: Reference scope
		
//	def IScope scope_Entitytype_supertype(Entitytype ctx, EReference ref) {
//		val elements = (ctx.eContainer as Model).entitytypes;
//		val filtered = elements.filter[it != ctx && !it.extendsFrom(ctx)];
//		return Scopes.scopeFor(filtered);
//	}
//
//	def boolean extendsFrom(Entitytype entitytype, Entitytype supertype) {
//		if (supertype == entitytype) return false;
//		return entitytype.extendsFrom(supertype.supertype);
//	}
	
	
	
	
	
	
	
	
	
	
	/* def IScope scope_Field_property(Field ctx, EReference ref) {
		val elements = (ctx.eContainer() as EntryWindow).getEntitytype().getProperties();
		// TODO: supertype properties!
		return Scopes.scopeFor(elements);
	}*/
}
