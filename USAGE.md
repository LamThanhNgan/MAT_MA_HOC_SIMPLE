## Usage
### Setup
**Setup** generates the public key and the master key
~~~bash
./setup [pk] [mk]
~~~
- pk: path to generate public key
- mk: path to generate master key

### Keygen
**Keygen** generates the secret key with attributes
~~~bash
./keygen [sk] [pk] [mk] [no] [a1] ... [aN]
~~~
- sk: path to generate secret key
- pk: path to public key
- mk: path to master key
- no: number of attributes in generated secret key
- a1 ... aN: attributes

### Encrypt
**Encrypt** encrypts plaintext to ciphertext
~~~bash
./enc [pk] [pt] [ap] [ct]
~~~	
- pk: path to public key
- pt: path to original file (plaintext)
- ap: access policy
- ct: path to encrypted file (ciphertext)

### Decrypt
**Decrypt** decrypts ciphertext to plaintext
~~~bash
./dec [pk] [sk] [ct] [pt]
~~~
- pk: path to public key
- sk: path to secret key
- ct: path to encrypted file (ciphertext)
- pt: path to original file (plaintext)

### Encrypt / Decrypt
Previous examples encrypt and decrypt files. In this example, you can encrypt / decrypt input data.
~~~bash
./encdec [pk] [sk] [ap]
./encdecb [pk] [sk] [ap]
~~~
- pk: path to public key
- sk: path to secret key
- ap: access policy
