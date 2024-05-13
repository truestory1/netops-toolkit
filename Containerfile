FROM alpine:3.19.1

# renovate: datasource=repology depName=alpine_3_19/bind-tools versioning=loose
ARG BIND_TOOLS_VERSION="9.18.24-r1"
# renovate: datasource=repology depName=alpine_3_19/conntrack-tools versioning=loose
ARG CONNTRACK_TOOLS_VERSION="1.4.8-r0"
# renovate: datasource=repology depName=alpine_3_19/curl versioning=loose
ARG CURL_VERSION="8.5.0-r0"
# renovate: datasource=repology depName=alpine_3_19/fping versioning=loose
ARG FPING_VERSION="5.1-r5"
# renovate: datasource=repology depName=alpine_3_19/git versioning=loose
ARG GIT_VERSION="2.43.0-r0"
# renovate: datasource=repology depName=alpine_3_19/htop versioning=loose
ARG HTOP_VERSION="3.2.2-r1"
# renovate: datasource=repology depName=alpine_3_19/iperf3 versioning=loose
ARG IPERF3_VERSION="3.16-r0"
# renovate: datasource=repology depName=alpine_3_19/iproute2 versioning=loose
ARG IPROUTE2_VERSION="6.6.0-r0"
# renovate: datasource=repology depName=alpine_3_19/ipset versioning=loose
ARG IPSET_VERSION="7.19-r2"
# renovate: datasource=repology depName=alpine_3_19/iputils versioning=loose
ARG IPUTILS_VERSION="20221126-r2"
# renovate: datasource=repology depName=alpine_3_19/jq versioning=loose
ARG JQ_VERSION="1.7.1-r0"
# renovate: datasource=repology depName=alpine_3_19/net-tools versioning=loose
ARG NET_TOOLS_VERSION="2.10-r3"
# renovate: datasource=repology depName=alpine_3_19/nmap versioning=loose
ARG NMAP_VERSION="7.94-r0"
# renovate: datasource=repology depName=alpine_3_19/nmap-ncat versioning=loose
ARG NMAP_NCAT_VERSION="7.94-r0"
# renovate: datasource=repology depName=alpine_3_19/nmap-scripts versioning=loose
ARG NMAP_SCRIPTS_VERSION="7.94-r0"
# renovate: datasource=repology depName=alpine_3_19/openssh versioning=loose
ARG OPENSSH_VERSION="9.6_p1-r0"
# renovate: datasource=repology depName=alpine_3_19/openssl versioning=loose
ARG OPENSSL_VERSION="3.1.4-r6"
# renovate: datasource=repology depName=alpine_3_19/tcpdump versioning=loose
ARG TCPDUMP_VERSION="4.99.4-r1"
# renovate: datasource=repology depName=alpine_3_19/vim versioning=loose
ARG VIM_VERSION="9.0.2127-r0"
# renovate: datasource=repology depName=alpine_3_19/wget versioning=loose
ARG WGET_VERSION="1.21.4-r0"
# renovate: datasource=repology depName=alpine_3_19/zsh versioning=loose
ARG ZSH_VERSION="5.9-r2"

RUN set -ex \
    && apk update \
    && apk upgrade \
    && apk add --no-cache \
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
        zsh${ZSH_VERSION:+=$ZSH_VERSION} \
    && rm -rf /var/cache/apk/*  # Clean up cache to reduce layer size

# Install oh-my-zsh and plugins/themes
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true \
    && git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions \
    && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

COPY configs/zshrc .zshrc

CMD ["zsh"]
