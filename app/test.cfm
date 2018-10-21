

<cfscript>
foo = {
    'a' = 1,
    'b' = 2,
    'c' = 3
};

bar = foo.filter( function ( key, value ){
    return (value == 2);
}, true, 2);

writedump(bar);

</cfscript>

<!---
<cfscript>
    cfcontent( type = "application/pdf", file = destination, DeleteFile = "Yes" );
    cfheader ( name="Content-Disposition", value="inline; filename=StarfinderCharacter.pdf");

    fileDelete(destination);
</cfscript>

--->