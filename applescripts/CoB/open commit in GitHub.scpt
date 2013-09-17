-- set browser_ to "_Firefox latest release"
set browser_ to "Google Chrome"

set commit_ to the clipboard as text
set msg to ("Opening commit \"" & commit_ & "\" on GitHub. Choose Project:")

set projs to {"Genesis", "UserM", "ConfM", "RecordM", "WorkM", "IntegrationM", "ReportM", "Sigre2", "Sigre", "SigreReports"}

set chosen_ to (choose from list projs with prompt msg without multiple selections allowed) as text

if chosen_ is not "false" then
	do shell script "open -a '" & browser_ & "' 'http://github.com/cob/" & chosen_ & "/commit/" & commit_ & "'"
	
	tell application browser_ to activate
end if