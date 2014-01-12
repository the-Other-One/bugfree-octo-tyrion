/*
 * generated by Xtext
 */
package de.wwu.pi.mdsd.crudDsl.scoping

import de.wwu.pi.mdsd.crudDsl.crudDsl.Entity
import de.wwu.pi.mdsd.crudDsl.crudDsl.EntryWindow
import de.wwu.pi.mdsd.crudDsl.crudDsl.Reference
import org.eclipse.emf.ecore.EReference
import org.eclipse.xtext.scoping.IScope
import org.eclipse.xtext.scoping.Scopes
import org.eclipse.xtext.scoping.impl.AbstractDeclarativeScopeProvider

import static extension de.wwu.pi.mdsd.crudDsl.util.ModelUtil.*

/**
 * This class contains custom scoping description.
 * 
 * see : http://www.eclipse.org/Xtext/documentation.html#scoping
 * on how and when to use it 
 *
 */
class CrudDslScopeProvider extends AbstractDeclarativeScopeProvider {
	
	def IScope scope_Entity_superType(Entity entity, EReference ref) {
		var Iterable<Entity> result = entity.getModelElement.entities
		//remove the current entity
		result = result.filter[entity != it]
		Scopes::scopeFor(result)
	}

	def IScope scope_Reference_opposite(Reference callingRef, EReference ref) {
		var result = callingRef.type.properties
			//filter for references within the referenced type
			.filter(typeof(Reference))
			//filter for references that match the entity of the calling reference
			.filter[type == callingRef.eContainer]
		Scopes::scopeFor(result)
	}
	
	
	
	//----- Scope provider for GUI rules -----//
		
	def IScope scope_Window_entity(EntryWindow ctx, EReference ref) {
		var Iterable<Entity> result = ctx.getModelElement.entities
		//remove the current entity
		result = result.filter[!it.abstract]
		Scopes::scopeFor(result)
	}
	
	def IScope scope_Field_property(EntryWindow ctx, EReference ref) {
		val entity = ctx.entity
		val allEntities = (#{entity} + entity.getAllSupertypes).toSet
		//get List of property lists --> flatten to pack properties to one big list
		val result = allEntities.map[it.properties].flatten
		Scopes::scopeFor(result)
	}
}