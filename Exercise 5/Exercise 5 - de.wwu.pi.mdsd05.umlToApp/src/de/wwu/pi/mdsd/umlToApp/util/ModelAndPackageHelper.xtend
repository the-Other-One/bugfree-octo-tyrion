package de.wwu.pi.mdsd.umlToApp.util

import org.eclipse.uml2.uml.Class
import org.eclipse.uml2.uml.Model
import org.eclipse.uml2.uml.Property
import org.eclipse.uml2.uml.VisibilityKind

import de.wwu.pi.mdsd.crudDsl.crudDsl.CrudModel
import de.wwu.pi.mdsd.crudDsl.crudDsl.Window
import de.wwu.pi.mdsd.crudDsl.crudDsl.Entity

class ModelAndPackageHelper {
	def static Iterable<Class> allEntities(Model model) {
		model.allOwnedElements.filter(typeof(Class));
	}

	def static toFolderString(String packageName) {
		packageName.replace('.', '/')
	}

	def static packageString(Class clazz) {
		//(clazz.eContainer.eContainer as Resource).crudModel.packageString
		clazz.package.name
	}

	def static packageString(CrudModel model) {
		model.name
	}

	def static entityPackageString(Entity entity) {
		(entity.eContainer as CrudModel).packageString + ".data"
	}

	def static logicPackageString(Window window) {
		(window.eContainer as CrudModel).logicPackageString
	}

	def static logicPackageString(CrudModel model) {
		model.packageString + ".logic"
	}
	
	def static guiPackageString(Window window) {
		(window.eContainer as CrudModel).guiPackageString
	}
	def static guiPackageString(CrudModel model) {
		model.packageString + ".gui"
	}

	def static entityPackageString(Class clazz) {
		clazz.packageString + ".data"
	}

	def static logicPackageString(Class clazz) {
		clazz.packageString + ".logic"
	}

	def static visibilityInJava(VisibilityKind kind) {
		switch (kind) {
			case VisibilityKind.PACKAGE_LITERAL: 'package'
			case VisibilityKind.PROTECTED_LITERAL: 'protected'
			case VisibilityKind.PUBLIC_LITERAL: 'public'
			case VisibilityKind.PRIVATE_LITERAL: 'private'
		}
	}

	def static visibilityInJava(Property p) {
		p.visibility.visibilityInJava
	}
}
