Passwords
=========
Basic Rails/OpenSSL password management system. 

Encryption
==========
Raw passwords are not kept in the database. A separate database entry is created for each user that has access to a password, containing the actual password after encryption with that user's public key. The raw password can only be decrypted by that user's private key, which is stored in the database encrypted with the user's own raw password (which is only kept in the database as a hash).

Security
========
Security is managed by groups: members of a group are able to view and edit all passwords in a group, and add/remove other members. Sub-groups do not inherit permissions from their parent groups, nor the other way around, so a user must be a member of the group that the password is linked to before they can see that password's value (or edit the password)
