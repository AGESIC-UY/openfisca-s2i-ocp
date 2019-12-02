
## Creating a Openfisca Framework Template using S2I strategy

This repository contains the Dockerfile file and the necessary scripts as sources for the construction of the base image. Necessary object (builder image) for the construction of the final image of the application using an s2i strategy.

### Template Instantiation
```
oc create -f Template.yaml
```