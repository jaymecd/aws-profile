aws-profile
==========

*Make AWS CLI profile switch easy, while working with many accounts.*

---

**NB!** *aws-profile* works **only** with Amazon AWSCLI (Python) package.

Java-based version is not supported.

For more details, please refer to [aws.amazon.com/cli](http://aws.amazon.com/cli/)

*Note: script was tested only in Bash* 

TODO:

1. create installer
2. replace php parse ini with awk 


Installation
---

Install AWS CLI Tools:

	$ pip install awscli
	
Install aws-profile:

	$ cp aws-profile aws-wrapper /usr/local/bin
	
Update resource file
---

Add following lines to `~/.profile` or `~/.bashrc` file:

	export PATH="/usr/local/bin:$PATH"

	# Amazon AWS Service CLI
	complete -C aws_completer aws
	alias aws-profile="source aws-profile"
	alias aws="aws-wrapper"

*Note: alias for **aws-profile** is required for transparent work, otherwise its requires to call via source manually, cause there is now way to expose environment variables back to parent.*

Setup config
---
Populate config `~/.aws/config` with desired profiles (refer AWS manual): 

	[profile secret-project]
	aws_access_key_id=SOME-ACCESS-KEY-1
	aws_secret_access_key=SOME-SECRET-KEY-1
	region=us-east-2
	
	[profile test-user]
	aws_access_key_id=SOME-ACCESS-KEY-2
	aws_secret_access_key=SOME-SECRET-KEY-2
	region=eu-west-1

Overview profile
---

To list profiles, run command without arguments:

	$ aws-profile
	
Output explained:

	AWS_DEFAULT_PROFILE  : ~                         <-- Current profile
	AWS_CONFIG_FILE      : /Users/nick/.aws/config   <-- Config file
	AWS_DEFAULT_REGION   : ~                         <-- Default region, if set
	AWS_DEFAULT_OUTPUT   : ~                         <-- Default output, if set
	
	Configured profiles  : secret-project test-user  <-- Allowed profiles

Switch between profiles
---
	
To switch aws profile, run command:

	$ aws-profile secret-project
	
Run AWS commands:
---

Since there is an alias for `aws` original call, nothing is changed, call it as usual:

    $ aws ec2 describe-instances --output text
    
Which gives output like:

	NB! Running AWS CLI Tools with secret-project profile.
	
	274082975067	r-8bebfdc4	226008221399
	… SOME OTHER DATA … 
	
P.S. console autocomplete still works like a charm. Try `aws TABTAB`

Bash PS1 prompt hint:
---

Update `.profile` or `.bashrc` with following code:

	function __ps_aws() {
	    [ $AWS_CONFIG_FILE ] && echo " (aws ${AWS_DEFAULT_PROFILE:-default})"
	}
	
	export PS1="\u@\h:\w\$(__ps_aws) \$ "
	
And it will looks something like that:
	
	nick@domain:~ (aws secret-project) $ _

---

FIN

P.P.S Patches are welcome
