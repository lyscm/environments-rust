# [Required]
FROM scratch

ARG OWNER="lyscm"
ARG REPOSITORY_NAME="lyscm.common.tiers.rust"

LABEL org.opencontainers.image.source https://github.com/${OWNER}/${REPOSITORY_NAME}

# Install pip requirements
COPY extensions.zip .
