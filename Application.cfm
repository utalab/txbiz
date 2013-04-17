<cfapplication	name="#hash( getCurrentTemplatePath() )#"
				sessionManagement = "yes"
				sessionTimeout = "#CreateTimeSpan(0, 1, 0, 0)#">
				
