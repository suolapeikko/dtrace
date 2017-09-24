#!/usr/sbin/dtrace -s

/* DTrace script to monitor TCP SEND and RECEIVE commands */
/* (C) Suolapeikko */

#pragma D option quiet
/* #pragma D option switchrate=100hz */

/* Print header */
dtrace:::BEGIN
{
        printf("%-20s %-15s %-32s %-15s %-15s\n", "APPLICATION",
            "DIRECTION", "CONVERSATION", "PORT", "FLAGS");
}

/* Print TCP Send information */
tcp:mach_kernel:tcp_output:send
{
	/* Destination address */
	this->daddress = args[2]->ip_daddr;
	/* Local address */
	this->laddress = args[2]->ip_saddr;
	/* Destination port */
	this->dport = args[4]->tcp_dport;
	/* TCP flag */
	this->dflags = args[4]->tcp_flags;
	/* Direction concatenation */
	this->sdirection = strjoin(this->laddress, "->");
	this->sdirection = strjoin(this->sdirection, this->daddress);
	/* Output */
  	printf("%-20s %-15s %-32s %-16d", execname, "TCP/SEND", this->sdirection, this->dport);
  	
}

/* Print TCP Receive information */
tcp:mach_kernel:tcp_input:receive
{
	/* Sender address */
	this->saddress = args[2]->ip_saddr;
	/* Receiver address */
	this->raddress = args[2]->ip_daddr;
	/* Sender port */
	this->sport = args[4]->tcp_sport;
	/* TCP flag */
	this->sflags = args[4]->tcp_flags;
	/* Direction concatenation */
	this->rdirection = strjoin(this->saddress, "->");
	this->rdirection = strjoin(this->rdirection, this->raddress);
	/* Output */	
  	printf("%-20s %-15s %-32s %-16d", execname, "TCP/RECEIVE", this->rdirection, this->sport);
}

/* Print in both cases (flag) */
tcp:mach_kernel:tcp_output:send
, tcp:mach_kernel:tcp_input:receive
{
    printf("%s", args[4]->tcp_flags & TH_FIN ? "FIN " : "");
    printf("%s", args[4]->tcp_flags & TH_SYN ? "SYN " : "");
    printf("%s", args[4]->tcp_flags & TH_RST ? "RST " : "");
    printf("%s", args[4]->tcp_flags & TH_PUSH ? "PUSH " : "");
    printf("%s", args[4]->tcp_flags & TH_ACK ? "ACK " : "");
    printf("%s", args[4]->tcp_flags & TH_URG ? "URG " : "");
    printf("%s", args[4]->tcp_flags & TH_ECE ? "ECE " : "");
    printf("%s", args[4]->tcp_flags & TH_CWR ? "CWR " : "");
    printf("%s", args[4]->tcp_flags == 0 ? "null " : "");
    printf("\n");  	
}
