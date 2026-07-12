GPG has been around for a long time, but it's not as secure as it should be, it's complicated, and it's slowly being phased out for more secure and simpler tools. One way to sign documents and files is by using SSH.

## Signing Files

First, start by creating or choosing a file. In this case it'll be called `file.txt`: `touch file.txt`.

Then we need to sign this document using SSH keys:

```bash
ssh-keygen -Y sign -f ~/.ssh/id_ed22519 -n file file.txt
```

- `-Y sign`: This makes SSH enter cryptographic verification mode, with the subcommand `sign` specifying the actions that need to be taken, in this case signing a file.
- `-n file`: Sets the namespace to "file". Using this prevents a malicious actor from attempting to take a signature and using it to authenticate an SSH login on a server.

When this is run, a .sig file is generated. In this case: `file.txt.sig`. The signature file must be sent along with the original file in order for the two to be cryptographically matched. 

## Verifying Files

```bash
ssh-keygen -Y verify -f allowed_signers -I name@email.com -n file -s file.txt.sig < file.txt
```

In order to verify the file and authenticate trust, a file will be needed with the correct public SSH key as well as an email address. The person wanting to authenticate the file will need to create this file and add the relevant details. In this example, the file would look like this:

```
name@email.com ssh-ed25519 AAAAC3Nz...
```

We'll call this file `allowed_signers`, and point to it with with the `-f allowed_signers` option, as is shown in the above command.

- `-I name@email.com`: This is the identity that we are checking against.
- `s file.txt.sig`: Stands for **signature**, and we are telling SSH where this file is.
- `< file.txt`: We use the redirect operator here so that we can push the contents of the `file.txt` file back to `file.txt.sig` in order calculate and compare the hashes.
