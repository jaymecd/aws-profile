aws-switch
==========

*Make AWS CLI profile switch easy, while working with many accounts.*

---

**NB!** *aws-switch* works **only** with Amazon AWSCLI (Python) package.

Java-based version is not supported.

For more details, please refer to [aws.amazon.com/cli](http://aws.amazon.com/cli/)

*Note: script was tested only in Bash* 

TODO:

1. create installer
2. ...


Installation
---

Install AWS CLI Tools:

	$ pip install awscli
	
Install aws-switch:

	$ cp aws-switch aws-exec /usr/local/bin
	
Update resource file
---

Add following lines to `~/.profile` or `~/.bashrc` file:

	# Amazon AWS Service CLI
	complete -C aws_completer aws
	alias aws-switch="source aws-switch"
	alias aws="aws-exec"

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

To list profiles, run command:

	$ aws-switch
	
Output explained:

	AWS_DEFAULT_PROFILE  : ~                         <-- Current profile
	AWS_CONFIG_FILE      : /Users/nick/.aws/config   <-- Config file
	AWS_DEFAULT_REGION   : ~                         <-- Default region, if set
	AWS_DEFAULT_OUTPUT   : ~                         <-- Default output, if set
	
	Configured profiles  : secret-project test-user  <-- Allowed profiles

Switch between profiles
---
	
To switch aws profile, run command:

	$ aws-switch secret-project
	
Run AWS commands:
---

Since there is an alias for `aws` original call, nothing is changed, call it as usual:

    $ aws ec2 describe-instances --output text
    
Which gives output like:

	NB! Running AWS CLI Tools with secret-project profile.
	
	274082975067	r-8bebfdc4	226008221399
	… SOME OTHER DATA … 
	
P.S. console autocomplete still works like a charm.

---

FIN

P.P.S Patches are welcome
