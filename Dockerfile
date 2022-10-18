# pull latest julia image
FROM --platform=linux/amd64 julia:latest

# set up the app
RUN mkdir /home/app
COPY . /home/app
WORKDIR /home/app

# instantiate Julia packages
RUN julia ./ENV.jl

# ports
EXPOSE 8081

# run app
CMD julia -e "using Pkg; Pkg.activate(\".\"); Pkg.instantiate(); include(\"server.jl\");" 

