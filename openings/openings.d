#!/usr/sbin/dtrace -s

#pragma D option quiet

/* Trace file open calls per process exec */
/* (C) Suolapeikko */

dtrace:::BEGIN
{
	printf("%-15s %-15s %-12s %-25s %-25s\n", "TIME", "OPERATION", "PID", "PROCESS", "FILE");
}

syscall::open*:entry
/execname == $$1 && arg0 != NULL/
{
	printf("%-15Y %-15s %-12d %-25s %-25s\n", walltimestamp, "Open File", pid, execname, copyinstr(arg0));
}
