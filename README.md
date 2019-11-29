
# Creating a Openfisca Framework Images from S2I !!!

## Getting started

### Files and Directories  

##### assemble
Create an *assemble* script that will build our application, e.g.:
- build python modules
- bundle install ruby gems
- setup application specific configuration

The script can also specify a way to restore any saved artifacts from the previous image.   

#### Create the builder image
The following command will create a builder image named openfisca-backend based on the Dockerfile that was created previously.
```
docker build -t openfisca-backend .
```
The builder image can also be created by using the *make* command since a *Makefile* is included.

