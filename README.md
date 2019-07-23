Monitor
===
```
                       _ _             
 _ __ ___   ___  _ __ (_) |_ ___  _ __ 
| '_ ` _ \ / _ \| '_ \| | __/ _ \| '__|
| | | | | | (_) | | | | | || (_) | |   
|_| |_| |_|\___/|_| |_|_|\__\___/|_| By wacker 2019   
```
This is a ShellScript Framework, to run your Scripts.
If scripts failed, then it will report by API, also let you know output.

How did it work?
---
Format like this.
```
./run.sh [Type] [Script Name]
```

EXAMPLE:
```
./run.sh check error_test.sh
```

First, I let script split 4 parts.
- **Adjust** : Will change any file or server status.
- **Check** : Only to check file or server status.
- **Recover** : If script Failed, will run this try to recover.
	(Also this one failed, then KISScript will report this too.)
- **Report** : Use default way, to report message. or custom by yourself.

Only **Recover** and **Report** directorys, is must to be exist.
Other directorys, you can definition by yourself.

Point is, definition directorys and script name, it's let you identify what this script do.
And this script will check, any non-zero status exist.

How to Install?
---
1. You only need, make sure system have them first.
	- curl 7.19 or higher
	- bash 4.1 or higher
2. Put your Scripts on "adjust" or "check" directorys.
3. Change REPORT_WAY or REPORT_API on "config.sh".
4. You can run this command, to test REPORT function working.
	```
	./run.sh check error_test.sh
	```
5. Now, You can use the same way, to run every script in directorys.
