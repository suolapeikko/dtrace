/* App trivial.c trace example */

/* Usage: sudo dtrace -s ./tracetrivial.d -p <pid> */
/* (C) Suolapeikko */

/* foo -method entry */
pid$target::foo:entry
{
	/* Pointer address */
	self->arg0 = arg0;

	/* The actual value */
    self->arg1 = arg1;
    
	printf("\nMethod 'foo' argument values on entry:\n");
	printf("*arg0 = %d\n", *(int *)copyin(self->arg0, 4));
	printf("*arg1 = %d\n", *(int *)copyin(self->arg1, 4));
}

/* foo -method return */
pid$target::foo:return
{
	printf("\nMethod 'foo' argument values on exit:\n");
	printf("*arg0 = %d\n", *(int *)copyin(self->arg0, 4));
	printf("*arg1 = %d\n", *(int *)copyin(self->arg1, 4));
	printf("return = %d\n", arg1);
}
