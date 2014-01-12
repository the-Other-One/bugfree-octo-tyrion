/*
 * generated by Xtext
 */
package de.wwu.pi.mdsd.crudDsl.validation

import de.wwu.pi.mdsd.crudDsl.crudDsl.Button
import de.wwu.pi.mdsd.crudDsl.crudDsl.ButtonKind
import de.wwu.pi.mdsd.crudDsl.crudDsl.CrudDslPackage
import de.wwu.pi.mdsd.crudDsl.crudDsl.CrudModel
import de.wwu.pi.mdsd.crudDsl.crudDsl.Entity
import de.wwu.pi.mdsd.crudDsl.crudDsl.EntryWindow
import de.wwu.pi.mdsd.crudDsl.crudDsl.ListWindow
import de.wwu.pi.mdsd.crudDsl.crudDsl.Reference
import de.wwu.pi.mdsd.crudDsl.crudDsl.Window
import de.wwu.pi.mdsd.crudDsl.crudDsl.impl.CrudDslFactoryImpl
import org.eclipse.xtext.validation.Check

import static de.wwu.pi.mdsd.crudDsl.crudDsl.CrudDslPackage.Literals.*

import static extension de.wwu.pi.mdsd.crudDsl.util.ModelUtil.*

//import org.eclipse.xtext.validation.Check
/**
 * Custom validation rules. 
 *
 * see http://www.eclipse.org/Xtext/documentation.html#validation
 */
class CrudDslValidator extends AbstractCrudDslValidator {

	public static val CYCLIC_ENTITY_HIERARCHY_ERROR = 'CyclicEntityHierarchy'
	public static val CYCLIC_ENTITY_HIERARCHY_MESSAGE = 'Cycle in hierarchy of the entity %s: %s'

	@Check
	def checkNoCycleInEntityHierarchy(Entity entity) {
		var supertypes = entity.allSupertypes
		if (supertypes.exists[it == entity]) {
			error(
				//Meaningful error message
				String::format(CYCLIC_ENTITY_HIERARCHY_MESSAGE, entity.name, supertypes.join(' extends ', [it.name])),
				//Feature to annotate within the examined entity
				CrudDslPackage::eINSTANCE.entity_SuperType,
				//optional issue code
				CYCLIC_ENTITY_HIERARCHY_ERROR
			)
		}
	}
	
	public static val OVERWRITING_INHERITED_PROPERTY_ERROR = 'OverwritingInheritedPropertyError'
	public static val OVERWRITING_INHERITED_PROPERTY_MESSAGE = 'Overwriting inherited field \'%1$s\' of super element.'

	@Check
	def checkOverwritingInheritedProperty(Entity enity) {
		if (enity.superType == null)
			return
		val superProperties = enity.superType.getProperties(true)
		val ownProperties = enity.properties
		ownProperties.filter[own|superProperties.exists[superProp|superProp.name == own.name]].forEach [ property |
			error(
				String::format(OVERWRITING_INHERITED_PROPERTY_MESSAGE, property.name),
				property, //do not annotate the whole entity but a specific feature
				PROPERTY__NAME,
				OVERWRITING_INHERITED_PROPERTY_ERROR
			)
		]
	}

	public static val ONLY_SUPERTYPES_ARE_ABSTRACT_ERROR = 'OnlySuperTypesCanBeAbstract'
	public static val ONLY_SUPERTYPES_ARE_ABSTRACT_MESSAGE = '%s can not be abstract, it has no successors'

	@Check
	def checkOnlySupertypesAreAbstract(Entity entity) {
		if (!entity.abstract)
			return;
		val all_referenced_supertypes = entity.modelElement.entities.map[it.allSupertypes].flatten
		if (!all_referenced_supertypes.exists[it == entity]) {
			error(
				String::format(ONLY_SUPERTYPES_ARE_ABSTRACT_MESSAGE, entity.name),
				CrudDslPackage::eINSTANCE.entity_Abstract,
				ONLY_SUPERTYPES_ARE_ABSTRACT_ERROR
			)
		}
	}

	public static val REFERENCE_OPPOSITES_MATCH_ERROR = 'checkReferenceOppositesMatch'
	public static val REFERENCE_OPPOSITES_MATCH_MESSAGE = 'The opposite reference does not have this reference as its opposite. Opposite references must reference each other. It references %1$s instead of %2$s'

	@Check
	def checkReferenceOppositesMatch(Reference reference) {
		if (reference.opposite.opposite != reference)
			error(
				String::format(REFERENCE_OPPOSITES_MATCH_MESSAGE, reference.opposite.opposite.name, reference.name),
				REFERENCE__OPPOSITE,
				REFERENCE_OPPOSITES_MATCH_ERROR
			)
	}
	
	@Check
	def checkReferenceMultiplicity(Reference reference) {
		if (reference.getMultiplicity() == reference.getOpposite().getMultiplicity())
				error("Only one-to-many relationships are supported. Change one multiplicity.",
					CrudDslPackage.Literals.REFERENCE__MULTIPLICITY);
	}
	
	@Check
	def checkModelNoDuplicateWindowsForSameEntity(CrudModel model) {
		val duplicates = model.windows.filter(typeof(ListWindow)).getDuplicatesForSameEntity +
			model.windows.filter(typeof(EntryWindow)).getDuplicatesForSameEntity
		duplicates.forEach [ dupl |
			error(
				"There is more than one window of this kind for the specified entity. " +
					"For each entity, there can be at most one EntryWindow and one ListWindow.", dupl, WINDOW__ENTITY)
		]
	}

	def protected getDuplicatesForSameEntity(Iterable<? extends Window> windows) {
		windows.filter[win|windows.filter[it.entity == win.entity].size > 1]
	}

	@Check
	def checkEntryWindowAllPropertiesDisplayed(EntryWindow window) {
		val propertiesDisplayed = window.getPropertiesDisplayed
		val allProperties = window.entity.getProperties(true)
		allProperties.filter[!propertiesDisplayed.contains(it)].forEach [ propNotDisplayed |
			if (propNotDisplayed.optional)
				warning("No field displays optional property " + propNotDisplayed.name, WINDOW__ENTITY)
			else
				error("No field displays required property " + propNotDisplayed.name, WINDOW__ENTITY)
		]
	}

	def protected getPropertiesDisplayed(EntryWindow window) {
		val propertiesDisplayed = newHashSet
		window.allFields.forEach [ curField |
			var prop = curField.property
			if (!propertiesDisplayed.add(prop))
				warning("Duplicate field for property " + prop.name, curField, FIELD__PROPERTY);
		]
		propertiesDisplayed
	}
	
	//Simple check for has createButton
	@Check
	def checkEntryWindowHasCreateButton(EntryWindow window) {
		if (!window.elements.filter(typeof(Button)).exists[kind == ButtonKind::CREATE_EDIT])
			error("No Create / Edit button is defined for this window.", WINDOW__NAME);
	}
	
	
	@Check
	def checkUIElementsOverlap(EntryWindow window) {
		val uiElements = window.elements
		uiElements.forEach[current | 
			(uiElements.filter[it != current && current.uiOverlaps(it)]).forEach[
				overlap | warning("element overlaps " + overlap.name, current, UI_ELEMENT__BOUNDS)
			]	
		]
	}

	@Check 
	def uiElementOutofWindow(EntryWindow window) {
		val uiElements = window.elements
		val windowBounds = new CrudDslFactoryImpl().createBounds
		windowBounds.setHeight(window.size.height)
		windowBounds.setWidth(window.size.width)
		
		                            //any point of an ui element outside window bounds
		uiElements.filter[curUIElem|curUIElem.bounds.vertexes.exists[point|!windowBounds.pointWithinBounds(point)]].
			forEach [ notInside |
				warning("element protrudes window bounds", notInside, UI_ELEMENT__BOUNDS)
			]
	}
}
