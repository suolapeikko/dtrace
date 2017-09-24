#!/usr/sbin/dtrace -s

/* Snoop what is written in specific bash process */
/* You can use 'echo $$' for shell pid to find your bash window pid */
/* Script usage: sudo ./pidlogger.d -p <pid> */
/* (C) Suolapeikko */

#pragma D option quiet
#pragma D option switchrate=100hz

dtrace:::BEGIN
{
	printf("TEXT\n");
}

pid$target::read:entry
/(self->buf == NULL || self->buf == 0)/
{
	self->buf = arg1;
}
   
pid$target::read:return
/self->buf != NULL/
{
	this->text = (char *)copyin(self->buf, 1);
	printf("%s", stringof(this->text));
	self->buf = NULL;
}
