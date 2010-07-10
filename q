Usage: stg import [options] [<file>|<url>]

Import a GNU diff file as a new patch

Options:
  -m, --mail            Import the patch from a standard e-mail file
  -M, --mbox            Import a series of patches from an mbox file
  -s, --series          Import a series of patches
  -u, --url             Import a patch from a URL
  -n NAME, --name=NAME  Use NAME as the patch name
  -p N, --strip=N       Remove N leading slashes from diff paths (default 1)
  -t, --stripname       Strip numbering and extension from patch name
  -i, --ignore          Ignore the applied patches in the series
  --replace             Replace the unapplied patches in the series
  -b BASE, --base=BASE  Use BASE instead of HEAD for file importing
  --reject              Leave the rejected hunks in corresponding *.rej files
  -e, --edit            Invoke an editor for the patch description
  -d, --showdiff        Show the patch content in the editor buffer
  -a "NAME <EMAIL>", --author="NAME <EMAIL>"
                        Use "NAME <EMAIL>" as the author details
  --authname=AUTHNAME   Use AUTHNAME as the author name
  --authemail=AUTHEMAIL
                        Use AUTHEMAIL as the author e-mail
  --authdate=AUTHDATE   Use AUTHDATE as the author date
  --sign                Add "Signed-off-by:" line
  --ack                 Add "Acked-by:" line
  -h, --help            show this help message and exit
