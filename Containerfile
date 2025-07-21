FROM alpine:3.22.1@sha256:4bcff63911fcb4448bd4fdacec207030997caf25e9bea4045fa6c8c44de311d1

LABEL org.opencontainers.image.description="NetOps Toolkit - Kubernetes Debugging Container"

# renovate: datasource=repology depName=alpine_3_22/bash versioning=loose
ENV BASH_VERSION="5.2.37-r0"
# renovate: datasource=repology depName=alpine_3_22/bash-completion versioning=loose
ENV BASH_COMPLETION_VERSION="2.16.0-r0"
# renovate: datasource=repology depName=alpine_3_22/bind-tools versioning=loose
ENV BIND_TOOLS_VERSION="9.20.11-r0"
# renovate: datasource=repology depName=alpine_3_22/conntrack-tools versioning=loose
ENV CONNTRACK_TOOLS_VERSION="1.4.8-r0"
# renovate: datasource=repology depName=alpine_3_22/curl versioning=loose
ENV CURL_VERSION="8.14.1-r1"
# renovate: datasource=repology depName=alpine_3_22/fping versioning=loose
ENV FPING_VERSION="5.3-r0"
# renovate: datasource=repology depName=alpine_3_22/git versioning=loose
ENV GIT_VERSION="2.49.1-r0"
# renovate: datasource=repology depName=alpine_3_22/htop versioning=loose
ENV HTOP_VERSION="3.4.1-r0"
# renovate: datasource=repology depName=alpine_3_22/iperf3 versioning=loose
ENV IPERF3_VERSION="3.19-r0"
# renovate: datasource=repology depName=alpine_3_22/iproute2 versioning=loose
ENV IPROUTE2_VERSION="6.15.0-r0"
# renovate: datasource=repology depName=alpine_3_22/ipset versioning=loose
ENV IPSET_VERSION="7.24-r0"
# renovate: datasource=repology depName=alpine_3_22/iputils versioning=loose
ENV IPUTILS_VERSION="20240905-r0"
# renovate: datasource=repology depName=alpine_3_22/jq versioning=loose
ENV JQ_VERSION="1.8.0-r0"
# renovate: datasource=repology depName=alpine_3_22/net-tools versioning=loose
ENV NET_TOOLS_VERSION="2.10-r3"
# renovate: datasource=repology depName=alpine_3_22/nmap versioning=loose
ENV NMAP_VERSION="7.97-r0"
# renovate: datasource=repology depName=alpine_3_22/nmap-ncat versioning=loose
ENV NMAP_NCAT_VERSION="7.97-r0"
# renovate: datasource=repology depName=alpine_3_22/nmap-scripts versioning=loose
ENV NMAP_SCRIPTS_VERSION="7.97-r0"
# renovate: datasource=repology depName=alpine_3_22/openssh versioning=loose
ENV OPENSSH_VERSION="10.0_p1-r7"
# renovate: datasource=repology depName=alpine_3_22/openssl versioning=loose
ENV OPENSSL_VERSION="3.5.1-r0"
# renovate: datasource=repology depName=alpine_3_22/tcpdump versioning=loose
ENV TCPDUMP_VERSION="4.99.5-r1"
# renovate: datasource=repology depName=alpine_3_22/vim versioning=loose
ENV VIM_VERSION="9.1.1566-r0"
# renovate: datasource=repology depName=alpine_3_22/wget versioning=loose
ENV WGET_VERSION="1.25.0-r1"
# renovate: datasource=repology depName=alpine_3_22/zsh versioning=loose
ENV ZSH_VERSION="5.9-r5"
# renovate: datasource=repology depName=alpine_3_22/yq-go versioning=loose
ENV YQ_GO_VERSION="4.46.1-r0"

RUN set -ex \
    && apk update \
    # && apk upgrade \ # Not needed for this image - we want reproducibility
    && apk add --no-cache \
        bash${BASH_VERSION:+=$BASH_VERSION} \
        bash-completion${BASH_COMPLETION_VERSION:+=$BASH_COMPLETION_VERSION} \
        bind-tools${BIND_TOOLS_VERSION:+=$BIND_TOOLS_VERSION} \
        conntrack-tools${CONNTRACK_TOOLS_VERSION:+=$CONNTRACK_TOOLS_VERSION} \
        curl${CURL_VERSION:+=$CURL_VERSION} \
        fping${FPING_VERSION:+=$FPING_VERSION} \
        git${GIT_VERSION:+=$GIT_VERSION} \
        htop${HTOP_VERSION:+=$HTOP_VERSION} \
        iperf3${IPERF3_VERSION:+=$IPERF3_VERSION} \
        iproute2${IPROUTE2_VERSION:+=$IPROUTE2_VERSION} \
        ipset${IPSET_VERSION:+=$IPSET_VERSION} \
        iputils${IPUTILS_VERSION:+=$IPUTILS_VERSION} \
        jq${JQ_VERSION:+=$JQ_VERSION} \
        net-tools${NET_TOOLS_VERSION:+=$NET_TOOLS_VERSION} \
        nmap${NMAP_VERSION:+=$NMAP_VERSION} \
        nmap-ncat${NMAP_NCAT_VERSION:+=$NMAP_NCAT_VERSION} \
        nmap-scripts${NMAP_SCRIPTS_VERSION:+=$NMAP_SCRIPTS_VERSION} \
        openssh${OPENSSH_VERSION:+=$OPENSSH_VERSION} \
        openssl${OPENSSL_VERSION:+=$OPENSSL_VERSION} \
        tcpdump${TCPDUMP_VERSION:+=$TCPDUMP_VERSION} \
        vim${VIM_VERSION:+=$VIM_VERSION} \
        wget${WGET_VERSION:+=$WGET_VERSION} \
        zsh${ZSH_VERSION:+=$ZSH_VERSION} \
        yq-go${YQ_GO_VERSION:+=$YQ_GO_VERSION} \
    && rm -rf /var/cache/apk/*  # Clean up cache to reduce layer size

# Install oh-my-zsh and plugins/themes
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true \
    && git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions \
    && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

COPY configs/zshrc .zshrc

CMD ["zsh"]
