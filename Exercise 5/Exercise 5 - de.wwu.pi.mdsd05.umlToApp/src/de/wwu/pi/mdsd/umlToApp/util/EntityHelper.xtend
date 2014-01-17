package de.wwu.pi.mdsd.umlToApp.util

import de.wwu.pi.mdsd.crudDsl.crudDsl.Entity
import de.wwu.pi.mdsd.crudDsl.crudDsl.CrudModel
import de.wwu.pi.mdsd.crudDsl.crudDsl.Property
import de.wwu.pi.mdsd.crudDsl.crudDsl.Attribute
import de.wwu.pi.mdsd.crudDsl.crudDsl.Reference
import de.wwu.pi.mdsd.crudDsl.crudDsl.MultiplicityKind
import de.wwu.pi.mdsd.crudDsl.crudDsl.AttributeType

class EntityHelper { 

	def static listWindowClassName(Entity entity) {
		entity.name + 'ListWindow'
	}
	
	/*def static listingInterfaceClassName(Type type) {
		type.name + 'ListingInterface'
	}
	def static listingInterfaceMethodeName(Type type) {
		'initialize'+ type.name +'Listings'
	}*/
	
	def static entryWindowClassName(Entity entity) {
		entity.name + 'EntryWindow'
	}
	
	def static serviceClassName(Entity entity) {
		entity.name + 'Service'
	}
	
	def static listingInterfaceClassName(Entity entity) {
		entity.name + 'ListingInterface'
	}
	
	def static listingInterfaceMethodeName(Entity enity) {
		'initialize'+ enity.name +'Listings'
	}
	
	def static initializeSingleRefMethodName(Property ref) {
		'initialize' + ref.name.toFirstUpper
	}

	def static isDate(Attribute a) {
		"Date".equals(a.type.name)
	}

	def static isString(Attribute a) {
		"String".equals(a.type.name)
	}
	
	def static isNumberObject(Attribute a) {
		"Integer".equals(a.type.name)
	}
	
	def static isNumberPrimitiv(Attribute a) {
		"int".equals(a.type.name)
	}
	
	def static isObject(Attribute a) {
		a.string || a.numberObject || a.date
	}
	
	def static isMultivalued(Reference r){
		r.multiplicity==MultiplicityKind.MULTIPLE
	}
	
	def static isSingelvalued(Reference r){
		r.multiplicity==MultiplicityKind.SINGLE
	}
	
	//Note that more specific types are handled first, thus 'Class' is handled before 'Element'.
	// org.eclipse.uml2.uml.Class is subclass of org.eclipse.uml2.uml.Element
	/*def static dispatch isEntity(Element element) {
		false
	}
	def static dispatch isEntity(Class clazz) {
		true
	}*/

	//-------------------------------------------------------------------------------------
	// Inheritance
	//-------------------------------------------------------------------------------------
	
	def static hasExplicitSuperClass(Entity entity) {
		entity.superType!=null
	}

	def static superClass(Entity entity) {
		if (entity.hasExplicitSuperClass)
			entity.superType
	}
	
	def static Iterable<Entity> allSuperClasses(Entity entity) {
		if(entity.hasExplicitSuperClass)
			allSuperClasses(entity.superClass) + #[entity.superClass]
		else
			emptyList
	}
	
	def static getDirectSubClasses(Entity entity) {
		(entity.eContainer as CrudModel).entities.filter[it.superType == entity]
	}

	def static hasSubClasses(Entity entity) {
		entity.getDirectSubClasses.size > 0
	}

	def static hasSubClasses(Reference ref) {
		ref.type.hasSubClasses
	}

	def static Iterable<Entity> getInstantiableClasses(Entity entity) {
		(	newLinkedList(entity) +
			//for all sub classes get instantiable classes 
			entity.getDirectSubClasses.map(cl|cl.instantiableClasses).flatten
		).filter[cl|!cl.abstract].toSet
	}
	
	//-------------------------------------------------------------------------------------
	// Properties and references
	//-------------------------------------------------------------------------------------
	
	def static dispatch Iterable<Property> properties(Void x, boolean considerSuperclass) {
		emptyList
	}
	
	def static dispatch Iterable<Property> properties(Entity entity, boolean considerSuperclass) {
		if (considerSuperclass && entity.hasExplicitSuperClass)
			entity.superClass.properties(true) + entity.properties
		else
			entity.properties
	}
	
	def static primitiveAttributes(Entity entity, boolean considerSuperclass) {
		/* For now, only consider single-valued attributes */
		entity.properties(considerSuperclass).filter(Attribute)
	}

	def static entityReferences(Entity entity, boolean considerSuperclass) {
		entity.properties(considerSuperclass).filter(Reference)
	}

	def static singleReferences(Entity entity, boolean considerSuperclass) {
		entity.entityReferences(considerSuperclass).filter[it.multiplicity==MultiplicityKind.SINGLE]
	}

	def static multiReferences(Entity entity, boolean considerSuperclass) {
		entity.entityReferences(considerSuperclass).filter[it.multiplicity==MultiplicityKind.MULTIPLE]
	}

	/** primitive attributes and single References */
	def static singleValueProperties(Entity entity, boolean considerSuperclass) {
		(entity.primitiveAttributes(considerSuperclass) + entity.singleReferences(considerSuperclass))
	}

	def static Iterable<Attribute> required(Iterable<Attribute> attributes) {
		attributes.filter[it.required]
	}

	def static isRequired(Attribute a) {
		a.optional
	}

	def static requiredAttributes(Entity entity, boolean considerSuperclass) {
		(
			if (considerSuperclass)
				 entity.superClass.singleValueProperties(considerSuperclass).filter(Attribute).required
			else
				emptyList
		)
		+ entity.singleValueProperties(false).filter(Attribute).required
	}

	def static optionalAttributes(Entity entity, boolean considerSuperclass) {
		entity.singleValueProperties(considerSuperclass).filter(Attribute).filter[!it.required]
	}

	
	def static typeAndNameInJava(Property p) {
		'''�p.typeInJava� �p.nameInJava�'''
	}

	/** get the type representation of properties in Java 
	 * incl. multivalue type e.g. multivalued properties as List<p.javaType>
	 */
	def static typeInJava(Property p) {
		if (p instanceof Reference){
			if ((p as Reference).isMultivalued)
			'List<' + (p as Reference).type.javaType + '>'
			else
			(p as Reference).type.javaType
			}
		else
			(p as Attribute).type.javaType
	}

	def static javaType(AttributeType type) {
		type.name
	}
	def static javaType(Entity entity) {
		entity.name
	}

	def static nameInJava(Property p) {
		p.name
	}
	
	/**
	 * get java object type for primitive java types
	 */
	def static objectType(String javaType) {
		switch (javaType) {
			case "boolean": "Boolean"
			case "int": "Integer"
			case "double": "Double"
			default: javaType
		}
	}
}