<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Starfinder / Fantasy Grounds XML to PDF Converter</title>

    <!-- Bootstrap core CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="/css/simple-sidebar.css" rel="stylesheet">

</head>
<cfoutput>
<body>

    <div id="wrapper" class="toggled">

        <!-- Sidebar -->
        <div id="sidebar-wrapper">
            <ul class="sidebar-nav">
                <li class="sidebar-brand">
                    <a href="#event.buildLink(to='Main.index')#">
                        SFRPG / FG PDF Converter
                    </a>
                </li>
                <li>
                    <a target="_blank" href="https://www.fantasygrounds.com/forums/forumdisplay.php?102-Starfinder">FG SFRPG Forum</a>
                </li>
                <li>
                    <a target="_blank" href="https://paizo.com/starfinder">Pazio's Starfinder RPG</a>
                </li>
                <li>
                    <a target="_blank" href="https://www.reddit.com/r/starfinder_rpg/comments/6w2ru4/interactive_pdf_sheets/">Schwar's PDF Sheets</a>
                </li>
                <li>
                    <a target="_blank" href="https://www.reddit.com/r/starfinder_rpg/comments/8d83mb/starfinder_community_resource_database/">SFRPG Resources</a>
                </li>
                <li>
                    <a target="_blank" href="#event.buildLink(to='Main.about')#">Credits / About</a>
                </li>
            </ul>
        </div>
        <!--- /#sidebar-wrapper --->

        <!-- Page Content -->
        <div id="page-content-wrapper">
            <div class="container-fluid">
				#renderView()#
				<hr />
				<div class="row mt-4">
					<a href="##menu-toggle" class="btn btn-secondary" id="menu-toggle">Toggle Menu</a>		
				</div>
			</div>
			
        </div>
        <!--- /##page-content-wrapper --->

    </div>
    <!--- /#wrapper --->

    <!-- Bootstrap core JavaScript -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.bundle.min.js"></script>

    <!-- Menu Toggle Script -->
    <script>
    $("##menu-toggle").click(function(e) {
        e.preventDefault();
        $("##wrapper").toggleClass("toggled");
    });
    </script>

</body>
</cfoutput>
</html>
