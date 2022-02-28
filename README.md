# Asymetric_RSA_Powershell
I was browsing [Joel's PSRansom](https://github.com/JoelGMSec/PSRansom) (a ransomwre emulator) were he generate a random encryption key, he obfuscate it and then send it to the C2, and I thought it will be a better ransomware simulation if even if you can check the code, and see the obfuscation code, you couldn't get the encryption key.
For that you have to use asymetric encryption, generate a private key, from that generate a publci certificate, load it on the windows target machine, and use it only to encrypt the ransomware encryption key. Send it to the C2 and even if the traffic is sniffed or the code is made public you can not get the key, unless you have the private key to decrypt it. That is safe on the C2.

The objective was to do in on powershell, the documentation I found is not very clear, I'll try to fix that with these document/repository.

# The Certificates

Generate the certificate using openssl, to use a certificate in windows to encrypt files you need to pass some extra options to openssl that is key usage must have either keyEncipherment or dataEcipherment (we pass both) and in the Extended Key Usage field you have to had the value "Document Encryption" or in the case on opensll we have to use it's numeral value "1.3.6.1.4.1.311.80.1".
We pass that using a myconfig.cnf file, find the one I used as example in this repository


```
Highlights from myconfig.cnf

keyUsage = keyEncipherment , dataEncipherment
extendedKeyUsage = "1.3.6.1.4.1.311.80.1"
```

Generate the private key, and the public certificate typing:

```
openssl req -x509 -newkey rsa:4096 -keyout kabu_private.pem -out kabu_cert.pem -sha256 -config myconfig.cnf -extensions v3_req
```

