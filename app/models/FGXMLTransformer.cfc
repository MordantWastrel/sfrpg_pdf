component extends="cffractal.models.transformers.AbstractTransformer" singleton accessors=true hint="Transforms an FG XML input into a struct that maps to Schwar's Character Sheet PDF" {

    //variables.defaultIncludes = [ ''];
    //variables.availableIncludes = [ '' ];

    property name="fieldMap" type="array"; 
    property name="equippedArmor" type="struct";
    property name="equippedArmorKey" type="string";
    property name="isWearingArmor" type="boolean" default=false;

    function init() {
        this.setFieldMap(deserializeJson( fileRead( expandPath( '/app/models/fieldMap.json' ))));
    }

	function transform( input,  scopedIncludes, scopedExcludes, allIncludes, allExcludes ) {
    //     writedump(input); abort;
        massageData( input );

        var output = {};

        this.getFieldMap().each( function ( field ) {
            
            var value = extractValue( input, field[ "in" ] );
            if (len( value )) {
                output[ field["out"] ] = value;
            }
        });

        clearTemporaryData();
        return output;
    }

    private string function extractValue( required struct input, required string structPath ) {
        
        var structPath = "input." & structPath;
        var data = structGet( structPath );
        return data[ "value" ] ?: '';
    }
    
    private function massageData( required struct input ) hint="Handles any data massaging and calculations that aren't already done for us" {
        formatDescription ( input );
        findEquippedArmor( input );
        handleMaxDexBonusToAC( input );
    }

    private function formatDescription ( required struct input ) hint="Breaks apart fields that are a single XML field into several PDF fields"{
        
        var descFieldLen = 37;  // each description field on the PDF will hold about 37 characters
        var descFieldNum = 4;   // there are four description fields on the PDF
        
        var outField = {};

        var appearanceText = input[ "appearance" ][ "value" ];
        var textLen = len( appearanceText );
        
        var strPos = 1;
        var curField = 1;

        while ( strPos < textLen && curField <= descFieldNum ) {
            var fieldName = "appearance" & curField;
            
            input[ fieldName ][ "value" ] = mid( appearanceText, strPos, descFieldLen );
            strPos = strPos + descFieldLen;
            curField++;
        }

    }

    /**
     * findEquippedArmor ( input )
     * Equipped armor is the first item in the inventory with a type of "Armor" and an equipped value of 2. 
     * FG technically lets you have more than one, but we'll just use the first 
     */
    private function findEquippedArmor( required struct input ) {
        var inventory = input[ "inventorylist" ];

        var armorStruct = inventory.filter( function ( itemKey, itemObj ) {
            return ( (itemObj[ "type" ][ "value" ] == 'Armor') && (itemObj[ "carried" ][ "value" ] == 2)) ;  // 
        }, true, 2);

        if (armorStruct.len()) {
            var armorKey = armorStruct.keyArray()[1];
            this.setEquippedArmor( armorStruct[ armorKey ] );
            this.setEquippedArmorKey( "inventorylist." & armorKey );
            this.setIsWearingArmor( true );
        }
    }

    /**
     * handleMaxDexBonustoAC
     * The XML export doesn't do any calculation of whether their AC bonus should be constricted by their armor, but we have all the data we need,
     * so do the calculation here and store it as calculatedDexBonus 
    */

    private function handleMaxDexBonusToAC( required struct input ) {
        var charDexBonus = extractValue( input, 'abilities.dexterity.bonus');
        var armorMaxBonus = (this.getIsWearingArmor() ? this.getEquippedArmor()["maxdexbonus"]["value"] : charDexBonus);
        input["ac"]["sources"]["calculatedDexBonus"] = 
        {
            "value"= (armorMaxBonus < charDexBonus ? armorMaxBonus : charDexBonus) 
        };        
    }

    private function clearTemporaryData() {
        variables.equippedArmor = {};
        variables.equippedArmorKey = '';
        variables.isWearingArmor = false;
    }
}