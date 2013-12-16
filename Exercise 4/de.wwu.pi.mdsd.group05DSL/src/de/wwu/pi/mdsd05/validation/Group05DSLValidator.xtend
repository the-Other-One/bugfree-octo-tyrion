/*
 * generated by Xtext
 */
package de.wwu.pi.mdsd05.validation

import de.wwu.pi.mdsd05.group05DSL.Attribute
import de.wwu.pi.mdsd05.group05DSL.Button
import de.wwu.pi.mdsd05.group05DSL.Entitytype
import de.wwu.pi.mdsd05.group05DSL.EntryWindow
import de.wwu.pi.mdsd05.group05DSL.Field
import de.wwu.pi.mdsd05.group05DSL.Group05DSLPackage
import de.wwu.pi.mdsd05.group05DSL.Inscription
import de.wwu.pi.mdsd05.group05DSL.ListWindow
import de.wwu.pi.mdsd05.group05DSL.Model
import de.wwu.pi.mdsd05.group05DSL.Property
import de.wwu.pi.mdsd05.group05DSL.UIElement
import java.util.ArrayList
import org.eclipse.xtext.validation.Check

import static extension de.wwu.pi.mdsd05.helper.EntitytypeHelperMethods.*
import static extension de.wwu.pi.mdsd05.helper.UIElementHelperMethods.*
import de.wwu.pi.mdsd05.group05DSL.Label
import de.wwu.pi.mdsd05.group05DSL.UIWindow

//import org.eclipse.xtext.validation.Check
/**
 * Custom validation rules. 
 *
 * see http://www.eclipse.org/Xtext/documentation.html#validation
 */
class Group05DSLValidator extends AbstractGroup05DSLValidator {

	@Check
	def public void checkAbtractFeatures(Entitytype entitytype) {
		if (entitytype.abstract != null && !entitytype.isSuperClassAnywhere) {
			error("Class " + entitytype.name + " has no subclass and may therefore not be abstract.",
				Group05DSLPackage.Literals.ENTITYTYPE__ABSTRACT);
		}

	}

	@Check
	def checkMinEntityAndWindow(Model model) {
		if (model.entitytypes.size == 0 || model.uiwindows.size == 0)
			warning("At least one Entitytype and one UIWindow should be modeled.",
				Group05DSLPackage.Literals.MODEL__PACKAGE)
	}

	@Check
	def checkWindowLimit(Entitytype entitytype) {
		val model = entitytype.eContainer as Model;

		var entryWindows = model.uiwindows.filter[it instanceof EntryWindow && it.entitytype == entitytype];
		var listWindows = model.uiwindows.filter[it instanceof ListWindow && it.entitytype == entitytype];
		if (entryWindows.size > 1) {
			error('Entitytype ' + entitytype.name + ' has more than one entry window.', entitytype,
				Group05DSLPackage.Literals.ENTITYTYPE__NAME)
		}
		if (listWindows.size > 1) {
			error('Entitytype ' + entitytype.name + ' has more than one list window.', entitytype,
				Group05DSLPackage.Literals.ENTITYTYPE__NAME)
		}

	}

	@Check
	def checkUIElementOverlapping(UIElement uiElement) {
		val window = uiElement.eContainer as EntryWindow

		for (UIElement element : window.getElements().filter[elem|!elem.equals(uiElement)]) {
			if (element.overlapping(uiElement)) {
				warning("A UI Element is overlapping with another UI Element.", Group05DSLPackage.Literals.UI_ELEMENT__UI_OPTIONS);
			}
		}
	}

	@Check
	def checkReferences(Entitytype entity) {
		if (entity.hasWrongOppositeReferences)
			error(entity.name + " is not correctly referenced. Check opposite reference.", entity,
				Group05DSLPackage.Literals.ENTITYTYPE__NAME)
	}

	

	@Check
	def checkCyclicInheritance(Entitytype entity) {
		if (entity.hasCyclicInheritance)
			error("Cyclic inheritance is not allowed", entity, Group05DSLPackage.Literals.ENTITYTYPE__NAME);
	}

	@Check
	def areAllPropertiesIncludedInTheEntrywindow(EntryWindow entryWindow) {
		val allProperties = entryWindow.entitytype.allPropertiesIncludingSuperproperties.filter[prop|
			!(prop instanceof Attribute) || (prop as Attribute).optional == null];
		val fields = new ArrayList<Field>;
		fields += entryWindow.elements.filter[elem|elem instanceof Field].map[elem|elem as Field];
		for (Property property : allProperties) {
			if (!fields.map[field|field.property].contains(property)) {
				error(
					"The property " + property.name + " has no corresponding field in the entryWindow " +
						entryWindow.name + ".", Group05DSLPackage.Literals.UI_WINDOW__NAME);
			}
		}
	}

	@Check
	def areAllOptionalPropertiesIncludedInTheEntrywindow(EntryWindow entryWindow) {
		val allProperties = entryWindow.entitytype.allPropertiesIncludingSuperproperties.filter[prop|
			(prop instanceof Attribute) && (prop as Attribute).optional != null];
		val fields = new ArrayList<Field>;
		fields += entryWindow.elements.filter[elem|elem instanceof Field].map[elem|elem as Field];
		for (Property property : allProperties) {
			if (!fields.map[field|field.property].contains(property)) {
				warning(
					"The optional property " + property.name + " has no corresponding field in the entryWindow " +
						entryWindow.name + ".", Group05DSLPackage.Literals.UI_WINDOW__NAME);
			}
		}
	}

	@Check
	def isAPropertyImplementedMultipleTimesAsAField(Field field) {
		val entryWindow = field.eContainer as EntryWindow;
		for (Field windowField : entryWindow.elements.filter[elem|elem instanceof Field && !elem.equals(field)].map[elem|
			elem as Field]) {
			if (windowField.property.equals(field.property))
				warning("The property " + field.property.name + " is referenced in multiple Fields.",
					Group05DSLPackage.Literals.FIELD__PROPERTY);

		}

	}

	@Check
	def missingCeateEditButton(EntryWindow window) {
		var Boolean exists = false;

		for (UIElement elem : window.elements.filter[e|e instanceof Button]) {
			var Button btn = elem as Button
			if (btn.inscription.equals(Inscription.CREATE_EDIT)) {
				exists = true;
			}
		}

		if (!exists) {
			error("EntryWindow requires Create/Edit Button", Group05DSLPackage.Literals.UI_WINDOW__NAME);
		}

	}

	@Check
	def EntitytypesHaveTheSameName(Entitytype entitytype) {

		var entitytypes = (entitytype.eContainer() as Model).getEntitytypes();
		for (Entitytype e : entitytypes) {
			if (e.getName() != null && e != entitytype && e.getName().equals(entitytype.getName)) {
				error("Entitytype with the same name already exists", Group05DSLPackage.Literals.ENTITYTYPE__NAME);
			}
		}
	}

	@Check
	def PropertiesHaveTheSameName(Property property) {

		var properties = (property.eContainer() as Entitytype).allPropertiesIncludingSuperproperties;
		for (Property p : properties) {
			if (p.getName() != null && p != property && p.getName().equals(property.getName)) {
				error("A property with the same name already exists in this class or in a superclass.",
					Group05DSLPackage.Literals.PROPERTY__NAME);
			}
		}
	}

	@Check
	def LabelsHaveTheSameName(Label label) {

		var labels = (label.eContainer() as EntryWindow).getElements().filter[l|l instanceof Label].map[l|l as Label];
		for (Label l : labels) {
			if (l.getName() != null && l != label && l.getName().equals(label.getName)) {
				error("A label with the same name already exists", Group05DSLPackage.Literals.LABEL__NAME);
			}
		}
	}

	@Check
	def WindowsHaveTheSameName(UIWindow window) {

		var windows = (window.eContainer() as Model).getUiwindows();
		for (UIWindow w : windows) {
			if (w.getName() != null && w != window && w.getName().equals(window.getName)) {
				error("A window with the same name already exists", Group05DSLPackage.Literals.UI_WINDOW__NAME);
			}
		}
	}

}
