/*
* generated by Xtext
*/
package de.wwu.pi.mdsd05;

/**
 * Initialization support for running Xtext languages 
 * without equinox extension registry
 */
public class Group05DSLStandaloneSetup extends Group05DSLStandaloneSetupGenerated{

	public static void doSetup() {
		new Group05DSLStandaloneSetup().createInjectorAndDoEMFRegistration();
	}
}

