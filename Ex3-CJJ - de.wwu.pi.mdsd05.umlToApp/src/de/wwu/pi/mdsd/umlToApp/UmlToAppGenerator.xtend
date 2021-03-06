package de.wwu.pi.mdsd.umlToApp

import de.wwu.pi.mdsd.umlToApp.data.DataClassGenerator
import java.io.File
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.uml2.uml.Model
import org.eclipse.xtext.generator.IFileSystemAccess
import org.eclipse.xtext.generator.IGenerator

import static extension de.wwu.pi.mdsd.umlToApp.util.ModelAndPackageHelper.*
import de.wwu.pi.mdsd.umlToApp.logic.ServiceInitializerGenerator
import de.wwu.pi.mdsd.umlToApp.gui.StartWindowClassGenerator
import de.wwu.pi.mdsd.umlToApp.gui.ListWindowGenerator
import de.wwu.pi.mdsd.umlToApp.gui.EntryWindowGenerator
import de.wwu.pi.mdsd.umlToApp.logic.EntityServiceGenerator

class UmlToAppGenerator implements IGenerator {
	static val INTERNAL_MODEL_EXTENSIONS = newArrayList(".library.uml", ".profile.uml", ".metamodel.uml")
	
	def static isModel(Resource input) {
		!INTERNAL_MODEL_EXTENSIONS.exists(ext | input.URI.path.endsWith(ext))
	}

	override doGenerate(Resource input, IFileSystemAccess fsa) {
		print("UmlToAppGenerator.doGenerate called with resource " + input.URI)
		if(isModel(input)) {
			println(" - Generating ...")
			input.contents.filter(typeof(Model)).forEach[doGenerate(fsa)]
		}
		else
			println(" - Skipped.")
	}
	
	def doGenerate(Model model, IFileSystemAccess fsa) {
		val PACKAGE_DIR = PACKAGE_STRING.replace('.', File.separatorChar);
		model.allEntities.forEach[ clazz |
			fsa.generateFile('''�PACKAGE_DIR��File.separatorChar�data�File.separatorChar��clazz.name�.java''', new DataClassGenerator().generateDataClass(clazz))
			fsa.generateFile('''�PACKAGE_DIR��File.separatorChar�gui�File.separatorChar��clazz.name�ListWindow.java''', new ListWindowGenerator().generateListWindow(clazz))
			fsa.generateFile('''�PACKAGE_DIR��File.separatorChar�logic�File.separatorChar��clazz.name�Service.java''', new EntityServiceGenerator().generateEntityServiceClass(clazz))
			if (!clazz.abstract)
				fsa.generateFile('''�PACKAGE_DIR��File.separatorChar�gui�File.separatorChar��clazz.name�EntryWindow.java''', new EntryWindowGenerator().generateEntryWindow(clazz))
			
		]
		fsa.generateFile('''�PACKAGE_DIR��File.separatorChar�logic�File.separatorChar�ServiceInitializer.java''', new ServiceInitializerGenerator().generateServiceInitializer(model.allEntities))
		fsa.generateFile('''�PACKAGE_DIR��File.separatorChar�gui�File.separatorChar�StartWindowClass.java''', new StartWindowClassGenerator().generateStartWindowClass(model.allEntities))
	}
}