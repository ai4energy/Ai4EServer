# pull latest julia image
FROM --platform=linux/amd64 julia:1.8

# create dedicated user
RUN useradd --create-home --shell /bin/bash genie

# set up the app
RUN mkdir /home/genie/app
COPY . /home/genie/app
WORKDIR /home/genie/app

# configure permissions
RUN chown -R genie:genie /home/

RUN chmod +x bin/repl
RUN chmod +x bin/server
RUN chmod +x bin/runtask

# switch user
USER genie

# instantiate Julia packages
RUN julia ./ENV.jl

# ports
EXPOSE 8081

# set up app environment
ENV JULIA_DEPOT_PATH "/home/genie/.julia"
ENV GENIE_ENV "dev"
ENV GENIE_HOST "0.0.0.0"
ENV PORT "8081"
ENV WSPORT "8081"
ENV EARLYBIND "true"

# run app
CMD ["bin/server"]

# or maybe include a Julia file
# CMD julia -e 'using Pkg; Pkg.activate("."); include("IrisClustering.jl"); '
