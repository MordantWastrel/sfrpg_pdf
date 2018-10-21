<cfset destination="#expandPath(gettempDirectory()) & createUUID()#.pdf">

<cfpdfform action="populate" source="#args.pdfSource#" destination="#destination#">
    <cfloop array="#structKeyArray( args.pdfProps )#" index="pdfProp">
        <cfpdfformparam name="#pdfProp#" value="#structFind(args.pdfProps, pdfProp)#">
    </cfloop>
</cfpdfform>

<cfscript>
    cfcontent( type = "application/pdf", file = destination, DeleteFile = "Yes" );
    cfheader ( name="Content-Disposition", value="inline; filename=StarfinderCharacter.pdf");
</cfscript>