component extends="coldbox.system.EventHandler"{

	property name="messagebox" inject="messagebox@cbmessagebox";

	function index( event, rc, prc ){
		var rendered = false;
		if (event.valueExists('xmlInput') || event.valueExists('xmlFile')) {
			if (len(rc.xmlInput))
				if (isXML(rc.xmlInput)) {
					try {
						var xmldoc = xmlToStruct( xmlparse( rc.xmlInput ) )["root"][1]["character"];;
					}
					catch (any e) {
						messagebox.error("Input seemed like XML but XML parser failed.");
					}
					if (!isNull(xmldoc)){
						pdfProps = xmlToPdfStruct( xmlDoc );
						rendered = true;
						event.setView(view="main/pdfgen", args = { 'pdfProps' = pdfProps, 'pdfSource' = expandPath('/app/StarfinderCharacterSheet.pdf') }, noLayout = true ); 
					}
				}
				else {
					messagebox.error("Raw input was not valid XML.")
				}
			}
		if (!rendered) event.setView("main/index");
	}

	/**** HELPER FUNCTIONS / SERVICE LAYER *****/

	private struct function xmlToPdfStruct( required struct xmldoc ) {
		var fractal = wirebox.getInstance("Manager@cffractal");
		var pdfProps = fractal.builder()
			.item( xmldoc )
			.withTransformer( "FGXMLTransformer" )
			.convert();
		
		return pdfProps;
	}

	private function xmlToStruct( required xml x ) hint="Takes a CF XML Object and parses it into a struct" {
		var s = {};	
		if(xmlGetNodeType(x) == "DOCUMENT_NODE") {
			s[structKeyList(x)] = xmlToStruct(x[structKeyList(x)]);    
		}
	
		if(structKeyExists(x, "xmlAttributes") && !structIsEmpty(x.xmlAttributes)) { 
			s.attributes = {};
			for(var item in x.xmlAttributes) {
				s.attributes[item] = x.xmlAttributes[item];        
			}
		}
		
		if(structKeyExists(x, "xmlText") && len(trim(x.xmlText))) {
			s.value = x.xmlText;
		}
	
		if(structKeyExists(x, "xmlChildren") && arrayLen(x.xmlChildren)) {
			for(var i=1; i<=arrayLen(x.xmlChildren); i++) {
				if(structKeyExists(s, x.xmlchildren[i].xmlname)) { 
					if(!isArray(s[x.xmlChildren[i].xmlname])) {
						var temp = s[x.xmlchildren[i].xmlname];
						s[x.xmlchildren[i].xmlname] = [temp];
					}
					arrayAppend(s[x.xmlchildren[i].xmlname], xmlToStruct(x.xmlChildren[i]));                
				} 
				else {
					//before we parse it, see if simple
					if(structKeyExists(x.xmlChildren[i], "xmlChildren") && arrayLen(x.xmlChildren[i].xmlChildren)) {
							s[x.xmlChildren[i].xmlName] = xmlToStruct(x.xmlChildren[i]);
					}
					else if (structKeyExists(x.xmlChildren[i],"xmlAttributes") && !structIsEmpty(x.xmlChildren[i].xmlAttributes)) {
						s[x.xmlChildren[i].xmlName] = xmlToStruct(x.xmlChildren[i]);
					} 
					else {
						s[x.xmlChildren[i].xmlName] = x.xmlChildren[i].xmlText;
					}
				}
			}
		}
		
		return s;
	}

	/************************************** IMPLICIT ACTIONS *********************************************/

	function onAppInit( event, rc, prc ){

	}

	function onRequestStart( event, rc, prc ){

	}

	function onRequestEnd( event, rc, prc ){

	}

	function onSessionStart( event, rc, prc ){

	}

	function onSessionEnd( event, rc, prc ){
	//	var sessionScope = event.getValue("sessionReference");
	//	var applicationScope = event.getValue("applicationReference");
	}

	function onException( event, rc, prc ){
		//Grab Exception From private request collection, placed by ColdBox Exception Handling
		var exception = prc.exception;
		//Place exception handler below:

	}

	function onMissingTemplate( event, rc, prc ){
		//Grab missingTemplate From request collection, placed by ColdBox
		var missingTemplate = event.getValue("missingTemplate");

	}

}