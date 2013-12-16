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
import static extension de.wwu.pi.mdsd05.helper.EntitytypeHelperMethods.*
import de.wwu.pi.mdsd05.group05DSL.Model

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
	
	def IScope scope_UIWindow_entitytype(EntryWindow ctx, EReference ref)
	{
		val model = (ctx.eContainer() as Model);	
		return Scopes.scopeFor(model.entitytypes.filter(ent|ent.abstract==null));
	}

	
}
