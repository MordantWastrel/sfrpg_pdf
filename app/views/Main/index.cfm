<cfoutput>
	<h1>Fantasy Grounds Starfinder RPG XML to PDF Character Converter</h1>
    <p>This tool will accept input from a Fantasy Grounds XML character export and transform as many fields as possible to populate Schwar's interactive PDF character sheet.</p>
	<p>XML may be pasted into the input field or uploaded. Maximum upload size is 250kb (whether via raw input or file upload). </p>

	<!--- display any result conditions --->
	#getInstance( "messagebox@cbmessagebox" ).renderIt()#

	<form name="convertForm" enctype="multipart/form-data" method="post" action="#event.buildLink(to='Main.index')#">
		<div class="form-group">
			<label for="xmlFile">FG Character XML File:</label>
			<input type="file" name="xmlFile" class="form-control-file">
		</div>
		<div class="form-group">
			<label for="xmlInput">...or Raw XML Input:</label>
			<textarea name="xmlInput" class="form-control" maxlength=256000 rows=8>#event.getValue('xmlInput','')#</textarea>
		</div>
		<button type="submit" class="btn btn-primary">Generate PDF</button>
	</form>
	
</cfoutput>