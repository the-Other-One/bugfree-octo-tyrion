package de.wwu.pi.mdsd.umlToApp.data

import org.eclipse.uml2.uml.Class
import static extension de.wwu.pi.mdsd.umlToApp.util.ModelAndPackageHelper.*

class DataClassGenerator {
	def generateDataClass(Class clazz) '''
		package somePackageString.data;
		�IF(clazz.ownedAttributes.exists[a|a.multivalued] || clazz.ownedAttributes.exists[a|a.type.name.equals("Date")])� import java.util.*;
		�ENDIF�
		
		public class �clazz.name� {
			�FOR attribute : clazz.ownedAttributes �
			�IF (attribute.type instanceof Class) && attribute.multivalued�	
				�attribute.visibility� List<�attribute.type.name�> �attribute.name�s = new ArrayList<�attribute.type.name�>();	
			�ELSE�
				�attribute.visibility� �attribute.type.name� �attribute.name�;
			�ENDIF�		
			�ENDFOR�

		�FOR attribute : clazz.ownedAttributes�
			�IF (attribute.type instanceof Class) && attribute.multivalued�	
			public List<�attribute.type.name�> get�attribute.name.toFirstUpper�s(){
				return �attribute.name�s;
			}
			//called only by friend method
			protected void add�attribute.name.toFirstUpper�(�attribute.type.name� �attribute.name�){
				�attribute.name�s.add(�attribute.name�);
			}
				
			�ELSE� 
			public �attribute.type.name� get�attribute.name.toFirstUpper�(){
				return �attribute.name�;
			}
			
			public void set�attribute.name.toFirstUpper�(�attribute.type.name� �attribute.name�){
				�IF(attribute.type instanceof Class)�
					//do nothing, if �attribute.name� is the same
					if(this.�attribute.name� == �attribute.name�) return;
					//remove old �attribute.name� from opposite
					if(this.�attribute.name� != null) this.�attribute.name�.get�clazz.name.toFirstUpper�s().remove(this.�attribute.name�);
					//unless new �attribute.name� is null add 
					if(�attribute.name� != null) �attribute.name�.add�clazz.name.toFirstUpper�(this);
				�ENDIF�
				this.�attribute.name� = �attribute.name�;
				
			}
			�ENDIF�		
		�ENDFOR�
	

	}


	'''
}


	

