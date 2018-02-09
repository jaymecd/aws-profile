aws-profile
==========

*Make AWS CLI profile switch easy, while working with many accounts.*
*The bash exporter is really useful to avoid running commands in the wrong account*

---

**NB!** *aws-profile* works **only** with Amazon AWSCLI (Python) package.

Java-based version is not supported (for now).

For more details, please refer to [aws.amazon.com/cli](http://aws.amazon.com/cli/)

*Note: script was tested only in Bash* 

Installation
---

Install AWS CLI Tools:

	$ pip install awscli
	$ sudo apt-get install php5-cli
	
Install aws-profile:

	$ curl -sSL https://raw.github.com/Home24/aws-profile/master/install.sh | sh
	
Or via clone:

	$ git clone https://github.com/Home24/aws-profile.git
	$ cp aws-profile/aws-* /usr/local/bin
	
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
Populate config `~/.aws/credentials` with desired profiles (refer AWS manual): 

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

	AWS_DEFAULT_PROFILE  : default                   <-- Current profile
	AWS_CONFIG_FILE      : /Users/nick/.aws/credentials   <-- Config file
	AWS_DEFAULT_REGION   : ~                         <-- Default region, if set
	AWS_DEFAULT_OUTPUT   : ~                         <-- Default output, if set
	
	Configured profiles  : secret-project test-user  <-- Allowed profiles

Switch between profiles
---
	
To switch aws profile to *secret-project*, run command:

	$ aws-profile secret-project
	
To reset back to default, run command:

	$ aws-profile +
	
To switch aws profiles off, run command:

	$ aws-profile -
	
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
