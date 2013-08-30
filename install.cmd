/************************************************************************/
/* install for run.exe                                                           */
/* Created: 4 Apr 1999                                                  */
/* Author: J. Pedone                                                    */
/* jpedone@flash.net                                                    */
/************************************************************************/
 
Call RxFuncAdd SYSLOADFUNCS, REXXUTIL, SYSLOADFUNCS
call SysLoadFuncs
Signal on Halt

workdir = Directory()
	If LastPos('\',workdir) <> Length(workdir) Then Do
		fworkdir=workdir||'\'
	End
	If LastPos('\',workdir) = Length(workdir) Then Do
		fworkdir=workdir
	End
 
	classname='WPProgram'
	title = 'Run'
	location = '<WP_DESKTOP>'
	setup = 'OBJECTID=<JWP_RUN>;'||,
	          'EXENAME='||fworkdir||'run.exe;'||,
	          'STARTUPDIR='workdir
	result = SysCreateObject(classname, title, location, setup, 'R')
	If result \= 1 Then 
	   Do
	      say 'Run...   Not created! Return code='result
	   End
	Say 'Run created'
Exit
 
Syntax:
	Say SourceLine(sigl)
	Say 'Syntax Error on line' sigl || ':'
	Say ErrorText(rc)
	Trace ?R ; NOP ; Exit
 
Halt:
	Exit
 
