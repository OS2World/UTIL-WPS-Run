� �� 0  d   D1008  g 
 	prog_liste  ok_push� Cancelf  Browse_push�   error_dialog�   �  error_ok,  browser_setup6  5 web_browser/ 
Prog1_push4  7 ftp_browser0 
prog2_push1 browser_ok_push2 browser_cancel_push�  splash�  �  �  �  ��� 0G+  iniFunctions�/* INI File functions */
/* Called as:
	iniFunctions file [,application name; key name; value]

    Examples:
	iniFunctions set, test.ini , paths; download; f:\temp, paths; upload; f:\dragen\download, paths; program root; f:\dragen

	iniFunctions get apps, test.ini
		The values will be stored in appNames stem variable

	iniFunctions get keys, test.ini , paths
		The values will be stored in keyNames stem variable

	iniFunctions read, test.ini , paths; download;, paths; upload;, paths; program root;
		The values will be stored in iniValues stem variable

	iniFunctions delete app,test.ini , paths;;

	iniFunctions delete,test.ini , paths; download;
*/
parse arg function ',' file ',' appAndKeysAndData
Parse upper var function function
function = Strip(function)
file = Strip(file)
appAndKeysAndData = Strip(appAndKeysAndData)
x=0
Do while appAndKeysAndData > ''
	x=x+1
	parse var appAndKeysAndData app ';' key ';' data ',' .
	app.0 = x
	app.x = Strip(app)
	key.0 = x
	key.x = Strip(key)
	data.0 = x
	data.x = Strip(data)
	parse var appAndKeysAndData . ',' appAndKeysAndData
End


Select
	When function = 'SET' Then Do
		Do x = 1 to app.0
		      rc=sysini(file,app.x,key.x,data.x)
		End
	End /* when do */

	When function = 'READ' Then Do
		Drop iniValues
		Do x = 1 to app.0
			iniValues.0=x
			iniValues.x=sysini(file,app.x,key.x)
			If iniValues.x = 'ERROR:' Then Do
				iniValues.x = ''
			End
		End
	End /* when do */

	When function = 'DELETE' Then Do
		Do x = 1 to app.0
		      rc=sysini(file,app.x,key.x,'DELETE:')
		End
	End /* when do */

	When function = 'DELETE APP' Then Do
		Do x = 1 to app.0
		      rc=sysini(file,app.x,'DELETE:')
		End
	End /* when do */

	When function = 'GET KEYS' Then Do
		Drop keyNames
		Do x = 1 to app.0
		      rc=sysini(file,app.x,'ALL:',keyNames)
		End
	End /* when do */

	When function = 'GET APPS' Then Do
		Drop appNames
		rc=sysini(file,'ALL:',appNames)
	End /* when do */

	Otherwise Do
		Return 1
	end /* Otherwise */

end /* select */

check_internet�/* check for existance of internet programs */
	internetProg.1=strip(internetProg.1,B)
	internetProg.2=strip(internetProg.2,B)

Do n = 1 to 2
	parse upper var internetProg.n prog .
	drive_part=FileSpec('Drive',prog)

	Select 
		When prog = '' Then Do
			call not_found
			call internet
			Return
		End

		When drive_part='' Then Do
			prog=SysSearchPath('Path',prog)
			if prog='' Then Do
				Call not_found
				Call internet
				Return
			End
		End /* when */

		Otherwise Do
			Call SysFileTree prog, 'file', 'F'
			If file.0 = 0 Then Do
				Call not_found
				call internet
				Return
			End
		End /* otherwise */
	End /* select */
	parse var internetProg.n . parm
	internetProg.n = prog||' '||parm
End
/* write out the browser info */
	call iniFunctions 'set,'||pworkdir||'run.ini ,' ||,
		'browsers ; WEB Browser ; '||internetprog.1||',' ||,
		'browsers ; FTP Browser ; '||internetprog.2
internetW/* open the browser setup dialog */
	rc=browser_setup.open()
	call browser_setup.show	not_foundu/* the requested prog was not found */
	rc = D100.Visible(oldD100)
	rc=error_dialog.open()
	call error_dialog.showsave_history�/* save the history list */
	Call iniFunctions 'set,'||pworkdir||'run.ini, ' ||,
		'history ; history1 ; '||history.1||', '||,
		'history ; history2 ; '||history.2||', '||,
		'history ; history3 ; '||history.3||', '||,
		'history ; history4 ; '||history.4||', '||,
		'history ; history5 ; '||history.5||', '||,
		'history ; history6 ; '||history.6||', '||,
		'history ; history7 ; '||history.7||', '||,
		'history ; history8 ; '||history.8||', '||,
		'history ; history9 ; '||history.9||', '||,
		'history ; history10 ; '||history.10
history�/* strip blanks */
	do n = 1 to 10
		history.n = strip(history.n,'B')
	end

/* rebuild history list */
Select
	When D100.prog_list.Text()=history.10 Then Do
		historytemp=history.1
		history.1=history.10
		history.10=history.9
		history.9=history.8
		history.8=history.7
		history.7=history.6
		history.6=history.5
		history.5=history.4
		history.4=history.3
		history.3=history.2
		history.2=historytemp
		return
	End
	When D100.prog_list.Text()=history.9 Then Do
		historytemp=history.1
		history.1=history.9
		history.9=history.8
		history.8=history.7
		history.7=history.6
		history.6=history.5
		history.5=history.4
		history.4=history.3
		history.3=history.2
		history.2=historytemp
		return
	End
	When D100.prog_list.Text()=history.8 Then Do
		historytemp=history.1
		history.1=history.8
		history.8=history.7
		history.7=history.6
		history.6=history.5
		history.5=history.4
		history.4=history.3
		history.3=history.2
		history.2=historytemp
		return
	End
	When D100.prog_list.Text()=history.7 Then Do
		historytemp=history.1
		history.1=history.7
		history.7=history.6
		history.6=history.5
		history.5=history.4
		history.4=history.3
		history.3=history.2
		history.2=historytemp
		return
	End
	When D100.prog_list.Text()=history.6 Then Do
		historytemp=history.1
		history.1=history.6
		history.6=history.5
		history.5=history.4
		history.4=history.3
		history.3=history.2
		history.2=historytemp
		return
	End
	When D100.prog_list.Text()=history.5 Then Do
		historytemp=history.1
		history.1=history.5
		history.5=history.4
		history.4=history.3
		history.3=history.2
		history.2=historytemp
		return
	End
	When D100.prog_list.Text()=history.4 Then Do
		historytemp=history.1
		history.1=history.4
		history.4=history.3
		history.3=history.2
		history.2=historytemp
		return
	End
	When D100.prog_list.Text()=history.3 Then Do
		historytemp=history.1
		history.1=history.3
		history.3=history.2
		history.2=historytemp
		return
	End
	When D100.prog_list.Text()=history.2 Then Do
		historytemp=history.1
		history.1=history.2
		history.2=historytemp
		return
	End
	When D100.prog_list.Text()=history.1 Then Do
		return
	End
	Otherwise Do
	  	history.10=history.9
	  	history.9=history.8
	  	history.8=history.7
	  	history.7=history.6
	  	history.6=history.5
	  	history.5=history.4
	  	history.4=history.3
	  	history.3=history.2
	  	history.2=history.1
	  	history.1=D100.prog_list.Text()
	End
End
run_prog� /* hide the dialog */
	rc = D100.Visible(0)

/* reorder the history */
	call history

/* run the program */
/* check for internet stuff */
	firstFour = SubStr(D100.prog_list.text(),1,4)
	parse upper var firstFour firstFour .
	if firstFour = 'HTTP' | firstFour = 'WWW.' | firstFour = 'FTP:' | firstFour = 'FTP.' then do
		objectID = '<JWP_RUN_TEMP>'
		title = 'Browser'
		class = 'WPProgram'
		location = '<WP_NOWHERE>'
		If firstFour='HTTP' | firstFour = 'WWW.' Then Do
			parse var internetProg.1 prog parm
			setup = 'EXENAME='prog';' || ,
			'PARAMETERS='parm||' '||D100.prog_list.text()';' || ,
			'OBJECTID=' || objectID || ';' || ,
			'CONCURRENTVIEW=YES' || ';'
		End
		If firstFour='FTP:' | firstFour = 'FTP.' Then Do
			parse var internetProg.2 prog parm
			setup = 'EXENAME='prog';' || ,
			'PARAMETERS='parm||' '||D100.prog_list.text()';' || ,
			'OBJECTID=' || objectID || ';'|| ,
			'CONCURRENTVIEW=YES' || ';'
		End
 		rc = SysCreateObject( class, title, location, setup, 'R' )
		rc = SysOpenObject(objectID,0,1)
		call save_history
		If autoclose = 'YES' Then exit 0
		rc = D100.visible(1)
		Call SysSleep(1)
		Call D100.focus
		Return
	End

/* check for a blank entry */
	fileToRun=D100.prog_list.text()
	fileToRun = strip(fileToRun,'B')
	if fileToRun = '' Then Do
		Call not_found
		Return
	End 

/* set up for exe, com, cmd or bat (in order) */
	run.0 = 5
 	parse var fileToRun fileToRun parms
	run.1 = fileToRun||'.exe'
	run.2 = fileToRun||'.com'
	run.3 = fileToRun||'.cmd'
	run.4 = fileToRun||'.bat'
	run.5 = fileToRun

/* Change relative to absolute */
	drive_part=FileSpec('Drive',run.5) 
	If drive_part=' ' Then Do 
		Do i = 1 to 5
			fileToRun=SysSearchPath('Path',run.i)
			If fileToRun \= '' then leave
		End
	End 
	fileToRun = strip(fileToRun,'B')
	if fileToRun = '' Then Do
		Call not_found
		Return
	End

/* set up the extension */
	parse upper var fileToRun . '.' test .
	test = strip(test,'B')

/* run it */
	Select 

/* non-executable */
		When test \= 'EXE' & test \= 'COM' & test \= 'CMD' & test \= 'BAT' & test \= '' Then Do
			call sysOpenObject fileToRun,'Default','False'
			call save_history
			if autoclose = 'YES' Then exit 0
			rc = D100.visible(1)
			Call SysSleep(1)
			Call D100.focus
			Return
		End

/* Executable */
		When test = 'EXE' | test = 'COM' | test = 'CMD' | test = 'BAT' Then Do
			objectID = '<JWP_RUN_TEMP>'
			title = 'Run - '||fileToRun
			class = 'WPProgram'
			location = '<WP_NOWHERE>'
			setup = 'EXENAME='fileToRun';' || ,
			'PARAMETERS='||parms';' || ,
			'OBJECTID=' || objectID || ';'|| ,
			'CONCURRENTVIEW=YES' || ';' ,
			'WORKDIR='||cworkdir||';'
	 		rc = SysCreateObject( class, title, location, setup, 'R' )
			rc = SysOpenObject(objectID,0,1)
			call save_history
			If autoclose='YES' Then exit 0
			rc = D100.visible(1)
			Call SysSleep(1)
			Call D100.focus
			Return
		End

/* Executable no extension */
		When test = '' Then Do
			runDrive = FileSpec('Drive',fileToRun)
			runPath = FileSpec('Path',fileToRun)
			runName = FileSpec('Name',fileToRun)
			If autoclose='YES' Then exit 0
			run.0 = 4
			run.1 = runName||'.exe'
			run.2 = runName||'.com'
			run.3 = runName||'.cmd'
			run.4 = runName||'.bat'
			foundIt = 'FALSE'
			Do i = 1 to 4
				rc = stream(runDrive||runPath||run.i,'C','Q D')
				If rc \= '' Then Do
					fileToRun = runDrive||runPath||run.i
					foundIt = 'TRUE'
					Leave
				End
			End
			If foundIt = 'FALSE' Then Do
				Call not_found
				Return
			End
			objectID = '<JWP_RUN_TEMP>'
			title = 'Run - '||fileToRun
			class = 'WPProgram'
			location = '<WP_NOWHERE>'
			setup = 'EXENAME='fileToRun';' || ,
			'PARAMETERS='||parms';' || ,
			'OBJECTID=' || objectID || ';'|| ,
			'CONCURRENTVIEW=YES' || ';' ,
			'WORKDIR='||cworkdir||';'
	 		rc = SysCreateObject( class, title, location, setup, 'R' )
			rc = SysOpenObject(objectID,0,1)
			call save_history
			rc = D100.visible(1)
			Call SysSleep(1)
			Call D100.focus
			Return
		End

/* File not found */
		Otherwise Do
			call not_found 
		End
	End

get_data�/* read it in and add the contents to the combo box */
	Call iniFunctions 'read,'||pworkdir||'run.ini,' ||,
		'history ; history1 ; ,' ||,
		'history ; history2 ; ,' ||,
		'history ; history3 ; ,' ||,
		'history ; history4 ; ,' ||,
		'history ; history5 ; ,' ||,
		'history ; history6 ; ,' ||,
		'history ; history7 ; ,' ||,
		'history ; history8 ; ,' ||,
		'history ; history9 ; ,' ||,
		'history ; history10 ; '
	Do n = 1 to 10
  		history.n = iniValues.n
		rc = D100.prog_list.Add(history.n,n)
	End

�� �d 0    �  ��          � �  � \ � 1 d ���        ' � �  �  8����         �  �   �  g ����        �   �	  )  e ����        �   �K  )  �����           ��  )  f ����Run... 3   Enter a file or location to open below:  Ok Cancel Find � �d 0�   �   �      ~File -   �      ~Find     ~Run     E~xit     ~Preferences A   �     	 ~Browsers    
 ~Auto Close     ~Save Position     ~Help 6   �      ~Command Reference   @��    ~About ���d 0C   find�/* Get file */
  	browse = FilePrompt('*.*','Browse',ok,'Open')
/* Put it in the run box */
	rc = D100.prog_list.Text(browse) runcall run_prog exitexit 0	 internetCall Internet
 	autoclose�oldstate=d100.autoclose.menuchecked(1)
If oldstate=1 Then Do
	Call iniFunctions 'set,'||pworkdir||'run.ini, preferences ; autoclose ; NO'
	rc=D100.autoclose.menuchecked(0)
	autoclose = 'NO'
end	
If oldstate=0 Then Do
	Call iniFunctions 'set,'||pworkdir||'run.ini, preferences ; autoclose ; YES'
	rc=D100.autoclose.menuchecked(1)
	autoclose = 'YES'
end	 position�newpos = d100.position()
parse var newpos positionx positiony .
Call iniFunctions 'set,'||pworkdir||'run.ini, preferences ; positionx ; '||positionx||',preferences ; positiony ; '||positiony
  'view cmdref'
  !rc=splash.open()
rc=splash.focus���d 0e  �d Size(rc=d100.visible(0)
rc=d100.visible(1)
Init�/* author= J. Pedone (jpedone@flash.net) */
/* Load REXX UTIL functions */
/* INI file structure:
	app		key			notes

	browsers	FTP Browser		inivalues.1 (any valid program + arguments)
			WEB Browser		inivalues.2 (any valid program + arguments)

	History		history1 to history10	All keys may not be present (command line history)

	preferences	autoclose		inivalues.1 (either YES or NO - case sensitive)
			positionx		inivalues.2 (numeric)
			positiony		inivalues.3 (numeric)
*/

Call RxFuncAdd 'SysLoadFuncs', 'RexxUtil', 'SysLoadFuncs'
Call sysloadfuncs

/* Get current working directory */
	parse arg pworkdir
	If pworkdir = '' Then Do
		pworkdir=Directory()
	End

/* check for root */
	If LastPos('\',pworkdir) <> Length(pworkdir) Then Do
		pworkdir=pworkdir||'\'
	End

/* get current work directory */
	cworkdir=directory()
	If LastPos('\',cworkdir) <> Length(cworkdir) Then Do
		cworkdir=cworkdir||'\'
	End

/* set up some defaults */
  	file_found = ''
  	history=''
	internetProg=''
	oldD100=1
	bootDrive = left( value( "RUNWORKPLACE",, "OS2ENVIRONMENT" ),1 )
	bootDrive = left( bootDrive,1 ) || ":" 


/* get vars for ftp and web browser */
	call iniFunctions 'read,'||pworkdir||'run.ini , browsers; WEB Browser;, browsers; FTP Browser;'
	internetProg.0=iniValues.0
	Do n = 1 to 2
  		internetProg.n = iniValues.n
		If strip(internetProg.n,B) = '' Then Do
			internetProg.n= bootDrive||"\Netscape\Program\Netscape.exe"
		End
	End
	call check_internet

/* get history from run.ini */
  	Call get_data

/* get preferences */
	drop inivalues.
	Call iniFunctions 'read,'||pworkdir||'run.ini , preferences;autoclose;,preferences;positionx;,preferences;positiony;'
/* autoclose */
	autoclose = iniValues.1
	Select
		When autoclose = 'YES' then do
			rc=D100.autoclose.menuchecked(1)
		End
		When autoclose = 'NO' then do
			rc=D100.autoclose.menuchecked(0)
		End
		Otherwise
			Call iniFunctions 'set,'||pworkdir||'run.ini, preferences ; autoclose ; YES'
			rc=D100.autoclose.menuchecked(1)
			autoclose = 'YES'
	end	
/* position */
	positionx = iniValues.2
	positiony = inivalues.3
	Select
		When datatype(positionx) \= 'NUM' | datatype(positiony) \= 'NUM' then do
			positionx = 0
			positiony = 20
			rc=D100.position(positionx,positiony)
			Call iniFunctions 'set,'||pworkdir||'run.ini, preferences ; positionx ; '||positionx||',preferences ; positiony ; '||positiony
		End
		Otherwise
			rc=D100.position(positionx,positiony)
	end	

/* display the last command */
	rc = D100.prog_list.Select(1,'Select')
	rc = D100.Visible(1)
�f Click�/* Get file */
  	browse = FilePrompt('*.*','Browse',ok,'Open')
/* Put it in the run box */
	rc = D100.prog_list.Text(browse)��Clickexit 0�e Click1/* reorder history and run prog */
call run_prog�g Entercall run_prog����d 0Q   f Click to Find a Program�Click to Exite Click to rung Enter program to run�� �� 0�   �   �  ��          h @ �� b j 0 � ��n         r �	  X  � � ��        �  �  5  � ����Error 3   File not found !!             Ok ���� 0T   �� Exitcall D100.focus�� Click1/* close error dialog */
rc=error_dialog.close()�� �,0t  t  �  ��            �k U � H ,��4        8� < �  6����         D � . � 	 5��E        M  �� - 6  /����        Q � ! �  4����         ] �  � 	 7��^        f  ��  6  0����        j  �7  5  1����        m  �w  5  2����Internet Browser Set-up    Web Browser   �     Web FTP Browser   �     FTP Ok Cancel ���,0   �,Init�/* fill in the boxes */
	rc  = browser_setup.web_browser.Text(internetProg.1)
	rc  = browser_setup.ftp_browser.Text(internetProg.2)
/* give the ok button the focus */
	CALL browser_setup.browser_ok_push.Focus
�2Click3/* close error dialog */
	rc=browser_setup.close()�1Click�/* save browser data */
	internetProg.1 = browser_setup.web_browser.Text()
	internetProg.2 = browser_setup.ftp_browser.Text()
/* write out the browser info */
	call iniFunctions 'set,'||pworkdir||'run.ini , browsers;WEB Browser;'||internetprog.1||',browsers; FTP Browser;'||internetprog.2
	rc = browser_setup.close()
	call check_internet

�0Click�/* get the ftp browser */
	internetProgTemp2 = FilePrompt('*.exe','FTP Browser',ok,'Open')
/* put it in the box */
	rc  = browser_setup.ftp_browser.Text(internetProgTemp2)
�/Click�/* get the web browser */
	internetProgTemp1 = FilePrompt('*.exe','Web Browser',ok,'Open')
/* put it in the box */
	rc  = browser_setup.web_browser.Text(internetProgTemp1)



�� ��0�   �   �  ��          �   �� S � B ����         � � 2 |  �����        �  � $ |  �����        �  �  | 
 �����        �   �'  6 
 �����About...    Author: J. Pedone jpedone@flash.net Build: 0328001314 Ok ����0+   ��Click rc=splash.close()
rc=D100.focus�